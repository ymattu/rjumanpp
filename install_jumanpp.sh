#!/bin/sh

# boost 1.57
cd ~
mkdir Downloads
cd Downloads
curl http://heanet.dl.sourceforge.net/project/boost/boost/1.57.0/boost_1_57_0.tar.bz2 -O
tar xvfj boost_1_57_0.tar.bz2
pushd boost_1_57_0
./bootstrap.sh
sudo ./b2 install -j 2 --prefix=/usr link=static
popd

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
