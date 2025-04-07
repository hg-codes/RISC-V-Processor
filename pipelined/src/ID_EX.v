`ifndef ID_EX
`define ID_EX
module ID_EX(input wire clk,
                        input wire ID_EX_Flush,
                        input wire [63:0] PC_in,
                        input wire [63:0] read_data1_in,
                        input wire [63:0] read_data2_in,
                        input wire [63:0] immediate_in,
                        input wire [2:0] funct3_in,
                        input wire [6:0] funct7_in,
                        input wire [4:0] rd_in,
                        input wire branch_in,
                        input wire MemRead_in,                       
                        input wire MemtoReg_in,
                        input wire MemWrite_in,
                        input wire ALUSrc_in,
                        input wire RegWrite_in,
                        input wire [1:0] ALUOp_in,
                        input wire [4:0] IF_ID_rs1_in,
                        input wire [4:0] IF_ID_rs2_in,
                        
                        output reg [63:0] PC_out,
                        output reg [63:0] read_data1_out,
                        output reg [63:0] read_data2_out,
                        output reg [63:0] immediate_out,
                        output reg [2:0] funct3_out,
                        output reg [6:0] funct7_out,
                        output reg [4:0] rd_out,
                        output reg branch_out,
                        output reg MemRead_out,
                        output reg MemtoReg_out,
                        output reg MemWrite_out,
                        output reg ALUSrc_out,
                        output reg RegWrite_out,
                        output reg [1:0] ALUOp_out,
                        output reg [4:0] IF_ID_rs1_out,
                        output reg [4:0] IF_ID_rs2_out
                        );
    always@(posedge clk)
begin
   if(ID_EX_Flush==0)begin
    PC_out <= PC_in;
    read_data1_out <= read_data1_in;
    read_data2_out <= read_data2_in;
    immediate_out <= immediate_in;
    funct3_out <= funct3_in;
    funct7_out <= funct7_in;
    rd_out <= rd_in;
    branch_out <= branch_in;
    MemRead_out <= MemRead_in;
    MemtoReg_out <= MemtoReg_in;
    MemWrite_out <= MemWrite_in;
    ALUSrc_out <= ALUSrc_in;
    RegWrite_out <= RegWrite_in;
    ALUOp_out <= ALUOp_in;
    IF_ID_rs1_out<=IF_ID_rs1_in;
    IF_ID_rs2_out<=IF_ID_rs2_in;
   end
    else begin
    PC_out <= 64'bx;
    read_data1_out <= 64'bx; 
    read_data2_out <= 64'bx;
    immediate_out <= 64'bx;
    funct3_out <= 3'bx;
    funct7_out <= 7'bx;
    rd_out <= 5'bx;
    branch_out <= 1'bx;
    MemRead_out <= 1'bx;
    MemtoReg_out <= 1'bx;
    MemWrite_out <= 1'bx;
    ALUSrc_out <= 1'bx;
    RegWrite_out <= 1'bx;
    ALUOp_out <= 2'bx;
    IF_ID_rs1_out <= 5'bx;
    IF_ID_rs2_out <= 5'bx;
    end
end
endmodule
`endif