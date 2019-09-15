cmake_minimum_required(VERSION 3.5)
set(project_a_headersVERSION 0.0.1)
project(project_a_headers VERSION ${project_a_headersVERSION})

find_package(modern_cmake_tools REQUIRED)

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
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  INCLUDES DESTINATION include
)
install(
  DIRECTORY include/
  DESTINATION include
)

tools_export_package(
  TARGETS project_a_header_lib
)
