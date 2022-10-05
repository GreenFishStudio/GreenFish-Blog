#!/bin/bash
apt-get --purge remove apache2
echo removing apache2
apt-get --purge remove apache2.2-common
echo removing apache2.2-common
apt-get --purge remove apache2-doc
echo removing apache2-doc
apt-get --purge remove apache2-utils
echo removing apache2-utils
apt-get autoremove
find /etc -name "*apache*" |xargs  rm -rf
rm -rf /var/www
rm -rf /etc/libapache2-mod-jk
dpkg -l |grep apache2|awk '{print $2}'|xargs dpkg -P
echo -e “\033[31m Finished \033[0m” 
