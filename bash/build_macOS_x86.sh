#!/bin/bash

# create build dir if not exists
if [ ! -d build_macOS_x86 ]; then
    mkdir -p build_macOS_x86
fi
cd build_macOS_x86
echo "delete some file"
rm -rf *


BUILD_DIR="macOS-release"
if [ ! -d $BUILD_DIR ]; then
    mkdir -p $BUILD_DIR
fi
cd $BUILD_DIR



echo "===== cmake target: macOS-x86"
cmake  ../..

make -j4 VERBOSE=1








