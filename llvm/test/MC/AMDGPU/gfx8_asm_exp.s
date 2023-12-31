// RUN: llvm-mc -triple=amdgcn -mcpu=tonga -show-encoding %s | FileCheck %s

exp mrt0 v0, v0, v0, v0
// CHECK: [0x0f,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrtz v0, v0, v0, v0
// CHECK: [0x8f,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp null v0, v0, v0, v0
// CHECK: [0x9f,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp pos0 v0, v0, v0, v0
// CHECK: [0xcf,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp param0 v0, v0, v0, v0
// CHECK: [0x0f,0x02,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 v255, v0, v0, v0
// CHECK: [0x0f,0x00,0x00,0xc4,0xff,0x00,0x00,0x00]

exp mrt0 v0, v255, v0, v0
// CHECK: [0x0f,0x00,0x00,0xc4,0x00,0xff,0x00,0x00]

exp mrt0 v0, v0, v255, v0
// CHECK: [0x0f,0x00,0x00,0xc4,0x00,0x00,0xff,0x00]

exp mrt0 v0, v0, v0, v255
// CHECK: [0x0f,0x00,0x00,0xc4,0x00,0x00,0x00,0xff]

exp mrt0 v0, off, off, off
// CHECK: [0x01,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 off, v0, off, off
// CHECK: [0x02,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 v0, v0, off, off
// CHECK: [0x03,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 off, off, v0, off
// CHECK: [0x04,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 v0, off, v0, off
// CHECK: [0x05,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 off, v0, v0, off
// CHECK: [0x06,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 v0, v0, v0, off
// CHECK: [0x07,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 off, off, off, v0
// CHECK: [0x08,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 v0, off, off, v0
// CHECK: [0x09,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 off, v0, off, v0
// CHECK: [0x0a,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 v0, v0, off, v0
// CHECK: [0x0b,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 off, off, v0, v0
// CHECK: [0x0c,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 v0, off, v0, v0
// CHECK: [0x0d,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 off, v0, v0, v0
// CHECK: [0x0e,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 off, off, off, off
// CHECK: [0x00,0x00,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 v0, v0, v0, v0 done
// CHECK: [0x0f,0x08,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 v0, v0, v0, v0 compr
// CHECK: [0x0f,0x04,0x00,0xc4,0x00,0x00,0x00,0x00]

exp mrt0 v0, v0, v0, v0 vm
// CHECK: [0x0f,0x10,0x00,0xc4,0x00,0x00,0x00,0x00]
