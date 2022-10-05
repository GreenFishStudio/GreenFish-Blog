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

check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="0"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="1"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="1"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="0"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="1"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="1"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="0"
    fi
	bit=`uname -m`
}


remove(){
		if [[ ${release} == "0" ]]; then
			yum list | grep httpd
            		systemctl stop httpd.service
            		echo -e "${GREEN}removing...${END}"
            		yum erase httpd.x86_64 -y
           		echo -e "${BLUE}Finished${END}" 
		else
			echo -e "${GREEN}removing apache2...${END}"
          		apt-get --purge remove apache2 -y
         		echo -e "${GREEN}removing apache2.2-common...${END}"
            		apt-get --purge remove apache2.2-common -y
            		echo -e "${GREEN}removing apache2-doc...${END}"
            		apt-get --purge remove apache2-doc -y 
            		echo -e "${GREEN}removing apache2-utils...${END}"
            		apt-get --purge remove apache2-utils -y
            		echo -e "${GREEN}Delete files related to apache...${END}"
            		find /etc -name "*apache*" |xargs  rm -rf
            		rm -rf /var/www
            		rm -rf /etc/libapache2-mod-jk
            		dpkg -l |grep apache2|awk '{print $2}'|xargs dpkg -P
            		echo -e "${BLUE}Finished${END}" 
     		fi
}
