// 2s compliment of the number

`ifndef ADD_V
`define ADD_V
`include "ADD.v"
`endif

`ifndef NOT_V
`define NOT_V
`include "NOT.v"
`endif

module NEG(
    input wire[63:0] A,
    output wire[63:0] Y
);
    wire[63:0] A_1;
    wire Cout, Overflow;
    NOT_64 not1(A, A_1);
    ADD_64 add1(A_1, 64'b1,1'b0, Y,Cout,Overflow);
endmodule