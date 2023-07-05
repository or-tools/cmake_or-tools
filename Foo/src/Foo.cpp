#include <foo/Foo.hpp>

#include <ortools/constraint_solver/constraint_solver.h>
#include <iostream>

namespace foo {
  void helloWorld() {
		std::cout << "foo::hello()";
  }

void Foo::operator()() const {
	std::cout << "foo::Foo()()";
}
}

