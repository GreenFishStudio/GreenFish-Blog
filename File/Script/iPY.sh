#!/bin/bash

# Get Python version to install from user input
read -p "Enter Python version to install (e.g. 3.9.9): " PYTHON_VERSION

# Determine which package manager to use
if command -v yum >/dev/null 2>&1; then
    PKG_MANAGER="yum"
elif command -v apt-get >/dev/null 2>&1; then
    PKG_MANAGER="apt-get"
elif command -v pacman >/dev/null 2>&1; then
    PKG_MANAGER="pacman"
else
    echo "Error: could not determine package manager" >&2
    exit 1
fi

# Install dependencies
sudo $PKG_MANAGER update
sudo $PKG_MANAGER install -y wget gcc make zlib1g-dev libffi-dev libssl-dev

# Download and extract Python source code
wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
tar xvf Python-$PYTHON_VERSION.tgz
cd Python-$PYTHON_VERSION

# Configure Python build with custom options
./configure --enable-optimizations --enable-shared

# Compile and install Python
make -j$(nproc)
sudo make altinstall

# Create symbolic link to the new Python interpreter
sudo ln -s /usr/local/bin/python$PYTHON_VERSION /usr/local/bin/python${PYTHON_VERSION}

# Update dynamic linker cache
sudo ldconfig

# Clean up
cd ..
rm -rf Python-$PYTHON_VERSION Python-$PYTHON_VERSION.tgz

# Print message with Python version and installation path
echo "Python $PYTHON_VERSION has been successfully installed to /usr/local/bin/python${PYTHON_VERSION}"
echo "You can now use 'python${PYTHON_VERSION}' command to run Python $PYTHON_VERSION"
