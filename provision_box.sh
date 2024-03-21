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
    screen \
    cmake

# install buildroot dependencies
sudo apt install -y \
    sed \
    make \
    binutils \
    gcc \
    g++ \
    bash \
    patch \
    gzip \
    bzip2 \
    perl \
    tar \
    cpio \
    unzip \
    rsync \
    wget \
    libncurses-dev \
    coreutils \
    flex \
    bison \
    bc

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

# install flatc from source
git clone https://github.com/google/flatbuffers.git
cd flatbuffers
# This hash happens to corrispond the the commit that is working with our current tool chain. This should prevent future commits to flatbuffers from breaking future members virtual machines.
git checkout 7edf8c90842aaa402257bf99989b58b8147ceabf
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
make
sudo make install
cd ..
rm -rf flatbuffers

# time to install grpc test environment for you!
# 


