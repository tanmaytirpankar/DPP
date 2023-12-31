; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=constraint-elimination -S %s | FileCheck %s

declare void @use(i1)

define void @loop_pointer_iv(ptr %start, ptr %end, ptr %upper) {
; CHECK-LABEL: @loop_pointer_iv(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[END_LT_UPPER:%.*]] = icmp ult ptr [[END:%.*]], [[UPPER:%.*]]
; CHECK-NEXT:    br i1 [[END_LT_UPPER]], label [[LOOP_HEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi ptr [ [[START:%.*]], [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[C_2:%.*]] = icmp ule ptr [[IV]], [[END]]
; CHECK-NEXT:    call void @use(i1 [[C_2]])
; CHECK-NEXT:    [[T_2:%.*]] = icmp uge ptr [[IV]], [[START]]
; CHECK-NEXT:    call void @use(i1 [[T_2]])
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule ptr [[IV]], [[END]]
; CHECK-NEXT:    br i1 [[C_1]], label [[LOOP_LATCH]], label [[EXIT]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[IV_NEXT]] = getelementptr inbounds i8, ptr [[IV]], i8 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %end.lt.upper = icmp ult ptr %end, %upper
  br i1 %end.lt.upper, label %loop.header, label %exit

loop.header:
  %iv = phi ptr [ %start, %entry ], [ %iv.next, %loop.latch ]
  %c.2 = icmp ule ptr %iv, %end
  call void @use(i1 %c.2)
  %t.2 = icmp uge ptr %iv, %start
  call void @use(i1 %t.2)
  %c.1 = icmp ule ptr %iv, %end
  br i1 %c.1, label %loop.latch, label %exit

loop.latch:
  %t.1 = icmp ult ptr %iv, %upper
  call void @use(i1 %t.1)
  %iv.next = getelementptr inbounds i8, ptr %iv, i8 1
  br label %loop.header

exit:
  ret void
}

define void @loop_pointer_iv_null_start(ptr %end, ptr %upper) {
; CHECK-LABEL: @loop_pointer_iv_null_start(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[END_LT_UPPER:%.*]] = icmp ult ptr [[END:%.*]], [[UPPER:%.*]]
; CHECK-NEXT:    br i1 [[END_LT_UPPER]], label [[LOOP_HEADER:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi ptr [ null, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[C_1:%.*]] = icmp ule ptr [[IV]], [[END]]
; CHECK-NEXT:    call void @use(i1 [[C_1]])
; CHECK-NEXT:    [[C_2:%.*]] = icmp uge ptr [[IV]], null
; CHECK-NEXT:    call void @use(i1 [[C_2]])
; CHECK-NEXT:    [[C_3:%.*]] = icmp ule ptr [[IV]], [[END]]
; CHECK-NEXT:    br i1 [[C_3]], label [[LOOP_LATCH]], label [[EXIT]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[IV_NEXT]] = getelementptr inbounds i8, ptr [[IV]], i8 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %end.lt.upper = icmp ult ptr %end, %upper
  br i1 %end.lt.upper, label %loop.header, label %exit

loop.header:
  %iv = phi ptr [ null, %entry ], [ %iv.next, %loop.latch ]
  %c.1 = icmp ule ptr %iv, %end
  call void @use(i1 %c.1)
  %c.2 = icmp uge ptr %iv, null
  call void @use(i1 %c.2)
  %c.3 = icmp ule ptr %iv, %end
  br i1 %c.3, label %loop.latch, label %exit

loop.latch:
  %c.4 = icmp ult ptr %iv, %upper
  call void @use(i1 %c.4)
  %iv.next = getelementptr inbounds i8, ptr %iv, i8 1
  br label %loop.header

exit:
  ret void
}

define void @test_start_null_cmp_null(ptr %start) {
; CHECK-LABEL: @test_start_null_cmp_null(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi ptr [ null, [[ENTRY:%.*]] ], [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ]
; CHECK-NEXT:    [[CMP_I_I122:%.*]] = icmp eq ptr [[IV]], null
; CHECK-NEXT:    br i1 [[CMP_I_I122]], label [[LOOP_LATCH]], label [[EXIT:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[IV_NEXT]] = getelementptr inbounds i8, ptr [[IV]], i64 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %iv = phi ptr [ null, %entry ], [ %iv.next, %loop.latch ]
  %cmp.i.i122 = icmp eq ptr %iv, null
  br i1 %cmp.i.i122, label %loop.latch, label %exit

loop.latch:
  %iv.next = getelementptr inbounds i8, ptr %iv, i64 1
  br label %loop.header

exit:
  ret void
}
