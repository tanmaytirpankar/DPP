//===-- Unittests for memcpy ----------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "memory_utils/memory_check_utils.h"
#include "src/string/memcpy.h"
#include "test/UnitTest/Test.h"

namespace __llvm_libc {

// Adapt CheckMemcpy signature to memcpy.
static inline void Adaptor(cpp::span<char> dst, cpp::span<char> src,
                           size_t size) {
  __llvm_libc::memcpy(dst.begin(), src.begin(), size);
}

TEST(LlvmLibcMemcpyTest, SizeSweep) {
  static constexpr size_t kMaxSize = 400;
  Buffer SrcBuffer(kMaxSize);
  Buffer DstBuffer(kMaxSize);
  Randomize(SrcBuffer.span());
  for (size_t size = 0; size < kMaxSize; ++size) {
    auto src = SrcBuffer.span().subspan(0, size);
    auto dst = DstBuffer.span().subspan(0, size);
    ASSERT_TRUE(CheckMemcpy<Adaptor>(dst, src, size));
  }
}

} // namespace __llvm_libc
