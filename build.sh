#!/bin/bash
set -e

# Get the FFMPEG source
git clone git://source.ffmpeg.org/ffmpeg.git

cd ffmpeg
git checkout ce855bf43bcb3e217266653281db63c94e34c700

# Get library dependency sources
git clone git://git.videolan.org/x264
cd x264
git checkout a01e33913655f983df7a4d64b0a4178abb1eb618

# Build x264
./configure --enable-static --disable-asm --prefix=${PWD}/../output/usr
make -j8
make install
cd ..

# Build FFMPEG
./configure --prefix=./build/ --enable-gpl --enable-libx264 --enable-static --enable-pic --extra-cflags="-I${PWD}/../output/usr/include/" --extra-ldflags="-L${PWD}/../output/usr/lib" --extra-libs="-ldl"
make -j8

make prefix=${PWD}/../output/usr install
