# Setup project, output and linker file
set(TARGET_NAME FRDM-K22F_Blinky)
set(EXECUTABLE ${TARGET_NAME}.elf)
set(LINKER_FILE ${CMAKE_CURRENT_SOURCE_DIR}/device/MK22FN512xxx12_flash.ld)

enable_language(C ASM)
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

# Optional: issue a message to be sure it uses the correct toolchain file.
message(STATUS "CMAKE_TOOLCHAIN_FILE is: ${CMAKE_TOOLCHAIN_FILE}")

# List of source files
set(SRC_FILES
        src/main.c
        src/leds.c
        src/platform.c

        device/startup_MK22F51212.S
        device/system_MK22F51212.c

        drivers/fsl_clock.c
        drivers/fsl_gpio.c

        McuLib/src/McuLib.c
        McuLib/src/McuGPIO.c
        McuLib/src/McuLED.c
        McuLib/src/McuWait.c
        McuLib/src/McuUtility.c
        McuLib/src/McuArmTools.c
        McuLib/src/McuRTOS.c

        McuLib/FreeRTOS/FreeRTOShooks.c
        McuLib/FreeRTOS/Source/croutine.c
        McuLib/FreeRTOS/Source/event_groups.c
        McuLib/FreeRTOS/Source/list.c
        McuLib/FreeRTOS/Source/queue.c
        McuLib/FreeRTOS/Source/stream_buffer.c
        McuLib/FreeRTOS/Source/tasks.c
        McuLib/FreeRTOS/Source/timers.c
        McuLib/FreeRTOS/Source/portable/MemMang/heap_1.c
        McuLib/FreeRTOS/Source/portable/MemMang/heap_2.c
        McuLib/FreeRTOS/Source/portable/MemMang/heap_3.c
        McuLib/FreeRTOS/Source/portable/MemMang/heap_4.c
        McuLib/FreeRTOS/Source/portable/MemMang/heap_5.c
        McuLib/FreeRTOS/Source/portable/MemMang/heap_useNewlib.c
        McuLib/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.c
        McuLib/FreeRTOS/Source/portable/GCC/ARM_CM4F/portasm.s
        )

# Build the executable based on the source files
add_executable(${EXECUTABLE} ${SRC_FILES})

# List of compiler defines, prefix with -D compiler option
target_compile_definitions(${EXECUTABLE} PRIVATE
        -DCPU_MK22FN512VLH12
        -DCPU_MK22FN512VLH12_cm4
        -DNDEBUG
        )

# List of includ directories
target_include_directories(${EXECUTABLE} PRIVATE
        CMSIS
        device
        drivers
        src
        McuLib/config
        McuLib/config/fonts
        McuLib/src
        McuLib/fonts

        McuLib/FreeRTOS/Source/include
        McuLib/FreeRTOS/Source/portable/GCC/ARM_CM4F
        
        McuLib/SEGGER_RTT
        McuLib/SEGGER_Sysview

        McuLib/TraceRecorder/config
        McuLib/TraceRecorder/include
        McuLib/TraceRecorder/streamports/Jlink_RTT/include
        )

# Compiler options
target_compile_options(${EXECUTABLE} PRIVATE
        -mcpu=cortex-m4
        -mthumb
        -mfpu=fpv4-sp-d16
        -mfloat-abi=hard

        -fdata-sections
        -ffunction-sections

        -includeIncludeMcuLibConfig.h

        -Wall
        -O0
        -g3
        )

# Linker options
target_link_options(${EXECUTABLE} PRIVATE
        -T${LINKER_FILE}
        -mcpu=cortex-m4
        -mthumb
        -mfpu=fpv4-sp-d16
        -mfloat-abi=hard
        -specs=nano.specs
        -specs=nosys.specs
        -lc
        -lm
        -Wl,-Map=${TARGET_NAME}.map,--cref
        -Wl,--gc-sections
        -Xlinker -print-memory-usage -Xlinker
        )

# Optional: Print executable size as part of the post build process
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND ${CMAKE_SIZE_UTIL} ${EXECUTABLE})

# Optional: Create hex, bin and S-Record files after the build
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O srec --srec-len=64 ${EXECUTABLE} ${TARGET_NAME}.s19
        COMMAND ${CMAKE_OBJCOPY} -O ihex ${EXECUTABLE} ${TARGET_NAME}.hex
        COMMAND ${CMAKE_OBJCOPY} -O binary ${EXECUTABLE} ${TARGET_NAME}.bin)
