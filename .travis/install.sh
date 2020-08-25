#!/usr/bin/env bash
set -euxo pipefail

# See https://docs.travis-ci.com/user/caching/#ccache-on-macos
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  brew install ccache
  export PATH="/usr/local/opt/ccache/libexec:$PATH"
fi

function install-cmake() {
  # Default version is cmake 3.12.4
  # need at least CMake >= 3.14
  if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    wget "https://cmake.org/files/v3.18/cmake-3.18.1-Linux-x86_64.sh"
    chmod a+x cmake-3.18.1-Linux-x86_64.sh
    sudo ./cmake-3.18.1-Linux-x86_64.sh --prefix=/usr/local/ --skip-license
    rm cmake-3.18.1-Linux-x86_64.sh
    export PATH=/usr/local/bin:$PATH
  elif [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    brew update
  fi
  cmake --version
}

#eval "${MATRIX_EVAL}"

install-cmake
# vim: set tw=0 ts=2 sw=2 expandtab:
