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
  RUNTIME
  DESTINATION "bin/"
)

