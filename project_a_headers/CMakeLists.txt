cmake_minimum_required(VERSION 3.5)
set(project_a_headersVERSION 0.0.1)
project(project_a_headers VERSION ${project_a_headersVERSION})

# mark the library as header only with INTERFACE
add_library(
  project_a_header_lib
  INTERFACE
)
target_include_directories(
  project_a_header_lib
  INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include/>
)

# install the libraries and set them into the export set
install(
  TARGETS project_a_header_lib
  EXPORT export_${PROJECT_NAME}
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  INCLUDES DESTINATION include
)

install(
  DIRECTORY include/
  DESTINATION include
)

# export the libraries and register the package
# use shortcut by directly installing the exported target file as *Config.cmake
install(
  EXPORT export_${PROJECT_NAME}
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION "share/${PROJECT_NAME}/cmake"
  FILE ${PROJECT_NAME}Config.cmake
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)
install(
  FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
  DESTINATION share/${PROJECT_NAME}/cmake
)
