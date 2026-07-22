cmake_minimum_required(VERSION 3.15)
project(vncsnapshot C)

# Force vcpkg to use the static triplet automatically
set(VCPKG_TARGET_TRIPLET "x64-windows-static")

# Force fully static runtime linking (/MT instead of /MD)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

find_package(ZLIB REQUIRED)
find_package(JPEG REQUIRED)

set(SOURCES
    vncsnapshot.c
    vncauth.c
    sockets.c
    rfbproto.c
    listen.c
)

add_executable(vncsnapshot ${SOURCES})
target_link_libraries(vncsnapshot PRIVATE ZLIB::ZLIB JPEG::JPEG ws2_32.lib)

