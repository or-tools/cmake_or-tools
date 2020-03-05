#!/usr/bin/env bash
set -x
set -e

function install-cmake() {
  # Default version is cmake 3.12.4
  #cmake --version

  # need CMake >= 3.14 (for using the newly swig built-in UseSWIG module)
  if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    wget "https://cmake.org/files/v3.16/cmake-3.16.4-Linux-x86_64.sh"
    chmod a+x cmake-3.16.4-Linux-x86_64.sh
    sudo ./cmake-3.16.4-Linux-x86_64.sh --prefix=/usr/local/ --skip-license
    rm cmake-3.16.4-Linux-x86_64.sh
    export PATH=/usr/local/bin:$PATH
  elif [ "$TRAVIS_OS_NAME" == "osx" ]; then
    brew update
  fi
}

#eval "${MATRIX_EVAL}"

install-cmake
cmake --version
# vim: set tw=0 ts=2 sw=2 expandtab:
