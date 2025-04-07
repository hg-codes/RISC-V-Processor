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
    input [63:0] immediate,
    output reg [63:0] instruction_address
);

initial instruction_address=64'd0;

wire [63:0] temp;
assign temp= immediate << 1;

//pc is just a register , registers d at every posedge of the clock cycle

wire [63:0] w1,w2,d;  //wires for default increment and branch

Adder a1(
    .a(instruction_address),
    .b(64'd4),
    .cin(1'b0),
    .sum(w1)
);    //default increment


Adder a2(
    .a(instruction_address),
    .b(temp),
    .cin(1'b0),
    .sum(w2)
);  //branch increment


//now chose which value d should take

two_one_mux i1(
    .a(w1),
    .b(w2),
    .sel(mux_control),
    .out(d)
);

always@(posedge clk)
begin 
    instruction_address<=d;
end

endmodule
