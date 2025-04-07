`include "ALU.v"
`include "alu_control.v"
`include "control.v"
`include "imm_gen.v"
`include "data_memory.v"
`include "IF.v"
`include "regfile.v"
`include "MUX2.v"
module processor();
//processor takes nothing as input, everything is prsent in memory itself from before hand
reg clk;
wire [31:0] instruction;
wire write_enable;
wire [63:0] read_data1,read_data2,write_data;

//making a regfile 
register_file uut(
.clk(clk),
.rs1(instruction[19:15]),
.rs2(instruction[24:20]),
.rd(instruction[11:7]),
.write_data(write_data),
.write_enable(write_enable),
.read_data1(read_data1),
.read_data2(read_data2)
);


//calling the control block 

wire branch , MemRead , MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;

assign write_enable=RegWrite;

control uut1(
    .instruction(instruction[6:0]),
    .branch(branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
);


//calling the alu control block 
wire [3:0] alu_ctl;

alu_control uut2(
    .funct7(instruction[31:25]),
    .funct3(instruction[14:12]),
    .alu_op(ALUOp),
    .alu_ctl(alu_ctl)
);

//calling the immediate block 

wire [63:0] immediate;

immediate_generate uut3(
    .instruction(instruction),
    .immediate(immediate)
);


//calling the ALU as the given signal are now there
wire [63:0] B,alu_result;
wire zero;
assign B= (ALUSrc==0) ? read_data2: immediate;
ALU_64 uut4(
    .A(read_data1),
    .B(B),
    .ALU_control(alu_ctl),
    .out(alu_result),
    .zero(zero)
);



//Calling the instruction fetch , as we now have all of its's available inputs

wire mux_control;

and(mux_control,branch,zero);

wire [63:0]address;

IF uut5(
    .mux_control(mux_control),
    .clk(clk),
    .immediate(immediate),
    .address(address),
    .instruction(instruction)
);


//calling the data memory

wire[63:0] read_data;

data_memory uut6(
    .clk(clk),
    .mem_write(MemWrite),
    .mem_read(MemRead),
    .address(alu_result),
    .write_data(read_data2),
    .read_data(read_data)
);


//writing back the data to the regfile

assign write_data= (MemtoReg==1) ? read_data : alu_result;

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

initial begin
    $monitor("time:%0t,clk:%d,branch:%d",$time,clk,branch);
end

endmodule