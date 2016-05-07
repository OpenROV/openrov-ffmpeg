#!/bin/bash
set -e

# Get the FFMPEG source
wget https://ffmpeg.org/releases/ffmpeg-3.0.2.tar.xz

tar xf ffmpeg-3.0.2.tar.xz
cd ffmpeg*

# Get library dependency sources
git clone git://git.videolan.org/x264
cd x264

# Build x264
./configure --enable-static --enable-pic --disable-asm --prefix=${PWD}/../../output/usr
make -j8
make install
cd ..

# Build FFMPEG
./configure --prefix=./build/ --disable-vaapi --disable-shared --enable-gpl --enable-libx264 --enable-static --enable-pic --extra-cflags="-I${PWD}/../output/usr/include/" --extra-ldflags="-L${PWD}/../output/usr/lib" --extra-libs="-ldl"
make -j8

make prefix=${PWD}/../output/usr install
