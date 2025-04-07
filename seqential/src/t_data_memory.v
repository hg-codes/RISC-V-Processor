module t_data_mem();
reg clk,mem_write,mem_read;
reg [63:0] address,write_data;
wire [63:0] read_data;

data_memory uut(
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(address),
    .write_data(write_data),
    .read_data(read_data)
);
initial begin
    clk=1'b1;
    forever #1 clk=~clk;
end


initial begin 
    $dumpfile("t_data_mem.vcd");
    $dumpvars(0,t_data_mem);

//Test 1
// address=64'd1;
// mem_write=1;
// write_data=64'd50;

// #2 
// mem_write=0;
// mem_read=1;
// address=64'd1;


// Test 2
// mem_read=0;
// address=64'd1;
// mem_write=1;
// write_data=64'd100;

// #2
// address=64'd1;
// mem_write=1;
// write_data=64'd200;


// #2
// mem_read=1;
// address=64'd1;


//Test 3

// mem_read=0;
// mem_write=0;
// address=64'd5;
// write_data=64'd99;

// #2
// mem_read=1;
// address=64'd5;



#1 $finish;

end


initial begin
    $monitor("Time: %0t | clk: %d | address: %d | mem_read: %d | mem_write: %d | write_data: %d|read_data: %d", 
             $time, clk, address, mem_read, mem_write, write_data, read_data);
end

endmodule