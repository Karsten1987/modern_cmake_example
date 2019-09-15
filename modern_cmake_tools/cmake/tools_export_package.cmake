macro(tools_export_package)
  if(NOT PROJECT_NAME)
    message(FATAL_ERROR "No PROJECT_NAME variable set in cmake")
  endif()

  cmake_parse_arguments(TOOLS_EXPORT "" "" "DEPENDENCIES;TARGETS" ${ARGN})
  if(TOOLS_EXPORT_UNPARSED_ARGUMENTS)
  message(FATAL_ERROR "ament_package() called with unused arguments: "
    "${TOOLS_EXPORT_UNPARSED_ARGUMENTS}")
  endif()

  # export dependencies
  if(DEFINED TOOLS_EXPORT_DEPENDENCIES)
    list(APPEND PROJECT_DEPENDENCIES ${TOOLS_EXPORT_DEPENDENCIES})
  endif()

  # export targets
  if(DEFINED TOOLS_EXPORT_TARGETS)
    foreach(target ${TOOLS_EXPORT_TARGETS})
      if(NOT TARGET ${target})
        message(FATAL_ERROR "${target} is not a cmake target")
      endif()

      # install target to export set
      install(
        TARGETS ${target}
        EXPORT export_${PROJECT_NAME}
      )
    endforeach()

    # install export set
    install(
      EXPORT export_${PROJECT_NAME}
      NAMESPACE ${PROJECT_NAME}::
      DESTINATION "share/${PROJECT_NAME}/cmake"
    )
  else()
    message(WARNING "no targets defined")
  endif()

  if(PROJECT_VERSION)
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
  else()
    message(WARNING "No PROJECT_VERSION set, unable to write versions file")
  endif()

  include(CMakePackageConfigHelpers)
  configure_package_config_file(
    ${modern_cmake_tools_DIR}/Config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    INSTALL_DESTINATION share/${PROJECT_NAME}/cmake
  )
  install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    DESTINATION share/${PROJECT_NAME}/cmake
  )
endmacro()
