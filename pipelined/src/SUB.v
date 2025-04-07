// `include "NEG.v"
`ifndef NEG_V
`define NEG_V
`include "NEG.v"
`endif

module SUB_64(
    input signed [63:0] a,
    input signed [63:0] b,
    output signed [63:0] result,
    output Overflow
);

    wire [63:0] neg_b;
    wire Cout, Overflow,a1;
    NEG ng(b, neg_b);
    ADD_64 A1(a, neg_b, 1'b0, result, Cout, a1);
    assign Overflow = (a[63] != b[63]) && (result[63] != a[63]);
    
endmodule