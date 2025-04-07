module instruction_memory(
    input [31:0] read_address,
    output [31:0] instruction
);
    reg [31:0] word_mem [1023:0];
    /*
       Using a temporay word_mem in order to read data effectively from file ,
       otherwise need to change data syntax in input file
    */
    reg [7:0] mem [2047:0];
    
    integer i;
    
    initial begin
        $readmemb("instructions.txt", word_mem);
        for (i = 0; i < 1024; i = i + 1) begin
            mem[i*4]   = word_mem[i][7:0];    
            mem[i*4+1] = word_mem[i][15:8];   
            mem[i*4+2] = word_mem[i][23:16];  
            mem[i*4+3] = word_mem[i][31:24];  
        end
    end
     assign instruction = {mem[read_address+3], mem[read_address+2],mem[read_address+1], mem[read_address]};
endmodule