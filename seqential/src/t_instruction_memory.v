module t_instruction_memory();
reg [31:0] a;
wire [31:0] b;
instruction_memory uut(
.read_address(a),
.instruction(b)
);

initial begin 
    $dumpfile("t_instruction_memory.vcd");
    $dumpvars(0,t_instruction_memory);
    a=32'd0;
    //at every 10s do a=a+1
    repeat(15)
    begin 
        #10 a=a+4;
    end

    #10 $finish;
    
end

initial begin
    $monitor("Time: %0t |address:%d | instruction:%h",$time,a,b);
end

endmodule