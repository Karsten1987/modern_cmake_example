cmake_minimum_required(VERSION 3.5)
set(project_a_VERSION 0.0.1)
project(project_a VERSION ${project_a_VERSION})

find_package(project_a_headers 0.0.1 REQUIRED)
add_library(
  project_a_library
  src/project_a.cpp
)
# only private headers are being explicitly added
# these are not going to be installed
target_include_directories(
  project_a_library
  PRIVATE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src/internal_include/>
)
target_link_libraries(
  project_a_library
  project_a_headers::project_a_header_lib
)
set_target_properties(project_a_library
  PROPERTIES
    CXX_STANDARD 14
)

# install the libraries and set them into the export set
install(
  TARGETS project_a_library
  EXPORT export_${PROJECT_NAME}
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)

install(
  EXPORT export_${PROJECT_NAME}
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION "share/${PROJECT_NAME}/cmake"
  # FILE export_${PROJECT_NAME}.cmake
)

## export library dependencies
include(CMakePackageConfigHelpers)
configure_package_config_file(
  ${CMAKE_CURRENT_LIST_DIR}/cmake/project_aConfig.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/project_aConfig.cmake
  INSTALL_DESTINATION share/${PROJECT_NAME}/cmake
)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)
install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
  DESTINATION share/${PROJECT_NAME}/cmake
)
