#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}>>> Sistem güncelleniyor...${NC}"
sudo apt update && sudo apt upgrade -y
echo -e "${GREEN}>>> Sistem güncellemesi tamamlandı.${NC}"

echo -e "${GREEN}>>> Multiple Node istemcisi indiriliyor...${NC}"
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
    CLIENT_URL="https://cdn.app.multiple.cc/client/linux/x64/multipleforlinux.tar"
elif [[ "$ARCH" == "aarch64" ]]; then
    CLIENT_URL="https://cdn.app.multiple.cc/client/linux/arm64/multipleforlinux.tar"
else
    echo -e "${RED}Desteklenmeyen sistem mimarisi: $ARCH${NC}"
    exit 1
fi

wget $CLIENT_URL -O multipleforlinux.tar
if [ ! -f "multipleforlinux.tar" ]; then
    echo -e "${RED}Multiple Node istemcisi indirilemedi.${NC}"
    exit 1
fi

echo -e "${GREEN}>>> Multiple Node arşivi çıkarılıyor...${NC}"
tar -xvf multipleforlinux.tar
cd multipleforlinux || { echo -e "${RED}multipleforlinux dizinine girilemedi.${NC}"; exit 1; }

echo -e "${GREEN}>>> Gerekli izinler veriliyor...${NC}"
chmod +x ./multiple-cli ./multiple-node

echo -e "${GREEN}>>> PATH değişkenine ekleniyor...${NC}"
export PATH=$PATH:$(pwd)  # Geçici ekleme
echo "export PATH=\$PATH:$(pwd)" >> ~/.bashrc  # Kalıcı ekleme

echo -e "${GREEN}>>> Multiple Node başlatılıyor...${NC}"
nohup ./multiple-node > output.log 2>&1 &

read -p "Account ID girin: " IDENTIFIER
read -p "PIN girin (örnek: 123456): " PIN

echo -e "${GREEN}>>> Multiple Node CLI bağlantısı yapılıyor...${NC}"
./multiple-cli bind --bandwidth-download 100 --identifier $IDENTIFIER --pin $PIN --storage 200 --bandwidth-upload 100

if [ $? -eq 0 ]; then
    echo -e "${GREEN}>>> Multiple Node kurulumu tamamlandı!${NC}"
    echo -e "${YELLOW}Node durumunu kontrol etmek için: ./multiple-cli status${NC}"
else
    echo -e "${RED}Multiple Node kurulumu sırasında bir hata oluştu.${NC}"
fi
