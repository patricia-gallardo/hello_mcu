# add the executable
add_executable(MyProject main.c)

#configure_file(TutorialConfig.h.in TutorialConfig.h)

#target_include_directories(MyProject PUBLIC
#                           "${PROJECT_BINARY_DIR}"
#                           )

set(LINKER_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/linker.ld)

include(cmake/efr32mg.cmake)
