//writing a risc 5 code to sort an array 

    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                // Swap arr[j] and arr[j+1]
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
j < n-i-1
j=n-i-2 //loop finish

// assembly code
x2 contains the base address of the array
x1 contains the value of n
x6 contains the value 1
x7 has value 2

// start
0                    add x26 x0 x0  // i=0 
4                    sub x31 x1 x6  //  x31 contains n-2 SAY(P)
8    Loop1:          beq x26 x31 Exit
12                   add x27 x0 x0 // j=0
16                   sub x30 x1 x26  // n-i
20                   sub x30 x30 x6 // n-i-1
24    Loop2:         beq x27 x30 Temp
28                   add x20 x2 x27  // address of arr[j]
32                   add x22 x27 x6  // calcualted j+1
36                   add x21 x2 x22   // address of arr[j+1]
40                   ld  x18 0(x20)   // x18= arr[j]
44                   ld x19 0(x21)    // x19=arr[j+1]
48                   blt x19 x18 swap  // swap arr[j] & arr[j+1]
52    intermediate:  add x27 x27 x6   // j=j+1
56                   beq x0 x0 Loop2  // go back to beginnig
60    Temp:          add x26 x26 x6     // i=i+1
64                   beq x0 x0 Loop1
68    Swap:          sd x18 0(x21)
72                   sd x19 0(x20)
76                   beq x0 x0 intermediate
80    Exit:

// machine code in 32 bits
0000000 00000 00000 000 11010 0110011
0100000 00110 00001 000 11111 0110011
0 000010 11111 11010 000 0100 0 1100011
0000000 00000 00000 000 11011 0110011
0100000 00111 11010 000 11110 0110011
0100000 11110 00001 000 11110 0110011
0 000001 11110 11011 000 0010 0 1100011
0000000 11011 00010 000 10100 0110011
0000000 00110 11011 000 10110 0110011
0000000 10110 00010 000 10101 0110011
000000000000 10100 011 10010 0000011
000000000000 10101 011 10011 0000011
0 000000 10010 10011 100 0000 0 1100011
0000000 00110 11011 000 11011 0110011
1 111111 00000 00000 000 0000 1 1100011
0000000 00110 11010 000 11010 0110011
1 111110 00000 00000 000 01001 1100011
0000000 10010 10101 011 00000 0100011
0000000 10011 10100 011 00000 0100011
1 111111 00000 00000 000 01001 1100011

// machine code without space
00000000000000000000110100110011
01000000011100001000111110110011
00000101111111010000010001100011
00000000000000000000110110110011
01000000011111010000111100110011
01000001111000001000111100110011
00000011111011011000001001100011
00000001101100010000101000110011
00000000011011011000101100110011
00000001011000010000101010110011
00000000000010100011100100000011
00000000000010101011100110000011
00000001001010011100101001100011
00000000011011011000110110110011
11111110000000000000000011100011
00000000011011010000110100110011
11111100000000000000010011100011
00000001001010101011000000100011
00000001001110100011000000100011
11111110000000000000010011100011





// start
0                    add x26 x0 x0  // i=0 
4                    sub x31 x1 x6  //  x31 contains n-2 SAY(P)
8    Loop1:          beq x26 x31 Exit
12                   add x27 x0 x0 // j=0
16                   sub x30 x1 x26  // n-i
20                   sub x30 x30 x6 // n-i-1
24    Loop2:         beq x27 x30 Temp
28                   add x20 x2 x27  // address of arr[j]
32                   add x22 x27 x6  // calcualted j+1
36                   add x21 x2 x22   // address of arr[j+1]
40                   ld  x18 0(x20)   // x18= arr[j]
44                   ld x19 0(x21)    // x19=arr[j+1]
48                   blt x19 x18 swap  // swap arr[j] & arr[j+1]
52    intermediate:  add x27 x27 x6   // j=j+1
56                   beq x0 x0 Loop2  // go back to beginnig
60    Temp:          add x26 x26 x6     // i=i+1
64                   beq x0 x0 Loop1
68    Swap:          sd x18 0(x21)
72                   sd x19 0(x20)
76                   beq x0 x0 intermediate
80    Exit: