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

checkSystem() {
  if [[ -n $(find /etc -name "redhat-release") ]] || grep </proc/version -q -i "centos"; then

    centosVersion=$(rpm -q centos-release | awk -F "[-]" '{print $3}' | awk -F "[.]" '{print $1}')
    if [[ -z "${centosVersion}" ]] && grep </etc/centos-release "release 8"; then
      centosVersion=8
    fi
    release="Centos"

  elif grep </etc/issue -q -i "debian" && [[ -f "/etc/issue" ]] || grep </etc/issue -q -i "debian" && [[ -f "/proc/version" ]]; then
    if grep </etc/issue -i "8"; then
      debianVersion=8
    fi
    release="Debian"

  elif grep </etc/issue -q -i "ubuntu" && [[ -f "/etc/issue" ]] || grep </etc/issue -q -i "ubuntu" && [[ -f "/proc/version" ]]; then
    release="Ubuntu"
  fi
}




remove(){
		if [[ ${release} == "Centos" ]]; then
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
remove
