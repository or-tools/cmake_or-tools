#!/usr/bin/env bash
set -x
set -e

cd "${METHOD}"

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  /usr/bin/x86_64-linux-gnu-ld --version
  export PATH=/usr/local/bin:$PATH
fi

cmake --version
cmake -S. -Bbuild
cmake --build build --target all -- VERBOSE=1
cmake --build build --target test

# vim: set tw=0 ts=2 sw=2 expandtab:
