#!/usr/bin/env bash
set -euxo pipefail

cd "${METHOD}"

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  /usr/bin/x86_64-linux-gnu-ld --version
  export PATH="/usr/local/bin:$PATH"
fi
if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  export PATH="/usr/local/opt/ccache/libexec:$PATH"
fi

cmake --version
cmake -S. -Bbuild
cmake --build build -v --target all
cmake --build build -v --target test

# vim: set tw=0 ts=2 sw=2 expandtab:
