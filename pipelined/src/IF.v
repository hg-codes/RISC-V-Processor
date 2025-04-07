`include "program_counter.v"
`include "instruction_memory.v"
module IF(
    input mux_control,
    input mux_control2,
    input clk,
    input [63:0] branch_address,
    output [31:0] instruction,
    output [63:0] address
);

wire [63:0] instruction_address;
assign address=instruction_address;
program_counter uut(
    .clk(clk),
    .mux_control(mux_control),
    .mux_control2(mux_control2),
    .branch_address(branch_address),
    .instruction_address(instruction_address)
);


instruction_memory mem1(
.read_address(instruction_address[31:0]),
.instruction(instruction)
);

endmodule