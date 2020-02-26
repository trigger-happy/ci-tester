#include <iostream>

int doSomething() {
  return 42;
}

void doNothing() {
  std::cout << "This function doesn't really do anyting" << std::endl;
}

auto main(int /*argc*/, char * * /*argv*/) -> int {
  std::cout << "Testing" << std::endl;
  std::cout << doSomething() << std::endl;
  doNothing();
  return 0;
}
