module data_memory(
    input clk,
    input mem_write,
    input mem_read,
    input [63:0] address,
    input [63:0] write_data,
    output [63:0] read_data
);

reg [63:0] mem [255:0];

assign read_data= (mem_read==1'b1) ? mem[address] : 64'd0;

always@(posedge clk)
begin
    if(mem_write)
    mem[address] <= write_data;
end

initial begin
    #10000;  
    $writememh("memory_dump.hex", mem);  
end

initial begin 
    $readmemb("initial_data.txt",mem);
end

endmodule