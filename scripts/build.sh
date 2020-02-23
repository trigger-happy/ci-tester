#!/bin/bash

mkdir -p build && \
    cd build && \
    cmake .. -G Ninja -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_INSTALL_PREFIX=$1 -DSTATIC_BUILD=$STATIC_BUILD && \
    ninja && \
    ninja install
