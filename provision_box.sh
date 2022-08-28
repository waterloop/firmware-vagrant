#!/bin/bash

cd /home/vagrant
echo "export HOST_IP=10.0.2.2" >> .bashrc
echo "export HOST_IP=10.0.2.2" >> .zshrc

sudo apt update
sudo apt update --fix-missing
sudo apt upgrade

sudo apt install -y \
    git \
    locales \
    locales-all \
    make \
    build-essential \
    gcc-arm-none-eabi \
    gdb \
    gdb-multiarch \
    bear \
    clangd \
    stlink-tools \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    wget \
    nano \
    vim \
    net-tools \
    can-utils \
    screen

# install latest NodeJS
sudo curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install -y nodejs

# build openocd from source cus the apt version can be weirdge
sudo apt install -y \
    libtool \
    pkg-config \
    autoconf \
    automake \
    texinfo \
    libusb-1.0-0-dev

git clone https://github.com/openocd-org/openocd.git
cd openocd
git checkout tags/v0.11.0

./bootstrap
./configure --enable-stlink --enable-ftdi --enable-jlink
make
sudo make install

cd ..
rm -rf openocd


# install useful python libraries...
pip3 install \
    gdbgui \
    python-can \
    pygments \
    numpy \
    pandas \
    click


