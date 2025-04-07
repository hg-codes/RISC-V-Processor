`include "Adder.v"

module two_one_mux(
    input [63:0] a,
    input [63:0]b,
    input sel,
    output [63:0]out
);

assign out= (sel==0) ? a:b;

endmodule



module program_counter(
    input clk,
    input mux_control,
    input mux_control2,
    input [63:0] branch_address,
    output reg [63:0] instruction_address
);

initial 
begin
instruction_address=64'd0;
end

wire [63:0] temp;

//pc is just a register , registers d at every posedge of the clock cycle

wire [63:0] w1,w2,d,d2;  //wires for default increment and branch

Adder a1(
    .a(instruction_address),
    .b(64'd4),
    .cin(1'b0),
    .sum(w1)
);    //default increment



//now chose which value d should take

two_one_mux i1(
    .a(w1),
    .b(branch_address),
    .sel(mux_control),
    .out(d)
);

two_one_mux i2(
    .a(instruction_address),
    .b(d),
    .sel(mux_control2),
    .out(d2)
);

always@(posedge clk)
begin 
    instruction_address<=d2;
end

endmodule
