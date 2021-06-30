# Setup project, output and linker file
set(TARGET_NAME F303K8_Blinky)
set(EXECUTABLE ${TARGET_NAME}.elf)
set(LINKER_FILE ${CMAKE_CURRENT_SOURCE_DIR}/device/STM32F303K8_FLASH.ld)

enable_language(C ASM)
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

# Optional: issue a message to be sure it uses the correct toolchain file.
message(STATUS "CMAKE_TOOLCHAIN_FILE is: ${CMAKE_TOOLCHAIN_FILE}")

# List of source files
set(SRC_FILES
        src/main.c
        src/platform.c
        src/Shell.c

        drivers/Board.c
        drivers/ADC.c
        drivers/DAC.c
        drivers/GPIO.c
        drivers/Led.c
        drivers/Pin.c 
        drivers/RTOS.c
        drivers/Speaker.c 
        drivers/Timer.c 

       device/startup.c
       device/startup_stm32f303x8.S
       device/stm32f3xx_hal_msp.c
       device/stm32f3xx_it.c
       device/system_stm32f3xx.c

       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_adc.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_adc_ex.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_cortex.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_dac.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_dac_ex.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_dma.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_flash.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_flash_ex.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_gpio.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_i2c.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_pwr.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_pwr_ex.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_rcc.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_rcc_ex.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_tim.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_tim_ex.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_uart.c
       device/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_uart_ex.c

       McuLib/src/McuLib.c
       McuLib/src/McuGPIO.c
       McuLib/src/McuLED.c
       McuLib/src/McuArmTools.c
       McuLib/src/McuWait.c
       McuLib/src/McuUtility.c
       McuLib/src/McuArmTools.c
       McuLib/src/McuRTOS.c
       McuLib/src/McuShell.c
       McuLib/src/McuLog.c
       McuLib/src/McuXFormat.c
       McuLib/src/McuTimeDate.c

       McuLib/src/McuRTT.c
       McuLib/SEGGER_RTT/SEGGER_RTT.c
       McuLib/SEGGER_RTT/RTT_Syscalls_GCC.c
       McuLib/SEGGER_RTT/SEGGER_RTT_printf.c

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
        -DSTM32F303x8
        -DNDEBUG
        )

# List of includ directories
target_include_directories(${EXECUTABLE} PRIVATE
        CMSIS/Include
        CMSIS/Device/ST/STM32F3xx/Include
        device
        device/STM32F3xx_HAL_Driver/Inc
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
        -mfpu=fpv4-sp-d16 
        -mfloat-abi=hard
        -mthumb

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
        -mfpu=fpv4-sp-d16 
        -mfloat-abi=hard
        -mthumb
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
