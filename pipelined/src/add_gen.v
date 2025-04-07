`include "Adder.v"
module add_gen(
    input [63:0] pc,
    input [63:0] immediate,
    output [63:0] branch_address
);

wire [63:0] temp;
assign temp= immediate << 1; // temp=2*immediate

Adder a1(
    .a(pc),
    .b(temp),
    .cin(1'b0),
    .sum(branch_address)
);
endmodule

