
#!/bin/bash

# Varsayılan Kullanıcı Adı ve Şifre
CUSTOM_USER=${CUSTOM_USER:-admin}
PASSWORD=${PASSWORD:-admin}

# Swap Alanı Oluşturma
echo ">>> Swap alanı oluşturuluyor (10 GB)..."
sudo dd if=/dev/zero of=/swapfile bs=1M count=10240 status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab
echo ">>> Swap alanı oluşturma tamamlandı."

# Sistem Güncellemeleri
echo ">>> Sistem güncelleniyor..."
sudo apt-get update && sudo apt-get upgrade -y
echo ">>> Sistem güncellemesi tamamlandı."

# Docker ve Gerekli Bağımlılıkların Kurulumu
echo ">>> Docker ve bağımlılıklar kuruluyor..."
sudo apt-get install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io
echo ">>> Docker kurulumu tamamlandı."

# Docker Compose Kurulumu
echo ">>> Docker Compose kuruluyor..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo ">>> Docker Compose başarıyla kuruldu."

# Chromium için Docker Konteynerinin Kurulumu
echo ">>> Chromium için Docker konteyner kuruluyor..."
mkdir -p $HOME/chromium
cat <<EOL > $HOME/chromium/docker-compose.yaml
services:
  chromium:
    image: lscr.io/linuxserver/chromium:latest
    container_name: chromium
    security_opt:
      - seccomp:unconfined
    environment:
      - CUSTOM_USER=$CUSTOM_USER
      - PASSWORD=$PASSWORD
      - PUID=1000
      - PGID=1000
      - TZ=Europe/Istanbul
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

echo ">>> Docker konteyner başlatılıyor..."
docker-compose -f $HOME/chromium/docker-compose.yaml up -d
docker exec -it chromium bash -c "
  apt-get update && apt-get install -y python3-pip python3-xdg
"
docker-compose down
docker-compose up -d
echo ">>> Chromium kurulumu tamamlandı ve çalıştırıldı."

# İzleme ve Performans Araçları Kurulumu
echo ">>> İzleme ve performans araçları kuruluyor..."
sudo apt-get install -y bpytop hdparm sysbench
echo ">>> İzleme ve performans araçları kuruldu."

# Performans Testleri
echo ">>> Performans testleri başlatılıyor..."
sudo apt-get install -y speedtest-cli
speedtest-cli > speedtest.txt
sysbench memory --memory-block-size=1M --memory-total-size=4G run > ram_benchmark.txt
hdparm -Tt /dev/sda > disk_benchmark.txt
echo ">>> Performans testleri tamamlandı. Sonuçlar:"
cat speedtest.txt
cat ram_benchmark.txt
cat disk_benchmark.txt

echo ">>> Tüm işlemler başarıyla tamamlandı!"
