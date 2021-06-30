cmake_minimum_required(VERSION 3.15.3)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/arm-none-eabi-gcc.cmake)

project(HelloMCU
        VERSION "0.1.1"
        DESCRIPTION "Some description"
        LANGUAGES C CXX)

set(CMAKE_VERBOSE_MAKEFILE ON)

enable_language(C ASM)
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

# Optional: issue a message to be sure it uses the correct toolchain file.
message(STATUS "CMAKE_TOOLCHAIN_FILE is: ${CMAKE_TOOLCHAIN_FILE}")

add_subdirectory(FRDM-K22F/FRDM-K22F_Blinky)
add_subdirectory(FRDM-K22F/FRDM-K22F_Simple)
#add_subdirectory(FRDM-K22F/FRDM-K22F_Test)
add_subdirectory(STM32_F303K8/STM32_F303K8_Blinky)
