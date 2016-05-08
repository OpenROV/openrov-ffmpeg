#!/bin/bash
set -ex
#Install Pre-req
gem install fpm
export DIR=${PWD#}
export PACKAGE="openrov-ffmpeg-lib"


ARCH=`uname -m`
if [ ${ARCH} = "armv7l" ]
then
  ARCH="armhf"
fi

./build.sh

#pushd ffmpeg
#export PACKAGE_VERSION=2.9.0-1~${BUILD_NUMBER}.`git rev-parse --short HEAD`
#popd

export PACKAGE_VERSION=3.0.2~${BUILD_NUMBER}

#package
cd $DIR
fpm -f -m info@openrov.com -s dir -t deb -a $ARCH \
	-n ${PACKAGE} \
	-v ${PACKAGE_VERSION} \
	--description "OpenROV ffmpeg library files" \
	-C ${DIR}/output ./usr/lib ./usr/include

export PACKAGE="openrov-ffmpeg"

fpm -f -m info@openrov.com -s dir -t deb -a $ARCH \
	-n ${PACKAGE} \
	-v ${PACKAGE_VERSION} \
	--description "OpenROV ffmpeg" \
	-C ${DIR}/output ./usr/bin ./usr/share
