// RUN: %clang_cc1 -fblocks -fobjc-arc -fobjc-runtime-has-weak -triple x86_64-apple-darwin -emit-llvm %s -o - | FileCheck %s

@class NSString;

void Test12759433(void) {
 __block __unsafe_unretained NSString *uuByref = (__bridge NSString *)(void*)0x102030405060708;
 void (^block)(void) = ^{ uuByref = 0; };
 block();
}
// CHECK: %struct.__block_byref_uuByref = type { ptr, ptr, i32, i32, ptr }
int main(void) {
  __block __weak id wid;
  __block long XXX;
  __block id ID;
  __block struct S {
     int iS;
     double iD;
     void *pv;
     __unsafe_unretained id unsunr;
  } import;
  void (^c)(void) = ^{
// Inline flag for BYREF variable layout (1107296256): BLOCK_BYREF_HAS_COPY_DISPOSE BLOCK_BYREF_LAYOUT_WEAK
// CHECK: store i32 1107296256, ptr [[T0:%.*]]
  wid = 0;

// Inline flag for BYREF variable layout (536870912): BLOCK_BYREF_LAYOUT_NON_OBJECT
// CHECK: store i32 536870912, ptr [[T1:%.*]]
    XXX = 12345;

// Inline flag for BYREF variable layout (838860800): BLOCK_BYREF_HAS_COPY_DISPOSE BLOCK_BYREF_LAYOUT_STRONG
// CHECK: store i32 838860800, ptr [[T2:%.*]]
    ID = 0;

// Inline flag for BYREF variable layout (268435456): BLOCK_BYREF_LAYOUT_EXTENDED
// BYREF variable layout: BL_NON_OBJECT_WORD:3, BL_UNRETAINED:1, BL_OPERATOR:0
// CHECK: store i32 268435456, ptr [[T3:%.*]]
    import.iD = 3.14;

  };
  c();
}

typedef char mds_path_t[1024];
void directVolumePerfWaitForStoreState(void)
{
 __block mds_path_t path;
}
