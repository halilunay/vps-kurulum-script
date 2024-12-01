#!/bin/bash

# Renkli çıktılar için değişkenler
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}>>> Swap alanı oluşturuluyor (10 GB)...${NC}"
sudo dd if=/dev/zero of=/swapfile bs=1M count=10240 status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab
echo -e "${GREEN}>>> Swap alanı başarıyla oluşturuldu.${NC}"

echo -e "${GREEN}>>> Sistem güncelleniyor...${NC}"
sudo apt-get update && sudo apt-get upgrade -y
echo -e "${GREEN}>>> Sistem güncellemesi tamamlandı.${NC}"

echo -e "${GREEN}>>> Docker ve bağımlılıklar kuruluyor...${NC}"
sudo apt-get install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io
echo -e "${GREEN}>>> Docker kurulumu tamamlandı.${NC}"

echo -e "${GREEN}>>> Docker Compose kuruluyor...${NC}"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo -e "${GREEN}>>> Docker Compose başarıyla kuruldu.${NC}"

echo -e "${GREEN}>>> Chromium için Docker Compose dosyası oluşturuluyor...${NC}"
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
echo -e "${GREEN}>>> Docker Compose dosyası başarıyla oluşturuldu.${NC}"

echo -e "${GREEN}>>> Chromium başlatılıyor...${NC}"
docker-compose -f $HOME/chromium/docker-compose.yaml up -d
echo -e "${GREEN}>>> Chromium başarıyla çalıştırıldı.${NC}"

echo -e "${GREEN}>>> İzleme ve performans araçları kuruluyor...${NC}"
sudo apt-get install -y bpytop hdparm sysbench
echo -e "${GREEN}>>> İzleme ve performans araçları kuruldu.${NC}"

echo -e "${GREEN}>>> Performans testleri başlatılıyor...${NC}"
sudo apt-get install -y speedtest-cli
speedtest-cli > speedtest.txt
sysbench memory --memory-block-size=1M --memory-total-size=4G run > ram_benchmark.txt
hdparm -Tt /dev/vda > disk_benchmark.txt
echo -e "${GREEN}>>> Performans testleri tamamlandı. Sonuçlar:${NC}"
cat speedtest.txt
cat ram_benchmark.txt
cat disk_benchmark.txt

# Günlük önbellek temizleme işlemi için cron job ekleniyor
(crontab -l 2>/dev/null; echo "0 0 * * * rm -rf /root/.cache/*") | crontab -

echo -e "${GREEN}>>> Tüm işlemler başarıyla tamamlandı!${NC}"
