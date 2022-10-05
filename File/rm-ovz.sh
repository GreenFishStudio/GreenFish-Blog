apt-get --purge remove apache2
apt-get --purge remove apache2.2-common
apt-get --purge remove apache2-doc
apt-get --purge remove apache2-utils
apt-get autoremove
find /etc -name "*apache*" |xargs  rm -rf
rm -rf /var/www
rm -rf /etc/libapache2-mod-jk
dpkg -l |grep apache2|awk '{print $2}'|xargs dpkg -P
# 使用本命令来查看apache2是否卸载干净
dpkg -l | grep apache2
