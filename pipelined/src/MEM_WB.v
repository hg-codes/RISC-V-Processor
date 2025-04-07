`ifndef MEM_WB
`define MEM_WB
module MEM_WB(
    input clk,
    input MemtoReg_in,
    input RegWrite_in,
    input [63:0] data_from_memory_in,
    input [63:0] ALU_out_in,
    input [4:0] rd_in,

    output reg MemtoReg_out,
    output reg RegWrite_out,
    output reg [63:0] data_from_memory_out,
    output reg [63:0] ALU_out_out,
    output reg [4:0] rd_out
    );
 
    always@(posedge clk)
    begin
        MemtoReg_out <= MemtoReg_in;
        RegWrite_out <= RegWrite_in;
        data_from_memory_out<=data_from_memory_in;
        ALU_out_out <= ALU_out_in;
        rd_out <= rd_in;
    end


endmodule
`endif