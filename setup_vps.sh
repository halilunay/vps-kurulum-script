#!/bin/bash

# -------------------------------------------------------
# 1) RENK DEĞİŞKENLERİ (Opsiyonel, daha okunabilir çıktı için)
# -------------------------------------------------------
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# -------------------------------------------------------
# 2) TEMİZLİK (cleanup) FONKSİYONU
#    Bu fonksiyon haftalık olarak (veya manuel) çalışır.
#    Log dosyalarını, geçici klasörleri, kullanılmayan
#    Docker verilerini temizler.
# -------------------------------------------------------
cleanup() {
  echo -e "${GREEN}--- Weekly Cleanup Started ---${NC}"

  echo -e "${GREEN}[1/8] Truncating log files in /var/log ...${NC}"
  find /var/log -type f -name "*.log" -exec truncate -s 0 {} \;

  echo -e "${GREEN}[2/8] Removing temporary files (/tmp, /var/tmp, /root/.cache) ...${NC}"
  rm -rf /tmp/*
  rm -rf /var/tmp/*
  rm -rf /root/.cache/*

  echo -e "${GREEN}[3/8] Dropping Linux filesystem caches ...${NC}"
  sync
  echo 3 > /proc/sys/vm/drop_caches

  echo -e "${GREEN}[4/8] Autoremoving unused packages ...${NC}"
  apt-get autoremove --purge -y
  apt-get clean

  echo -e "${GREEN}[5/8] Displaying Docker system disk usage ...${NC}"
  docker system df

  echo -e "${GREEN}[6/8] Checking for dangling Docker volumes ...${NC}"
  docker volume ls -f dangling=true

  echo -e "${GREEN}[7/8] Pruning unused Docker data ...${NC}"
  docker system prune -f

  echo -e "${GREEN}[8/8] Cleanup completed!${NC}"
}

# -------------------------------------------------------
# 3) KURULUM (setup) FONKSİYONU
#    Bu fonksiyon sunucuyu ilk defa hazırlarken kullanılır.
#    Swap oluşturur, günceller, Docker kurar, Chromium
#    container'ını ayağa kaldırır, vb.
# -------------------------------------------------------
setup() {
  echo -e "${GREEN}>>> Creating 10GB Swap ...${NC}"
  dd if=/dev/zero of=/swapfile bs=1M count=10240 status=progress
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo "/swapfile swap swap defaults 0 0" | tee -a /etc/fstab
  echo -e "${GREEN}>>> Swap has been successfully created.${NC}"

  echo -e "${GREEN}>>> Updating system packages ...${NC}"
  apt-get update && apt-get upgrade -y
  echo -e "${GREEN}>>> System update completed.${NC}"

  echo -e "${GREEN}>>> Installing Docker and dependencies ...${NC}"
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

  echo -e "${GREEN}>>> Installing Docker Compose (latest release) ...${NC}"
  # "latest" URL always points to the newest stable release on GitHub
  curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  echo -e "${GREEN}>>> Docker Compose installation completed.${NC}"

  echo -e "${GREEN}>>> Creating Docker Compose file for Chromium ...${NC}"
  mkdir -p $HOME/chromium
  cat <<EOL > $HOME/chromium/docker-compose.yaml
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
  echo -e "${GREEN}>>> Chromium Docker Compose file created.${NC}"

  echo -e "${GREEN}>>> Starting Chromium container ...${NC}"
  docker-compose -f $HOME/chromium/docker-compose.yaml up -d
  echo -e "${GREEN}>>> Chromium is running successfully.${NC}"

  echo -e "${GREEN}>>> Installing monitoring & performance tools ...${NC}"
  apt-get install -y bpytop hdparm sysbench speedtest-cli
  echo -e "${GREEN}>>> Tools installed: bpytop, hdparm, sysbench, speedtest-cli.${NC}"

  echo -e "${GREEN}>>> Running performance tests ...${NC}"
  speedtest-cli > speedtest.txt
  sysbench memory --memory-block-size=1M --memory-total-size=4G run > ram_benchmark.txt
  hdparm -Tt /dev/vda > disk_benchmark.txt
  echo -e "${GREEN}>>> Performance tests completed. See the results below:${NC}"
  cat speedtest.txt
  cat ram_benchmark.txt
  cat disk_benchmark.txt

  echo -e "${GREEN}>>> Adding weekly cleanup cron job ...${NC}"
  # Automatically runs the cleanup routine every Sunday at 04:00 AM
  (crontab -l 2>/dev/null; echo "0 4 * * 0 /root/setup_vps.sh cleanup >> /root/cleanup.log 2>&1") | crontab -
  echo -e "${GREEN}>>> Setup is complete. Enjoy your new server!${NC}"
}

# -------------------------------------------------------
# 4) SCRIPT AKIŞI: Parametre Kontrolü
#    - "./setup_vps.sh" (parametresiz) => kurulum
#    - "./setup_vps.sh cleanup" => temizlik
# -------------------------------------------------------
if [ "$1" == "cleanup" ]; then
  cleanup
else
  setup
fi
