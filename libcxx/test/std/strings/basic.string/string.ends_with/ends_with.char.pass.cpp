//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
// UNSUPPORTED: c++03, c++11, c++14, c++17

// <string>

// constexpr bool ends_with(charT x) const noexcept;

#include <string>
#include <cassert>

#include "test_macros.h"

constexpr bool test() {
  {
    typedef std::string S;
    S s1{};
    S s2{"abcde", 5};

    ASSERT_NOEXCEPT(s1.ends_with('e'));

    assert(!s1.ends_with('e'));
    assert(!s1.ends_with('x'));
    assert(s2.ends_with('e'));
    assert(!s2.ends_with('x'));
  }

  return true;
}

int main(int, char**) {
  test();
  static_assert(test());

  return 0;
}
