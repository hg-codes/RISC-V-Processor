module t_program_counter();

reg clk,mux_control;
reg [63:0] immediate;
wire [63:0] instruction_address;
wire [31:0] instruction;
program_counter uut(
    .clk(clk),
    .mux_control(mux_control),
    .immediate(immediate),
    .instruction_address(instruction_address)
);


instruction_memory mem1(
.read_address(instruction_address[31:0]),
.instruction(instruction)
);

initial begin
    clk = 1'b0;
    forever #2 clk = ~clk;
end

initial begin
    $dumpfile("t_program_counter.vcd");
    $dumpvars(0,t_program_counter);
    mux_control=0;
    immediate=64'd0;
    #50 $finish;
    
end

initial begin
    $monitor("Time: %0t |clk:%d | instruction_address:%d | instruction:%h",$time,clk,instruction_address,instruction);
end

endmodule