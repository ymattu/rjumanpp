#!/bin/bash

# Boost 1.57
## dependencies
### g++-4.9
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get update -qq
sudo apt-get install g++-4.9
### others
sudo apt-get update -qq
sudo apt-get install build-essential python-dev autotools-dev libicu-dev build-essential libbz2-dev
sudo apt-get install gcc-4.9 google-perftools libgoogle-perftools-dev
## build boost
wget http://downloads.sourceforge.net/project/boost/boost/1.57.0/boost_1_57_0.tar.bz2
tar xjf ./boost_1_57_0.tar.bz2
cd boost_1_57_0
./bootstrap.sh
sudo ./b2 toolset=gcc-4.9
sudo ./b2 install -j2 --prefix=/opt/boost_1_57_0
## path
export PATH=$PATH:/opt/boost_1_57_0/include/:/opt/boost_1_57_0/lib/
export BOOST_ROOT=/opt/boost_1_57_0
cd ~
## remove files
sudo rm boost_1_57_0.tar.bz2
sudo rm -r boost_1_57_0.tar.bz2

# JUMAN++
mkdir Downloads
cd Downloads
wget http://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-1.01.tar.xz
tar xJvf jumanpp-1.01.tar.xz
cd jumanpp-1.01
./configure --with-boost=/opt/boost_1_57_0
make
sudo make install
cd ..
sudo rm jumanpp-1.01.tar.xz
sudo rm -r jumanpp-1.01
