#!/bin/bash

GREEN="\033[32m"
BLUE="\033[34m"
END="\033[0m"

install(){
apt-get update
echo -e "${GREEN}開始下載後端...${END}" 
wget -N https://ghproxy.com/https://raw.githubusercontent.com/imkcp-blog/miaoko/main/frpc.tar.gz
echo -e "${GREEN}開始解壓...${END}" 
tar -zxvf frpc.tar.gz
cd frp
echo -e "${GREEN}啓動!!!!!!!${END}" 
nohup ./frpc -c frpc.ini 2>&1
nohup ./miaospeed server -bind 0.0.0.0:9876 -token imkcpmiaokotoken -mtls 2>&1
echo -e "${BLUE}啓動成功,綁定監聽端口9876${END}" 
}
install
