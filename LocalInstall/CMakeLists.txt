cmake_minimum_required(VERSION 3.14.7)

if(POLICY CMP0022)
	cmake_policy(SET CMP0022 NEW)
endif()

# option() honors normal variables.
if(POLICY CMP0077)
	cmake_policy(SET CMP0077 NEW)
endif()

# Set default build type to Release if empty.
set(CMAKE_BUILD_TYPE "Release" CACHE STRING
	"Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel.")

project(CMakeORTools VERSION 1.0 LANGUAGES CXX)

include(CTest)

if(UNIX)
  option(BUILD_SHARED_LIBS "Build shared libraries(.so)." ON)
else()
	# only support for static build on Windows.
 set(BUILD_SHARED_LIBS OFF)
endif()

if(BUILD_SHARED_LIBS)
  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
endif()

list(APPEND CMAKE_PREFIX_PATH install)
find_package(ortools)

add_subdirectory(Foo)
add_subdirectory(FooApp)

# Install
include(GNUInstallDirs)
install(EXPORT CMakeORToolsTargets
	NAMESPACE CMakeORTools::
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/CMakeORTools
	COMPONENT Devel)
include(CMakePackageConfigHelpers)
configure_package_config_file(cmake/CMakeORToolsConfig.cmake.in
	"${PROJECT_BINARY_DIR}/CMakeORToolsConfig.cmake"
	INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/CMakeORTools"
	NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO)
write_basic_package_version_file(
	"${PROJECT_BINARY_DIR}/CMakeORToolsConfigVersion.cmake"
	COMPATIBILITY SameMajorVersion)
install(
	FILES
	"${PROJECT_BINARY_DIR}/CMakeORToolsConfig.cmake"
	"${PROJECT_BINARY_DIR}/CMakeORToolsConfigVersion.cmake"
	DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/CMakeORTools"
	COMPONENT Devel)
