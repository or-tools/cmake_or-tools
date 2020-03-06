set(BUILD_DEPS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_SHARED_LIBS OFF)
set(BUILD_TESTING OFF)

################
##  OR_TOOLS  ##
################
message(STATUS "Subproject: ORTOOLS...")
# Download and unpack or-tools at configure time
configure_file(
	${CMAKE_CURRENT_SOURCE_DIR}/ortools.CMakeLists.txt
	${CMAKE_BINARY_DIR}/ortools-download/CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/ortools-download)
if(result)
  message(FATAL_ERROR "CMake step for ortools failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/ortools-download)
if(result)
  message(FATAL_ERROR "Build step for ortools failed: ${result}")
endif()

add_subdirectory(
	${CMAKE_BINARY_DIR}/ortools-src
	${CMAKE_BINARY_DIR}/ortools-build)
message(STATUS "Subproject: ORTOOLS...DONE")
