cmake_minimum_required(VERSION 3.5)
set(project_a_VERSION 0.0.1)
project(project_a VERSION ${project_a_VERSION})

find_package(modern_cmake_tools REQUIRED)

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
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)

tools_export_package(
  DEPENDENCIES project_a_headers
  TARGETS project_a_library
)
