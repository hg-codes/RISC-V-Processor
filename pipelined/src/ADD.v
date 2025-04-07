// `include "full_adder.v"
`ifndef FULL_ADDER_V
`define FULL_ADDER_V
`include "full_adder.v"
`endif

module ADD_64(
    input [63:0] A,
    input [63:0] B,
    input Cin,
    output [63:0] S,
    output Cout,
    output Overflow
);

    wire [64:0] C;
    wire Cout;
    assign C[0] = Cin;

    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin
            full_adder FA(A[i], B[i], C[i], S[i], C[i+1]);
        end
    endgenerate

    // assign Cout = C[64]& ~(A[63] ^ B[63]);
    wire c1;
    xnor x1(c1, B[63], A[63]);
    and a1(Cout, c1, C[64]);

    // Overflow detection for signed addition
    assign Overflow = (A[63] == B[63]) && (S[63] != A[63]);

endmodule