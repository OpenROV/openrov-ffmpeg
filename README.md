This project builds ffmpeg for the ARMHF architecture that is built statically.  It is currently using the 2.9-dev (master) branch of ffmpeg. You can see the pinned commit numbers we are using in the build.sh file.

This package generates 2 .deb PACKAGE_VERSION

openrov-ffmpeg-lib that contains the \lib and \inc folders
openrov-ffmpeg that has the executables and requires openrov-ffmpeg-lib
