cmake_minimum_required(VERSION 3.5)
set(project_b_VERSION 0.0.1)
project(project_b VERSION ${project_b_VERSION})

find_package(modern_cmake_tools REQUIRED)

# find package brings transitive dependencies of project_a_headers
find_package(project_a 0.0.1 REQUIRED)
add_library(
  project_b_library
  src/project_b.cpp
)
target_include_directories(
  project_b_library
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include/>
)
set_target_properties(project_b_library
  PROPERTIES
    CXX_STANDARD 14
)

add_executable(
  project_b
  src/project_b_main.cpp
)
target_link_libraries(
  project_b
  project_b_library
  project_a::project_a_library
)
set_target_properties(project_b
  PROPERTIES
    CXX_STANDARD 14
)

install(
  DIRECTORY include/
  DESTINATION include
)
install(
  TARGETS project_b_library project_b
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  INCLUDES DESTINATION include
)

tools_export_package(
  TARGETS project_b_library
  DEPENDENCIES project_a
)
