#!/bin/bash

GREEN="\033[32m"
RED="\033[31m" 
BLUE="\033[34m"
END="\033[0m"

root_need(){
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}ERROR:Please running with root!${END}" 
        exit 1
    fi
}

echo -e "${GREEN}removing apache2${END}"
apt-get --purge remove apache2 -y

echo -e "${GREEN}removing apache2.2-common${END}"
apt-get --purge remove apache2.2-common -y

echo -e "${GREEN}removing apache2-doc${END}"
apt-get --purge remove apache2-doc -y 

echo -e "${GREEN}removing apache2-utils${END}"
apt-get --purge remove apache2-utils -y


echo -e "${GREEN}Delete files related to apache${END}""
find /etc -name "*apache*" |xargs  rm -rf
rm -rf /var/www
rm -rf /etc/libapache2-mod-jk
dpkg -l |grep apache2|awk '{print $2}'|xargs dpkg -P

echo -e "${BLUE}Finished${END}" 
