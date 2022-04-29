[![Docker](https://github.com/Mizux/cmake-ortools/workflows/Docker/badge.svg?branch=master)](https://github.com/Mizux/cmake-ortools/actions?query=workflow%3ADocker)
[![Build Status](https://travis-ci.com/Mizux/cmake-ortools.svg?branch=master)](https://travis-ci.com/Mizux/cmake-ortools)
[![Build status](https://ci.appveyor.com/api/projects/status/5t6i2y4jbhqdxyd6/branch/master?svg=true)](https://ci.appveyor.com/project/Mizux/cmake-ortools/branch/master)

# Introduction
<nav for="integration"> |
<a href="ExternalProject">ExternalProject</a> |
<a href="FetchContent">FetchContent</a> |
<a href="LocalInstall">LocalInstall</a> |
</nav>

This is an integration test of ORTools in a Modern [CMake](https://cmake.org/) C++ Project.

You basically have three ways to integrate C++ OR-Tools in your CMake project:
* The usual way, install OR-Tools then use [`find_package()`](https://cmake.org/cmake/help/latest/command/find_package.html) it.
* Using the [ExternalProject](https://cmake.org/cmake/help/latest/module/ExternalProject.html) module.
* Using the [FetchContent](https://cmake.org/cmake/help/latest/module/FetchContent.html) module.

This project should run on Linux, Mac and Windows.

# CMake Dependencies Tree
This CMake project is composed of one executable (FooApp) and one library (Foo)
with the following dependencies:  
```
ortools: PUBLIC ZLIB abseil-cpp Protobuf re2 Cbc SCIP
Foo: PRIVATE ortools
FooApp: PRIVATE ortools
```

## Project directory layout
Thus the project layout is as follow:
```
<Method>
├── CMakeLists.txt
├── cmake
│   └── utils.cmake
├── Foo
│   ├── CMakeLists.txt
│   ├── include
│   │   └── foo
│   │       └── Foo.hpp
│   └── src
│       └── Foo.cpp
└── FooApp
    ├── CMakeLists.txt
    └── src
        └── main.cpp
```

# C++ Project Build
To build the C++ project, as usual:
```sh
cd <Method>
cmake -S. -Bbuild
cmake --build build -v
```

# License
Apache 2. See the LICENSE file for details.

# Disclaimer
This is not an official Google product, it is just code that happens to be
owned by Google.
