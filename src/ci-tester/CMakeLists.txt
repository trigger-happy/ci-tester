set(TARGETNAME "ci-tester")

file(
  GLOB SRC_FILES
  *.cpp
)

add_executable(
  ${TARGETNAME}
  ${SRC_FILES}
)

set_property(
  TARGET ${TARGETNAME}
  PROPERTY
  CXX_STANDARD 17
)

target_include_directories(
  ${TARGETNAME}
  PRIVATE
)

target_link_libraries(
  ${TARGETNAME}
  PRIVATE
)

install(
  TARGETS ${TARGETNAME}
  DESTINATION "bin/"
)

if(CLANG_TIDY AND ENABLE_CLANG_TIDY)
  add_custom_target(
    ${TARGETNAME}_clang_tidy
    COMMAND ${CLANG_TIDY}
    ${SRC_FILES}
    --
    -std=c++17
  )

  add_dependencies(
    all-tidy
    ${TARGETNAME}_clang_tidy
  )
endif()

if(CLANG_FORMAT AND ENABLE_CLANG_FORMAT)
  add_custom_target(
    ${TARGETNAME}_clang_format
    COMMAND ${CLANG_FORMAT}
    -i ${SRC_FILES}
  )

  add_dependencies(
    all-format
    ${TARGETNAME}_clang_format
  )
endif()
