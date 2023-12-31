; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -passes=newgvn -S < %s | FileCheck %s

declare void @use(i1)

define void @test1(float %x, float %y) {
; CHECK-LABEL: define void @test1
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = fcmp oeq float [[Y]], [[X]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = fcmp nnan oeq float %y, %x
  %cmp2 = fcmp oeq float %x, %y
  call void @use(i1 %cmp1)
  call void @use(i1 %cmp2)
  ret void
}
