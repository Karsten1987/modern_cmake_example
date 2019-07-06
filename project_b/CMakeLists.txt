cmake_minimum_required(VERSION 3.5)
set(project_b_VERSION 0.0.1)
project(project_b VERSION ${project_b_VERSION})

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)

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

add_executable(
  project_b
  src/project_b_main.cpp
)
target_link_libraries(
  project_b
  project_b_library
  project_a::project_a_library
)

install(
  TARGETS project_b_library project_b
  EXPORT export_${PROJECT_NAME}
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  INCLUDES DESTINATION include
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
  FILE ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
)
export(PACKAGE ${PROJECT_NAME})
