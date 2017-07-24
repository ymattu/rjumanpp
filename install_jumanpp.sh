#!/bin/sh

# Boost
mkdir ~/boost
wget http://sourceforge.net/projects/boost/files/boost/1.64.0/boost_1_64_0.tar.bz2
tar -jxvf boost_1_64_0.tar.bz2
cd boost_*
sudo ./bootstrap.sh --prefix=~/boost
sudo ./b2 install
export PATH=$PATH:~/boost/include/:~/boost/lib/
export BOOST_ROOT=~/boost

# JUMAN++
cd ~
wget http://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-1.02.tar.xz
tar xJvf jumanpp-1.02.tar.xz
cd jumanpp-1.02
./configure --with-boost=~/boost
make
sudo make install
cd ~
sudo rm jumanpp-1.02.tar.xz
sudo rm -r jumanpp-1.02
