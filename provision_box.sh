#!/bin/bash

cd /home/vagrant
echo "export HOST_IP=10.0.2.2" >> .bashrc
echo "export HOST_IP=10.0.2.2" >> .zshrc

sudo apt update
sudo apt update --fix-missing
sudo apt upgrade

sudo apt install -y git
sudo apt install -y make
sudo apt install -y build-essential
sudo apt install -y gcc-arm-none-eabi
sudo apt install -y gdb
sudo apt install -y gdb-multiarch
sudo apt install -y bear
sudo apt install -y clangd
sudo apt install -y stlink-tools
sudo apt install -y python3
sudo apt install -y python3-pip
sudo apt install -y python3-venv
sudo apt install -y curl
sudo apt install -y wget
sudo apt install -y nano
sudo apt install -y vim
sudo apt install -y net-tools
sudo apt install -y can-utils
sudo apt install -y screen
sudo apt install -y cmake

# install latest NodeJS
sudo curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install -y nodejs

# build openocd from source cus the apt version can be weirdge
sudo apt install -y libtool
sudo apt install -y pkg-config
sudo apt install -y autoconf
sudo apt install -y automake
sudo apt install -y texinfo
sudo apt install -y libusb-1.0-0-dev

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
pip3 install gdbgui
pip3 install python-can
pip3 install pygments
pip3 install numpy
pip3 install pandas
pip3 install click

# install flatc from source
git clone https://github.com/google/flatbuffers.git
cd flatbuffers
# This hash happens to corrispond the the commit that is working with our current tool chain. This should prevent future commits to flatbuffers from breaking future members virtual machines.
git checkout 7edf8c90842aaa402257bf99989b58b8147ceabf
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
make
sudo make install
cd ..

