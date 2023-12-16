#!/bin/sh

BUILD_TYPE=Debug
BUILD_DIR_LLVM=build-llvm
INSTALL_DIR_LLVM=/opt/llvm


# LLVM_USE_LINKER=lld can reduce memory usage.
# LLVM_OPTIMIZED_TABLEGEN=ON can speed up debug building.
# LLVM_BUILD_TOOLS=OFF can help reduce compiling time.
cmake -S llvm -B $BUILD_DIR_LLVM -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR_LLVM \
        -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DLLVM_TARGETS_TO_BUILD=host \
        -DLLVM_USE_LINKER=lld  \
        -DLLVM_OPTIMIZED_TABLEGEN=ON \
        -G Ninja

cd $BUILD_DIR_LLVM
ninja -j2
ninja check-all  # run test suites
ninja install