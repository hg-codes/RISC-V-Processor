`ifndef EX_MEM
`define EX_MEM
module EX_MEM(
    input clk,
    input RegWrite_in,
    input MemtoReg_in,
    input MemWrite_in,
    input MemRead_in,
    input [63:0] ALU_out_in,
    input [4:0] rd_in,
    input [63:0] read_data2_in,

    output reg RegWrite_out,
    output reg MemtoReg_out,
    output reg MemWrite_out,
    output reg MemRead_out,
    output reg [63:0] ALU_out_out,
    output reg [4:0] rd_out,
    output reg [63:0] read_data2_out
);
    always@(posedge clk)
begin
RegWrite_out <= RegWrite_in;
MemtoReg_out <= MemtoReg_in;
MemWrite_out <= MemWrite_in;
MemRead_out <= MemRead_in;
ALU_out_out <= ALU_out_in;
rd_out <= rd_in;
read_data2_out<= read_data2_in;
end
endmodule
`endif