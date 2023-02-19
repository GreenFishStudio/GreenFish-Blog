#!/bin/bash

# 获取 Python 版本信息
read -p "请输入需要安装的 Python 版本号（例如：3.9.7）：" version

# 获取操作系统信息
os=$(cat /etc/os-release | grep '^ID=' | awk -F'=' '{print $2}')

# 根据操作系统不同安装依赖包
if [ $os == "debian" ] || [ $os == "ubuntu" ]; then
    sudo apt-get update
    sudo apt-get install build-essential libssl-dev libffi-dev -y
elif [ $os == "centos" ] || [ $os == "fedora" ]; then
    sudo yum install gcc openssl-devel bzip2-devel libffi-devel -y
fi

# 下载 Python 安装包并解压
wget https://www.python.org/ftp/python/$version/Python-$version.tgz
tar -xvf Python-$version.tgz
cd Python-$version

# 配置、编译和安装 Python
./configure --enable-optimizations
make -j8
sudo make altinstall

# 清理安装包和临时文件
cd ..
rm -rf Python-$version
rm Python-$version.tgz

echo "Python $version 安装完成！"
