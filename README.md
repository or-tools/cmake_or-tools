Github-CI:<br>
[![Build Status][github_amd64_linux_status]][github_amd64_linux_link]
[![Build Status][github_amd64_macos_status]][github_amd64_macos_link]
[![Build Status][github_amd64_windows_status]][github_amd64_windows_link]  
[![Build Status][github_arm64_macos_status]][github_arm64_macos_link]

[![Build Status][github_amd64_docker_status]][github_amd64_docker_link]

[github_amd64_linux_status]: ./../../actions/workflows/amd64_linux.yml/badge.svg
[github_amd64_linux_link]: ./../../actions/workflows/amd64_linux.yml
[github_amd64_macos_status]: ./../../actions/workflows/amd64_macos.yml/badge.svg
[github_amd64_macos_link]: ./../../actions/workflows/amd64_macos.yml
[github_amd64_windows_status]: ./../../actions/workflows/amd64_windows.yml/badge.svg
[github_amd64_windows_link]: ./../../actions/workflows/amd64_windows.yml

[github_arm64_macos_status]: ./../../actions/workflows/arm64_macos.yml/badge.svg
[github_arm64_macos_link]: ./../../actions/workflows/arm64_macos.yml

[github_amd64_docker_status]: ./../../actions/workflows/amd64_docker.yml/badge.svg
[github_amd64_docker_link]: ./../../actions/workflows/amd64_docker.yml

# Introduction

This is an integration test of ORTools in a Modern [CMake](https://cmake.org/)
C++ Project using the [FetchContent](https://cmake.org/cmake/help/latest/module/FetchContent.html)
module.

This project should run on Linux, Mac and Windows.

## Project directory layout

Thus the project layout is as follow:
```
├─ BasicExample
│  ├─ CMakeLists.txt
│  └─ src
│     └─ basic_example.cc
├─ cmake
│  └─ BasicExampleConfig.cmake.in
└─ CMakeLists.txt
```

# C++ Project Build

To build the C++ project, as usual:
```sh
cmake -S. -Bbuild
cmake --build build --config Release -v
```

# License

Apache 2. See the LICENSE file for details.

# Disclaimer

This is not an official Google product, it is just code that happens to be
owned by Google.
