#!/bin/bash

root_need(){
    if [[ $EUID -ne 0 ]]; then
        echo -e “\033[31m ERROR:Please running with root \033[0m” 
        exit 1
    fi
}

apt-get --purge remove apache2 -y
echo -e “\033[32m removing apache2 \033[0m”

apt-get --purge remove apache2.2-common -y
echo -e “\033[32m removing apache2.2-common \033[0m”

apt-get --purge remove apache2-doc -y 
echo -e “\033[32m removing apache2-doc \033[0m”

apt-get --purge remove apache2-utils -y
echo -e “\033[32m removing apache2-utils \033[0m”

apt-get autoremove -y 

find /etc -name "*apache*" |xargs  rm -rf
rm -rf /var/www
rm -rf /etc/libapache2-mod-jk
dpkg -l |grep apache2|awk '{print $2}'|xargs dpkg -P

echo -e “\033[31m Finished \033[0m” 
