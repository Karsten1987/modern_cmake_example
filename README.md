# modern_cmake_example
demo examples with three plain cmake packages

---

Modern CMake allows to easily handle properties such as include directories or linked libraries on a target level.
For example setting the include directories on a target.
```cmake
target_include_directories(
project_a_header_lib
INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include/>
)
```

The libraries can then be easily exported as follows:
```cmake
export(
  EXPORT export_${PROJECT_NAME}
  NAMESPACE ${PROJECT_NAME}::
  FILE ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
)
export(PACKAGE ${PROJECT_NAME})
```
The command above creates a default cmake config file which can then be used by other packages to call `find_package()`.
This allows to then link against the imported targets as such:
```
find_package(project_a_headers 0.0.1 REQUIRED)
...
target_link_libraries(
  project_a_library
  project_a_headers::project_a_header_lib
)
```

However, things get complicated and non-straightforward if trying to transitively export dependencies.
In this case, we still (unfortunately) have to write our own cmake config file.
Luckily, there is a way to minimize efforts:
First, we would export our targets as always, just with a little twist:
```cmake
export(
  EXPORT export_${PROJECT_NAME}
  NAMESPACE ${PROJECT_NAME}::
  FILE ${CMAKE_CURRENT_BINARY_DIR}/_${PROJECT_NAME}Config.cmake
)
export(PACKAGE ${PROJECT_NAME})
```
I chose a `_` prefix for the config file to mark it somewhat as private.
Next, we have to write a small config file which finds our target dependencies first and then call the private cmake config file.
```cmake
include(CMakeFindDependencyMacro)
find_dependency(project_a_headers 0.0.1 REQUIRED)
include("${CMAKE_CURRENT_LIST_DIR}/_@PROJECT_NAME@Config.cmake")
```
In our top-level cmake, we have to configure this file appropriately.
```cmake
configure_package_config_file(
  ${CMAKE_CURRENT_LIST_DIR}/cmake/project_aConfig.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/project_aConfig.cmake
  INSTALL_DESTINATION share/${PROJECT_NAME}/cmake
)
```

When calling `find_package(project_a)`, our cmake file, written by hand is called and the dependencies (`project_a_headers`) are being found and included.
