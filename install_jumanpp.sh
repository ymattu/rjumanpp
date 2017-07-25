#!/bin/bash

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
