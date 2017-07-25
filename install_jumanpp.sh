#!/bin/bash

# boost
sudo wget -O boost_1_64_0.tar.gz http://sourceforge.net/projects/boost/files/boost/1.64.0/boost_1_64_0.tar.gz/download
sudo tar xzvf boost_1_64_0.tar.gz
cd boost_1_64_0/
sudo ./bootstrap.sh --prefix=/usr/local --with-libraries=program_options,filesystem,system
sudo ./b2 link=shared threading=multi variant=release
sudo ./b2 install

# JUMAN++
cd Downloads
wget http://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-1.02.tar.xz
tar xJvf jumanpp-1.02.tar.xz
cd jumanpp-1.02
./configure --with-boost=~/boost
make
sudo make install
cd ..
sudo rm jumanpp-1.02.tar.xz
sudo rm -r jumanpp-1.02
