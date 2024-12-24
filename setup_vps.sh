#!/bin/bash

# ---------------------------------------------
# Renkler (isteğe bağlı, terminal çıktısı için)
# ---------------------------------------------
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# ---------------------------------------------
# Disk adı (lsblk ile kontrol ettiniz: /dev/vda)
# ---------------------------------------------
DISK_DEVICE="/dev/vda"

# ---------------------------------------------
# 1) Temizlik (cleanup) fonksiyonu
#    Haftalık (cron) veya manuel çağrılır.
# ---------------------------------------------
cleanup() {
  echo -e "${GREEN}--- Weekly Cleanup Started ---${NC}"

  # 1) /var/log altındaki log dosyalarını sıfırla
  echo -e "${GREEN}[1/7] Truncating log files in /var/log...${NC}"
  find /var/log -type f -name "*.log" -exec truncate -s 0 {} \;

  # 2) /tmp, /var/tmp, /root/.cache altındaki dosyaları sil
  echo -e "${GREEN}[2/7] Removing temporary files (/tmp, /var/tmp, /root/.cache)...${NC}"
  rm -rf /tmp/*
  rm -rf /var/tmp/*
  rm -rf /root/.cache/*

  # 3) Bellek önbelleğini (caches) boşalt
  echo -e "${GREEN}[3/7] Dropping Linux filesystem caches...${NC}"
  sync
  echo 3 > /proc/sys/vm/drop_caches

  # 4) Kullanılmayan paketleri kaldır
  echo -e "${GREEN}[4/7] Autoremoving unused packages...${NC}"
  apt-get autoremove --purge -y
  apt-get clean

  # 5) Docker disk kullanımını göster
  echo -e "${GREEN}[5/7] Displaying Docker system disk usage...${NC}"
  docker system df

  # 6) Kullanılmayan (dangling) volumelar var mı?
  echo -e "${GREEN}[6/7] Checking for dangling Docker volumes...${NC}"
  docker volume ls -f dangling=true

  # 7) Docker kullanılmayan verileri sil
  echo -e "${GREEN}[7/7] Pruning unused Docker data...${NC}"
  docker system prune -f

  echo -e "${GREEN}--- Cleanup Completed!${NC}"
}

# ---------------------------------------------
# 2) Kurulum (setup) fonksiyonu
#    Swap, Docker, Chromium, vb. kurulumları yapar.
# ---------------------------------------------
setup() {
  echo -e "${GREEN}>>> Checking /swapfile status...${NC}"
  if [ ! -f /swapfile ]; then
    echo -e "${GREEN}>>> Creating 10GB Swap...${NC}"
    dd if=/dev/zero of=/swapfile bs=1M count=10240 status=progress
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile swap swap defaults 0 0" | tee -a /etc/fstab
  else
    echo -e "${GREEN}/swapfile already exists, skipping creation.${NC}"
  fi

  echo -e "${GREEN}>>> Updating system packages...${NC}"
  apt-get update && apt-get upgrade -y
  echo -e "${GREEN}>>> System update completed.${NC}"

  echo -e "${GREEN}>>> Installing Docker & dependencies...${NC}"
  apt-get install -y ca-certificates curl gnupg lsb-release
  mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt-get update
  apt-get install -y docker-ce docker-ce-cli containerd.io
  echo -e "${GREEN}>>> Docker installation completed.${NC}"

  echo -e "${GREEN}>>> Installing Docker Compose (latest release)...${NC}"
  curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  echo -e "${GREEN}>>> Docker Compose installation completed.${NC}"

  # ---------------------------------------------
  # ESKİ CHROMIUM CONTAINER ÇAKIŞMALARINI ÖNLEME
  # ---------------------------------------------
  echo -e "${GREEN}>>> Removing old Chromium container (if exists)...${NC}"
  # Docker Compose V2'de "docker compose" komutu, V1'de "docker-compose"
  # Aşağıdaki "down" ile varsa eski container durur ve silinir.
  mkdir -p "$HOME/chromium"
  cd "$HOME/chromium" || exit 1

  # (Burası: eğer önceki scriptler "chromium" container_name ile çalıştıysa, "down" yapmak faydalı olur)
  if [ -f docker-compose.yaml ] || [ -f docker-compose.yml ]; then
    docker-compose down || true
  fi

  # ---------------------------------------------
  # YENİ DOCKER-COMPOSE.YAML OLUŞTUR
  # ---------------------------------------------
  echo -e "${GREEN}>>> Creating Docker Compose file for Chromium...${NC}"
  cat <<EOL > docker-compose.yaml
services:
  chromium:
    image: lscr.io/linuxserver/chromium:latest
    container_name: chromium
    security_opt:
      - seccomp:unconfined
    environment:
      - CUSTOM_USER=admin
      - PASSWORD=admin
      - PUID=1000
      - PGID=1000
      - TZ=$(timedatectl | grep "Time zone" | awk '{print $3}')
      - LANG=tr_TR.UTF-8
      - CHROME_CLI=https://google.com/
      - CHROME_FLAGS=--disable-gpu
    volumes:
      - /root/chromium/config:/config
    ports:
      - 3010:3000
      - 3011:3001
    shm_size: "1gb"
    restart: unless-stopped
EOL
  echo -e "${GREEN}>>> Docker Compose file created.${NC}"

  echo -e "${GREEN}>>> Starting Chromium container...${NC}"
  # Mevcut dizinde (~/chromium) docker-compose.yaml var
  docker-compose up -d
  cd ~ || exit 1
  echo -e "${GREEN}>>> Chromium is up and running.${NC}"

  # ---------------------------------------------
  # Performans Araçları
  # ---------------------------------------------
  echo -e "${GREEN}>>> Installing performance tools...${NC}"
  apt-get install -y bpytop hdparm sysbench speedtest-cli
  echo -e "${GREEN}>>> Tools installed (bpytop, hdparm, sysbench, speedtest-cli).${NC}"

  # ---------------------------------------------
  # Performans Testleri
  # ---------------------------------------------
  echo -e "${GREEN}>>> Running performance tests...${NC}"
  # Speedtest bazen 403 verir, engelli IP'de olabilir
  speedtest-cli > speedtest.txt 2>&1 || echo "Speedtest might be blocked or returned an error."
  sysbench memory --memory-block-size=1M --memory-total-size=4G run > ram_benchmark.txt
  hdparm -Tt "$DISK_DEVICE" > disk_benchmark.txt 2>&1 || echo "Check your disk device name."

  echo -e "${GREEN}>>> Performance tests completed. Results below:${NC}"
  cat speedtest.txt
  cat ram_benchmark.txt
  cat disk_benchmark.txt

  # ---------------------------------------------
  # Haftalık Temizlik cron job
  # ---------------------------------------------
  echo -e "${GREEN}>>> Adding weekly cleanup cron job (Sundays at 04:00)...${NC}"
  (crontab -l 2>/dev/null; echo "0 4 * * 0 /root/setup_vps.sh cleanup >> /root/cleanup.log 2>&1") | crontab -
  
  echo -e "${GREEN}>>> Setup complete!${NC}"
}

# ---------------------------------------------
# 3) Script Giriş Noktası
#    - "./setup_vps.sh"            => setup
#    - "./setup_vps.sh cleanup"    => temizlik
# ---------------------------------------------
if [ "$1" == "cleanup" ]; then
  cleanup
else
  setup
fi
