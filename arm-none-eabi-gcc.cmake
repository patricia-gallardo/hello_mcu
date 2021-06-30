# Call Cmake from the 'build' subfolder with the command below.
# For using Make:
# cmake -DCMAKE_MAKE_PROGRAM=make.exe -DCMAKE_TOOLCHAIN_FILE="arm-none-eabi-gcc.cmake" -G "Unix Makefiles" ..
# followed by
# 'make' or 'cmake --build .' to build it
#
# For using Ninja:
# cmake -DCMAKE_MAKE_PROGRAM=ninja.exe -DCMAKE_TOOLCHAIN_FILE="arm-none-eabi-gcc.cmake" -G "Ninja" ..
# followed by
# 'ninja' or 'cmake --build .' to build it

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

if (ARM_TOOLCHAIN_DIR)
    message(STATUS "ARM_TOOLCHAIN_DIR set to ${ARM_TOOLCHAIN_DIR}")
else ()
    if (CMAKE_HOST_WIN32)
        set(ARM_TOOLCHAIN_DIR "C:/Program Files (x86)/GNU Arm Embedded Toolchain/10 2020-q4-major/bin")
    elseif(APPLE)
        set(ARM_TOOLCHAIN_DIR "/usr/local/bin")
    else()
        set(ARM_TOOLCHAIN_DIR "/usr/bin")
    endif()
    message(STATUS "ARM_TOOLCHAIN_DIR not set, defaulting to ${ARM_TOOLCHAIN_DIR}")
endif ()

set(BINUTILS_PATH ${ARM_TOOLCHAIN_DIR})

set(TOOLCHAIN_PREFIX ${ARM_TOOLCHAIN_DIR}/arm-none-eabi-)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

if (CMAKE_HOST_WIN32)
    set(HOST_EXECUTABLE_SUFFIX ".exe")
else()
    set(HOST_EXECUTABLE_SUFFIX "")
endif()

set(CMAKE_C_COMPILER "${TOOLCHAIN_PREFIX}gcc${HOST_EXECUTABLE_SUFFIX}")
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER "${TOOLCHAIN_PREFIX}g++${HOST_EXECUTABLE_SUFFIX}")

set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL ${TOOLCHAIN_PREFIX}size CACHE INTERNAL "size tool")

set(CMAKE_FIND_ROOT_PATH ${BINUTILS_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
