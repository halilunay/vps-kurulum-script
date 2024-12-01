
#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}>>> Network3 node kurulumu başlıyor...${NC}"

# Update and install dependencies
sudo apt update && sudo apt install -y wireguard net-tools
/sbin/ifconfig eth0 up

# Download and extract the Network3 node files
wget https://network3.io/ubuntu-node-v2.1.0.tar -O network3-v2.1.0.tar
mkdir -p network3
tar -xf network3-v2.1.0.tar -C network3

# Navigate to the network3 directory
cd network3

# Start the Network3 node manager
sudo bash manager.sh up

# Retrieve the node key
NODE_KEY=$(sudo bash manager.sh key)
if [ $? -eq 0 ]; then
    echo -e "${GREEN}>>> Anahtarınız başarıyla oluşturuldu!${NC}"
    echo -e "${YELLOW}>>> Anahtarınızı aşağıdaki adreste kullanabilirsiniz:${NC}"
    SERVER_IP=$(curl -s ifconfig.me)
    echo -e "${YELLOW}https://account.network3.ai/main?o=${SERVER_IP}:8080${NC}"
    echo -e "${GREEN}>>> Network3 node kurulumu tamamlandı.${NC}"
else
    echo -e "${RED}!!! Node anahtarı alınırken bir hata oluştu.${NC}"
fi
