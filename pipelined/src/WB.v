`ifndef WB 
`define WB
module WB(
        input [63:0] read_data,
        input [63:0] ALU_out,
        input MemtoReg,
        output [63:0] write_data);
        assign write_data=(MemtoReg==0) ? ALU_out : read_data;
endmodule
`endif