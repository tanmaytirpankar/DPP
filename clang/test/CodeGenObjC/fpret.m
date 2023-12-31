// RUN: %clang_cc1 -triple i386-apple-darwin9 -fobjc-runtime=macosx-fragile-10.5 -emit-llvm -o - %s | \
// RUN:   FileCheck --check-prefix=CHECK-X86_32 %s
//
// RUN: %clang_cc1 -triple x86_64-apple-darwin10 -fobjc-runtime=macosx-fragile-10.5 -emit-llvm -o - %s | \
// RUN:   FileCheck --check-prefix=CHECK-X86_64 %s
//
// RUN: %clang_cc1 -triple armv7-apple-darwin10 -fobjc-runtime=macosx-fragile-10.5 -emit-llvm -target-abi apcs-gnu -o - %s | \
// RUN:   FileCheck --check-prefix=CHECK-ARMV7 %s

@interface A
-(float) floatValue;
-(double) doubleValue;
-(long double) longDoubleValue;
@end


// CHECK-X86_32-LABEL: define{{.*}} void @t0()
// CHECK-X86_32: call float @objc_msgSend_fpret
// CHECK-X86_32: call double @objc_msgSend_fpret
// CHECK-X86_32: call x86_fp80 @objc_msgSend_fpret
// CHECK-X86_32: }
//
// CHECK-X86_64-LABEL: define{{.*}} void @t0()
// CHECK-X86_64: call float @objc_msgSend
// CHECK-X86_64: call double @objc_msgSend
// CHECK-X86_64: call x86_fp80 @objc_msgSend_fpret
// CHECK-X86_64: }
//
// CHECK-ARMV7-LABEL: define{{.*}} void @t0()
// CHECK-ARMV7: call float @objc_msgSend
// CHECK-ARMV7: call double @objc_msgSend
// CHECK-ARMV7: call double @objc_msgSend
// CHECK-ARMV7: }
void t0(void) {
  [(A*)0 floatValue];
  [(A*)0 doubleValue];
  [(A*)0 longDoubleValue];
}
