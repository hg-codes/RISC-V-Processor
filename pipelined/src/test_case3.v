// design details of all the stages of the process architecture
// challenges encountered
// simulations snapshot

// test cases
// 1. sum of all elements of an array of length n
// 2. counting even number of elements in an array 
// 3. sort an array

// verilog code
// testbench


// extra test case for the pipeline implementation
// supporting only structure and data hazard
// sum of elements of an array of fixed lenth 5 and then storing it in memory, update it to its doubled and then store it in memory

// assembly code in risc-v
// x4 ans , x2 base address of an array length 5
// x3 address of memory where the ans has to be stored

ld x5, 0(x2)
ld x6, 1(x2)
ld x7, 2(x2)
ld x8, 3(x2)
ld x9, 4(x2)
add x12, x5, x6
add x11, x7, x8
// double data hazard
add x4, x12, x11
add x4, x4, x9
sd x4, 0(x3)
ld x10, 0(x3)
add x10, x10, x10
sd x10, 0(x3)

// corresponding machine code in 32 bits
000000000000_00010_011_00101_0000011
000000000001_00010_011_00110_0000011
000000000010_00010_011_00111_0000011
000000000011_00010_011_01000_0000011
000000000100_00010_011_01001_0000011
0000000_00110_00101_000_01100_0110011
0000000_01000_00111_000_01011_0110011
0000000_01011_01100_000_00100_0110011
0000000_01001_00100_000_00100_0110011
0000000_00100_00011_011_00000_0100011
000000000000_00011_011_01010_0000011
0000000_01010_01010_000_01010_0110011
0000000_01010_00011_011_00000_0100011