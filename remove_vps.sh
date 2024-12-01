
#!/bin/bash

# Renkli Çıktılar
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}>>> Docker durduruluyor ve kaldırılıyor...${NC}"
sudo systemctl stop docker
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm -f /usr/local/bin/docker-compose

echo -e "${GREEN}>>> Chromium kaldırılıyor...${NC}"
sudo rm -rf ~/chromium

echo -e "${GREEN}>>> Swap alanı kaldırılıyor...${NC}"
sudo swapoff /swapfile
sudo rm -f /swapfile
sudo sed -i '/\/swapfile/d' /etc/fstab

echo -e "${GREEN}>>> Gereksiz araçlar kaldırılıyor...${NC}"
sudo apt-get purge -y bpytop hdparm sysbench speedtest-cli
sudo apt-get autoremove -y
sudo apt-get clean
sudo apt-get autoremove --purge -y

echo -e "${GREEN}>>> VPS başarıyla temizlendi!${NC}"
