#include <iostream>

int doSomething() {
  return 42;
}

auto main(int /*argc*/, char * * /*argv*/) -> int {
  std::cout << "Testing" << std::endl;
  std::cout << doSomething() << std::endl;
  return 0;
}
