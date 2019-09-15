cmake_minimum_required(VERSION 3.5)
set(modern_cmake_toolsVERSION 0.0.1)
project(modern_cmake_tools VERSION ${modern_cmake_toolsVERSION})

install(
  DIRECTORY cmake
  DESTINATION share/${PROJECT_NAME}
)

include(CMakePackageConfigHelpers)
configure_package_config_file(
  ${CMAKE_CURRENT_LIST_DIR}/modern_cmake_toolsConfig.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/modern_cmake_toolsConfig.cmake
  INSTALL_DESTINATION share/${PROJECT_NAME}/cmake
)
install(
  FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
  DESTINATION share/${PROJECT_NAME}/cmake
)
