#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

VERSION="v2.1.1" # Güncel versiyon numarası
INSTALL_PATH="/root/network3" # Varsayılan kurulum yolu

echo -e "${GREEN}>>> Network3 node kurulumu/güncellemesi başlıyor...${NC}"

# Dosya yolunu otomatik bulma
EXISTING_PATH=$(find / -type d -name "network3" 2>/dev/null | head -n 1)

if [ -n "$EXISTING_PATH" ]; then
    echo -e "${YELLOW}>>> Mevcut bir kurulum tespit edildi: ${EXISTING_PATH}${NC}"
    INSTALL_PATH="$EXISTING_PATH"
else
    echo -e "${YELLOW}>>> Mevcut kurulum bulunamadı. Yeni kurulum yapılacak.${NC}"
fi

# Eski dosyaları temizleme
if [ -d "$INSTALL_PATH" ]; then
    echo -e "${YELLOW}>>> Eski kurulum temizleniyor...${NC}"
    sudo bash $INSTALL_PATH/manager.sh down 2>/dev/null
    rm -rf "$INSTALL_PATH"
fi

# Yeni dosyaları indirme ve kurulum
echo -e "${GREEN}>>> Güncel versiyon indiriliyor: ${VERSION}${NC}"
wget https://network3.io/ubuntu-node-$VERSION.tar.gz -O network3-$VERSION.tar.gz
mkdir -p "$INSTALL_PATH"
tar -zxvf network3-$VERSION.tar.gz -C "$INSTALL_PATH"

# Eğer dizin yapısı uygunsuzsa düzelt
if [ -d "$INSTALL_PATH/ubuntu-node" ]; then
    mv "$INSTALL_PATH/ubuntu-node"/* "$INSTALL_PATH/"
    rm -rf "$INSTALL_PATH/ubuntu-node"
fi

# Node'u başlatma
cd "$INSTALL_PATH"
echo -e "${GREEN}>>> Network3 node başlatılıyor...${NC}"
sudo bash manager.sh up

# Node anahtarını alma ve IP bilgisi
NODE_KEY=$(sudo bash manager.sh key | grep -E '^[A-Za-z0-9+/=]+$')
if [ $? -eq 0 ]; then
    SERVER_IP=$(curl -4 -s ifconfig.me)
    echo -e "${GREEN}>>> Anahtarınız başarıyla oluşturuldu!${NC}"
    echo -e "${YELLOW}Node Anahtarınız: ${NODE_KEY}${NC}"
    echo -e "${YELLOW}>>> Anahtarınızı aşağıdaki adreste kullanabilirsiniz:${NC}"
    echo -e "${YELLOW}https://account.network3.ai/main?o=${SERVER_IP}:8080${NC}"
    echo -e "${GREEN}>>> Network3 node kurulumu/güncellemesi tamamlandı.${NC}"
else
    echo -e "${RED}!!! Node anahtarı alınırken bir hata oluştu.${NC}"
fi
