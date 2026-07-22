cmake_minimum_required(VERSION 3.15)
project(vncsnapshot C CXX)  # Enabled CXX to let Visual Studio compile C++ files properly

# Force vcpkg to use the static triplet automatically
set(VCPKG_TARGET_TRIPLET "x64-windows-static")

# Force fully static runtime linking (/MT instead of /MD)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

find_package(ZLIB REQUIRED)
find_package(JPEG REQUIRED)

# Provide root directory and sub-library paths for include headers
include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/rdr
)


#
# Build rdr static lib ...
#

set(rdr_SOURCES
    rdr/FdInStream.cxx
    rdr/FdOutStream.cxx
    rdr/InStream.cxx
    rdr/NullOutStream.cxx
    rdr/ZlibInStream.cxx
)
add_library(rdr STATIC ${rdr_SOURCES})

# UsePUBLIC so that rdr can see the vcpkg zlib.h file
target_link_libraries(rdr PUBLIC ZLIB::ZLIB)

#
# Build vncsnapshot executable ...
#

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
target_link_libraries(vncsnapshot PRIVATE rdr ZLIB::ZLIB JPEG::JPEG ws2_32.lib)

#
# Build vncpasswd executable ...
#

set(vncpasswd_SOURCES d3des.c vncauth.c vncpasswd.c)
add_executable(vncpasswd ${vncpasswd_SOURCES})


