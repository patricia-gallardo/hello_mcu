[![CMake Ninja](https://github.com/patricia-gallardo/hello_mcu/actions/workflows/cmake_ninja.yml/badge.svg)](https://github.com/patricia-gallardo/hello_mcu/actions/workflows/cmake_ninja.yml)

This folder contains examples using Microsoft Visual Studio Code.

See following links for articles about it:
https://mcuoneclipse.com/2021/05/01/visual-studio-code-for-c-c-with-arm-cortex-m-part-1/


https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
https://cmake.org/download/

cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE="arm-none-eabi-gcc.cmake" -DCMAKE_MAKE_PROGRAM=ninja.exe  -G "Ninja"
cd build
ninja
