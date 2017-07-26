#!/bin/bash

# Boost 1.57
sudo apt-get install build-essential g++-4.9 python-dev autotools-dev libicu-dev build-essential libbz2-dev
sudo apt-get install gcc-4.9 google-perftools libgoogle-perftools-dev
wget http://downloads.sourceforge.net/project/boost/boost/1.57.0/boost_1_57_0.tar.bz2
tar xjf ./boost_1_57_0.tar.bz2
cd boost_1_57_0
./bootstrap.sh
sudo ./b2 toolset=gcc-4.9
sudo ./b2 install -j2 --prefix=/opt/boost_1_57_0

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
cd ~
