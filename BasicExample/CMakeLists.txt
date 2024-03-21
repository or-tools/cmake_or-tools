add_executable(${PROJECT_NAME} "")
target_sources(${PROJECT_NAME} PRIVATE "src/basic_example.cc")
target_include_directories(${PROJECT_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/src)
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)
set_target_properties(${PROJECT_NAME} PROPERTIES VERSION ${PROJECT_VERSION})
target_link_libraries(${PROJECT_NAME} PRIVATE ortools::ortools)
include(GNUInstallDirs)
if(APPLE)
  set_target_properties(${PROJECT_NAME} PROPERTIES INSTALL_RPATH
    "@loader_path/../${CMAKE_INSTALL_LIBDIR};@loader_path")
elseif(UNIX)
  cmake_path(RELATIVE_PATH CMAKE_INSTALL_FULL_LIBDIR
    BASE_DIRECTORY ${CMAKE_INSTALL_FULL_BINDIR}
    OUTPUT_VARIABLE libdir_relative_path)
  set_target_properties(${PROJECT_NAME} PROPERTIES
    INSTALL_RPATH "$ORIGIN/${libdir_relative_path}")
endif()
add_executable(BasicExample::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

# Test
if(BUILD_TESTING)
  add_test(NAME BasicExample_test COMMAND BasicExample)
endif()

# Install
install(TARGETS	${PROJECT_NAME}
  EXPORT ${PROJECT_NAME}Targets
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	)
