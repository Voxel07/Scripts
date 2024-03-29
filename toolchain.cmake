INCLUDE(CMakeForceCompiler)

SET(CMAKE_SYSTEM_NAME Linux)     # this one is important
SET(CMAKE_SYSTEM_VERSION 1)     # this one not so much

# this is the location of the amd64 toolchain targeting the Raspberry Pi
SET(CMAKE_C_COMPILER "/home/matthias/Desktop/azure/fs-toolchain-8.3-armv8ahf/bin/arm-linux-gcc")

# this is the file system root of the target
SET(CMAKE_FIND_ROOT_PATH "/home/matthias/Desktop/azure/compare")

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

## setSysroot
SET(CMAKE_SYSROOT "/home/matthias/Desktop/azure/compare")