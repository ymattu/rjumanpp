#!/bin/bash

# Boost 1.57
sudo apt-get install build-essential g++ python-dev autotools-dev libicu-dev build-essential libbz2-dev
sudo apt-get install gcc-4.9 google-perftools libgoogle-perftools-dev
wget http://downloads.sourceforge.net/project/boost/boost/1.57.0/boost_1_57_0.tar.bz2
tar xvjf ./boost_1_57_0.tar.bz2
./bootstrap.sh --prefix=/opt/boost_1_57_0
sudo ./b2
sudo ./b2 install

# JUMAN++
cd Downloads
wget http://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-1.01.tar.xz
tar xJvf jumanpp-1.01.tar.xz
cd jumanpp-1.01
./configure --with-boost=~/boost
make
sudo make install
cd .
sudo rm jumanpp-1.01.tar.xz
sudo rm -r jumanpp-1.01
cd ~
