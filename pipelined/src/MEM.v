`ifndef MEM 
`define MEM
`include "data_memory.v"
module MEM(
    input clk,
    input [63:0] memory_address,
    input [63:0] write_data,
    input MemWrite,
    input MemRead,
    output [63:0] read_data
    );

    
    
    data_memory u1(
        .clk(clk),
        .mem_write(MemWrite),
        .mem_read(MemRead),
        .address(memory_address),
        .write_data(write_data),
        .read_data(read_data)
    );


endmodule
// module and_for_branch(input wire branch, input wire zero,output PCSrc);
// assign PCSrc = branch & zero;
// endmodule

// module data_memory(
//     input clk,
//     input mem_write,
//     input mem_read,
//     input [63:0] address,
//     input [63:0] write_data,
//     output [63:0] read_data
// );

// reg [63:0] mem [255:0];

// assign read_data= (mem_read==1'b1) ? mem[address] : 64'd0;

// always@(posedge clk)
// begin
//     if(mem_write)
//     mem[address] <= write_data;
// end

// initial begin
//     #10000;  
//     $writememh("memory_dump.hex", mem);  
// end

// initial begin 
//     $readmemb("initial_data.txt",mem);
// end

// endmodule
`endif