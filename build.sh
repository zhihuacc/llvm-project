#!/bin/sh

BUILD_TYPE=Debug
BUILD_DIR_LLVM=build-llvm
INSTALL_DIR_LLVM=/opt/llvm



cmake -S llvm -B $BUILD_DIR_LLVM -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR_LLVM \
        -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DLLVM_TARGETS_TO_BUILD=host \
        -DLLVM_OPTIMIZED_TABLEGEN=ON -G Ninja

cd $BUILD_DIR_LLVM
ninja -j2
ninja check-all  # run test suites
ninja install