`include "IF.v"
`include "IF_ID.v"
`include "ID.v"
`include "ID_EX.v"
`include "EX.v"
`include "EX_MEM.v"
`include "MEM.v"
`include "MEM_WB.v"
`include "WB.v"
`include "FwdUnit.v"
`include "HazardDetection.v"
module processor();
reg clk;
wire [31:0] instruction;
wire [31:0] instruction1;
wire [63:0] branch_address;
wire [63:0] branch_address1,branch_address2;
wire [63:0] address;
wire [63:0] address1,address2,address3;
wire write_enable_from_wb;
wire branch,branch1,branch2;
wire MemRead,MemRead1,MemRead2;
wire MemtoReg,MemtoReg1,MemtoReg2,MemtoReg3;
wire MemWrite,MemWrite1,MemWrite2;
wire ALUSrc,ALUSrc1,ALUSrc2;
wire RegWrite,RegWrite1,RegWrite2,RegWrite3;
wire [1:0] ALUOp;
wire [1:0] ALUOp1;
wire [63:0] read_data1,read_data2,immediate,immediate1;
wire [4:0] rd,rd1,rd2,rd3;
wire [2:0] funct3,funct31;
wire [6:0] funct7,funct71;
wire [63:0] A,B;
wire [1:0] ForwardA,ForwardB;
wire zero;
wire [63:0] MEM_ALU_Out,WB_ALU_Out;
wire [63:0] ALU_out,ALU_out1,ALU_out2;
wire [63:0] save_data,loaded_data_from_mem,loaded_data_from_mem2;
wire PCSrc;
wire [63:0] write_back_to_reg;
wire [4:0] rs1,rs2,ID_EX_rs1,ID_EX_rs2;
wire PCWrite_from_Hazard,IF_ID_Write_from_Hazard,ID_EX_MuxSelect_from_Hazard;

//assign branch_address2=64'b0;
//assign IF_ID_Write_from_Hazard=1'b1;
// assign ID_EX_MuxSelect_from_Hazard=1'b0; 
// assign PCWrite_from_Hazard= (ctrl) ? 1'b0 : 1'b1;
assign write_enable_from_wb=1'b0;
wire [63:0] actual_data_to_write_in_mem;


wire pc_temp;
assign pc_temp= (PCSrc===1'bx) ? 1'b0:PCSrc; 

IF u1(
    .mux_control(pc_temp),
    .mux_control2(PCWrite_from_Hazard),
    .clk(clk),
    .branch_address(branch_address1),
    .instruction(instruction),
    .address(address)
);
IF_ID u2(
    .clk(clk),
    .IF_ID_Flush(pc_temp),
    .address_in(address),
    .instruction_in(instruction),
    .IF_ID_Write(IF_ID_Write_from_Hazard),
    .address_out(address1),
    .instruction_out(instruction1)
);
ID u3(
    .clk(clk),
    .instruction(instruction1),
    .write_enable(RegWrite3),
    .write_data(write_back_to_reg),
    .ID_EX_MuxSelect(ID_EX_MuxSelect_from_Hazard),
    .rd3(rd3),
    .branch(branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp),
    .read_data1(read_data1),
    .read_data2(read_data2),
    .immediate(immediate),
    .rd(rd),
    .funct3(funct3),
    .funct7(funct7),
    .IF_ID_rs1(rs1),
    .IF_ID_rs2(rs2)
);

ID_EX u4(
    .clk(clk),
    .ID_EX_Flush(pc_temp),
    .PC_in(address1),
    .read_data1_in(read_data1),
    .read_data2_in(read_data2),
    .immediate_in(immediate),
    .funct3_in(funct3),
    .funct7_in(funct7),
    .rd_in(rd),
    .branch_in(branch),
    .MemRead_in(MemRead),
    .MemtoReg_in(MemtoReg),
    .MemWrite_in(MemWrite),
    .ALUSrc_in(ALUSrc),
    .RegWrite_in(RegWrite),
    .ALUOp_in(ALUOp),
    .IF_ID_rs1_in(rs1),
    .IF_ID_rs2_in(rs2),


    .PC_out(address2),
    .read_data1_out(A),
    .read_data2_out(B),
    .immediate_out(immediate1),
    .funct3_out(funct31),
    .funct7_out(funct71),
    .rd_out(rd1),
    .branch_out(branch1),
    .MemRead_out(MemRead1),
    .MemtoReg_out(MemtoReg1),
    .ALUSrc_out(ALUSrc1),
    .RegWrite_out(RegWrite1),
    .ALUOp_out(ALUOp1),
    .IF_ID_rs1_out(ID_EX_rs1),
    .IF_ID_rs2_out(ID_EX_rs2),
    .MemWrite_out(MemWrite1)
);

// EX u5(
//     .PC(address2),
//     .immediate(immediate1),
//     .funct3(funct31),
//     .funct7(funct71),
//     .ALUSrc(ALUSrc1),
//     .ALUOp(ALUOp1),
//     .read_data1(A),
//     .read_data2(B),
//     .ForwardA(ForwardA),
//     .ForwardB(ForwardB),
//     .MEM_ALU_Out(MEM_ALU_Out),
//     .WB_ALU_Out(WB_ALU_Out),
//     .branch_address(branch_address1),
//     .zero(zero),
//     .ALU_out(ALU_out)
// );

EX u5(
    .PC(address2),
    .immediate(immediate1),
    .funct3(funct31),
    .funct7(funct71),
    .ALUSrc(ALUSrc1),
    .ALUOp(ALUOp1),
    .read_data1(A),
    .read_data2(B),
    .ForwardA(ForwardA),
    .ForwardB(ForwardB),
    .MEM_ALU_Out(ALU_out1),
    .WB_ALU_Out(write_back_to_reg),  
    .branch_address(branch_address1),
    .ALU_out(ALU_out),
    .input_data_for_mem(actual_data_to_write_in_mem),
    .branch(branch1),
    .PCSrc(PCSrc)
);

EX_MEM u6(
    .clk(clk),
    .RegWrite_in(RegWrite1),
    .MemtoReg_in(MemtoReg1),
    .MemWrite_in(MemWrite1),
    .MemRead_in(MemRead1),
    .ALU_out_in(ALU_out),
    .rd_in(rd1),
    .read_data2_in(actual_data_to_write_in_mem),

    .RegWrite_out(RegWrite2),
    .MemtoReg_out(MemtoReg2),
    .MemWrite_out(MemWrite2),
    .MemRead_out(MemRead2),
    .ALU_out_out(ALU_out1),
    .rd_out(rd2),
    .read_data2_out(save_data)
);

MEM u7(
    .clk(clk),
    .memory_address(ALU_out1),
    .write_data(save_data),
    .MemWrite(MemWrite2),
    .MemRead(MemRead2),
    .read_data(loaded_data_from_mem)
);

MEM_WB u8(
    .clk(clk),
    .MemtoReg_in(MemtoReg2),
    .RegWrite_in(RegWrite2),
    .data_from_memory_in(loaded_data_from_mem),
    .ALU_out_in(ALU_out1),
    .rd_in(rd2),

    .MemtoReg_out(MemtoReg3),
    .RegWrite_out(RegWrite3),
    .data_from_memory_out(loaded_data_from_mem2),
    .ALU_out_out(ALU_out2),
    .rd_out(rd3)
);
WB u9(
    .read_data(loaded_data_from_mem2),
    .ALU_out(ALU_out2),
    .MemtoReg(MemtoReg3),
    .write_data(write_back_to_reg)
);
ForwardingUnit u10(
    .ID_EX_RegisterRs1(ID_EX_rs1),
    .ID_EX_RegisterRs2(ID_EX_rs2),
    .EX_MEM_RegisterRd(rd2),
    .MEM_WB_RegisterRd(rd3),
    .EX_MEM_RegWrite(RegWrite2),
    .MEM_WB_RegWrite(RegWrite3),

    .ForwardA(ForwardA),
    .ForwardB(ForwardB)
);
HazardDetectionUnit u11(
    .ID_EX_RegisterRd(rd1),
    .IF_ID_RegisterRs1(rs1),
    .IF_ID_RegisterRs2(rs2),
    .ID_EX_MEMRead(MemRead1),

    .PCWrite(PCWrite_from_Hazard),
    .IF_ID_Write(IF_ID_Write_from_Hazard),
    .ID_EX_MuxSelect(ID_EX_MuxSelect_from_Hazard)
);


reg ctrl;
initial begin
    ctrl=1'b1;
    #10
    ctrl=1'b0;
end


initial begin
    clk=1'b0;
    forever #1 clk=~clk;
end


initial begin
    $dumpfile("main.vcd");
    $dumpvars(0,processor);
    #10000 $finish;
end



// integer i;
// initial begin
//   #1000;
//   $monitor("Mem[0] = %d, Mem[1] = %d, Mem[2] = %d", mem[0], mem[1], mem[2]);  
// end

// initial begin
//     $monitor("time:%0t,clk:%d,branch:%d",$time,clk,branch);
// end
endmodule