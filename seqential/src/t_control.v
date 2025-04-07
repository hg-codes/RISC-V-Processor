`include "control.v"
`include "alu_control.v"

module control_alu_tb;
    // Inputs
    reg [6:0] instruction;
    reg [6:0] funct7;
    reg [2:0] funct3;

    // Outputs from Control Unit
    wire branch;
    wire MemRead;
    wire MemtoReg;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire [1:0] ALUOp;

    // Output from ALU Control Unit
    wire [3:0] alu_ctl;

    // Instantiate Control Unit
    control control_unit (
        .instruction(instruction),
        .branch(branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp)
    );

    // Instantiate ALU Control Unit
    alu_control alu_control_unit (
        .funct7(funct7),
        .funct3(funct3),
        .alu_op(ALUOp),
        .alu_ctl(alu_ctl)
    );

    // Test procedure
    initial begin
        $dumpfile("control_alu_tb.vcd");
        $dumpvars(0, control_alu_tb);
        
        // Test R-type (add)
        instruction = 7'b0110011; funct7 = 7'b0000000; funct3 = 3'b000;
        #10;
        $display("R-type ADD: ALUOp=%b, ALU Control=%b", ALUOp, alu_ctl);

        // Test R-type (sub)
        instruction = 7'b0110011; funct7 = 7'b0100000; funct3 = 3'b000;
        #10;
        $display("R-type SUB: ALUOp=%b, ALU Control=%b", ALUOp, alu_ctl);

        // Test R-type (or)
        instruction = 7'b0110011; funct7 = 7'b0000000; funct3 = 3'b110;
        #10;
        $display("R-type OR: ALUOp=%b, ALU Control=%b", ALUOp, alu_ctl);

        // Test R-type (and)
        instruction = 7'b0110011; funct7 = 7'b0000000; funct3 = 3'b111;
        #10;
        $display("R-type AND: ALUOp=%b, ALU Control=%b", ALUOp, alu_ctl);

        // Test Load (ld)
        instruction = 7'b0000011;
        #10;
        $display("LD: ALUOp=%b, ALU Control=%b", ALUOp, alu_ctl);

        // Test Store (sd)
        instruction = 7'b0100011;
        #10;
        $display("SD: ALUOp=%b, ALU Control=%b", ALUOp, alu_ctl);

        // Test Branch (beq)
        instruction = 7'b1100111;
        #10;
        $display("BEQ: ALUOp=%b, ALU Control=%b", ALUOp, alu_ctl);

        // Test Default (Invalid opcode)
        instruction = 7'b1111111;
        #10;
        $display("Invalid Opcode: ALUOp=%b, ALU Control=%b", ALUOp, alu_ctl);

        $finish;
    end
endmodule
