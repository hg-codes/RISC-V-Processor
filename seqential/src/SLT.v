// `include "SUB.v"
`ifndef SUB_V
`define SUB_V
`include "SUB.v"
`endif

module SLT_64(
    input signed [63:0] A,
    input signed [63:0] B,
    output signed [63:0] Y
);
    
    wire [63:0] diff;
    wire Overflow;
    SUB_64 sub(A, B, diff,Overflow);
    // assign Y = {63'b0, diff[63]};
    assign Y = {63'b0, (Overflow ? A[63] : diff[63])};

endmodule