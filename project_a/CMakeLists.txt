cmake_minimum_required(VERSION 3.5)
set(project_a_VERSION 0.0.1)
project(project_a VERSION ${project_a_VERSION})

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)

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
  DESTINATION "share/${PROJECT_NAME}/cmake"
  NAMESPACE ${PROJECT_NAME}::
)

# export the libraries and register the package
export(
  EXPORT export_${PROJECT_NAME}
  NAMESPACE ${PROJECT_NAME}::
  FILE ${CMAKE_CURRENT_BINARY_DIR}/_${PROJECT_NAME}Config.cmake
)
export(PACKAGE ${PROJECT_NAME})

# export library dependencies
configure_package_config_file(
  ${CMAKE_CURRENT_LIST_DIR}/cmake/project_aConfig.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/project_aConfig.cmake
  INSTALL_DESTINATION share/${PROJECT_NAME}/cmake
)
install(
  FILES ${CMAKE_CURRENT_BINARY_DIR}/project_aConfig.cmake
  DESTINATION ${CMAKE_INSTALL_PREFIX}/share/${PROJECT_NAME}/cmake
)
