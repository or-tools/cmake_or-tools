cmake_minimum_required(VERSION 3.14.7)

# Set default build type to Release if empty.
set(CMAKE_BUILD_TYPE "Release" CACHE STRING
	"Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel.")

project(CMakeORTools VERSION 1.0 LANGUAGES CXX)

include(CTest)
include(GNUInstallDirs)

if(UNIX)
  option(BUILD_SHARED_LIBS "Build shared libraries(.so)." ON)
else()
	# only support for static build on Windows.
 set(BUILD_SHARED_LIBS OFF)
endif()

if(BUILD_SHARED_LIBS)
  set(CMAKE_POSITION_INDEPENDENT_CODE ON)
endif()

################
##  OR_TOOLS  ##
################
message(STATUS "Installing OR-Tools...")
# Download and install or-tools at configure time
configure_file(
	${CMAKE_CURRENT_SOURCE_DIR}/cmake/ortools.CMakeLists.txt
	${CMAKE_BINARY_DIR}/ortools-download/CMakeLists.txt)
# CMake configure
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" . -DCMAKE_BUILD_TYPE=Release
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/ortools-download)
if(result)
  message(FATAL_ERROR "CMake step for ortools failed: ${result}")
endif()
# CMake Build/Install
execute_process(COMMAND ${CMAKE_COMMAND} --build . --config Release
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/ortools-download)
if(result)
  message(FATAL_ERROR "Build step for ortools failed: ${result}")
endif()
message(STATUS "Installing OR-Tools...DONE")

list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/deps)
find_package(ortools REQUIRED)

add_subdirectory(Foo)
add_subdirectory(FooApp)

# Install
install(EXPORT ${PROJECT_NAME}Targets
	NAMESPACE ${PROJECT_NAME}::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
	COMPONENT Devel)
include(CMakePackageConfigHelpers)
configure_package_config_file(cmake/${PROJECT_NAME}Config.cmake.in
	"${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
	INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
	NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO)
write_basic_package_version_file(
	"${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
	COMPATIBILITY SameMajorVersion)
install(
	FILES
	"${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
	"${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
	DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
	COMPONENT Devel)
