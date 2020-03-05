[![Build Status](https://travis-ci.com/Mizux/cmake-ortools.svg?branch=master)](https://travis-ci.com/Mizux/cmake-ortools)
[![Build status](https://ci.appveyor.com/api/projects/status/5t6i2y4jbhqdxyd6/branch/master?svg=true)](https://ci.appveyor.com/project/Mizux/cmake-ortools/branch/master)

# Introduction
This is an integration test of ORTools in a Modern [CMake](https://cmake.org/) C++ Project using
 [ExternalProject](https://cmake.org/cmake/help/latest/module/ExternalProject.html) module.

This project should run on Linux, Mac and Windows.

# CMake Dependencies Tree
This CMake project is composed of one executable (FooApp) and one library (Foo)
with the following dependencies:  
```
ortools: Gflags Glog ZLIB Protobuf Cbc
Foo: ortools
FooApp: ortools
```

## Project directory layout
Thus the project layout is as follow:
```
 CMakeLists.txt // meta CMake doing the orchestration.
 cmake
 ├── CMakeLists.txt
 ├── ortools.CMakeLists.txt
 Foo
 ├── CMakeLists.txt
 ├── main.cpp
 FooApp
 ├── CMakeLists.txt
 └── src
     └── main.cpp
```

# C++ Project Build
To build the C++ project, as usual:
```sh
cmake -H. -Bbuild -DCMAKE_VERBOSE_MAKEFILE=ON
cmake --build build
```

# Docker testing
To test CMake Install rules and build, there is a Makefile in cmake folder using
docker to test.

For example to test the Cmake project on ubuntu:
```sh
make -f cmake/Makefile test_install_ubuntu
```

note: to get help you can use
```sh
make -f cmake/Makefile help
```

# Contributing
The [CONTRIBUTING.md](./CONTRIBUTING.md) file contains instructions on how to
file the Contributor License Agreement before sending any pull requests (PRs).
Of course, if you're new to the project, it's usually best to discuss any
proposals and reach consensus before sending your first PR.

# License
Apache 2. See the LICENSE file for details.

# Disclaimer
This is not an official Google product, it is just code that happens to be
owned by Google.
