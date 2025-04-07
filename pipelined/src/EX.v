`ifndef EX
`define EX

`include "add_gen.v"
`include "alu_control.v"
`include "MUX2.v"
`include "ALU.v"


module EX(
    input [63:0] PC,
    input [63:0] immediate,
    input [2:0] funct3,
    input [6:0] funct7,
    input ALUSrc,
    input branch,
    input [1:0]ALUOp,
    input [63:0] read_data1,read_data2,
    input [1:0] ForwardA,
    input [1:0] ForwardB,
    input [63:0] MEM_ALU_Out,
    input [63:0] WB_ALU_Out,

    output [63:0] branch_address,
    output [63:0] ALU_out,
    output [63:0] input_data_for_mem,
    output PCSrc

    );
    wire [63:0] dummy,selected_A,selected_B;
    wire [3:0] alu_op_to_alu;
    wire zero_to_and_gate;
    
    

    assign selected_A=(ForwardA==2'b00)?read_data1:
                      (ForwardA==2'b01)?WB_ALU_Out:
                      (ForwardA==2'b10)?MEM_ALU_Out:64'bx;

     assign dummy=(ForwardB==2'b00)?read_data2:
                      (ForwardB==2'b01)?WB_ALU_Out:
                      (ForwardB==2'b10)?MEM_ALU_Out:64'bx;

    assign selected_B=(ALUSrc==0) ? dummy : immediate; // one of choices in B
    assign input_data_for_mem=dummy;

    alu_control u2(
        .funct7(funct7),
        .funct3(funct3),
        .alu_op(ALUOp),
        .alu_ctl(alu_op_to_alu)
    );
    ALU_64 u3(
        .A(selected_A),
        .B(selected_B),
        .ALU_control(alu_op_to_alu),
        .out(ALU_out),
        .zero(zero_to_and_gate)
    );
    add_gen u4(
        .pc(PC),
        .immediate(immediate),
        .branch_address(branch_address)
    );
    assign PCSrc = branch & zero_to_and_gate;
    assign zero=zero_to_and_gate;

    
endmodule
`endif
