cmake_minimum_required(VERSION 3.15)
project(vncsnapshot C CXX)  # Enabled CXX to let Visual Studio compile C++ files properly

# Force vcpkg to use the static triplet automatically
set(VCPKG_TARGET_TRIPLET "x64-windows-static")

# Force fully static runtime linking (/MT instead of /MD)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

find_package(ZLIB REQUIRED)
find_package(JPEG REQUIRED)

# Scans for .c, .cpp, and .cxx files anywhere in the directory
file(GLOB_RECURSE SOURCES
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    "*.c"
    "*.cpp"
    "*.cxx"
)

set(SOURCES
    vncsnapshot.c
    vncauth.c
    sockets.c
    rfbproto.c
    listen.c

set(vncsnapshot_SOURCES
  argsresources.c
  buffer.c
  cursor.c
  d3des.c
  getpass.c
  listen.c
  rfbproto.c
  sockets.cxx
  tunnel.c
  vncauth.c
  vncsnapshot.c
  zrle.cxx)

add_executable(vncsnapshot ${vncsnapshot_SOURCES})
target_link_libraries(vncsnapshot PRIVATE ZLIB::ZLIB JPEG::JPEG ws2_32.lib)

set(vncpasswd_SOURCES d3des.c vncauth.c vncpasswd.c)
add_executable(vncpasswd ${vncpasswd_SOURCES})


