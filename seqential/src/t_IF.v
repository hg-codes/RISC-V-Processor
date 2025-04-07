module t_IF();
reg clk, mux_control;
reg [63:0] immediate;
wire [31:0] instruction;
wire [63:0] address;
IF uut(
    .clk(clk),
    .mux_control(mux_control),
    .instruction(instruction),
    .immediate(immediate),
    .address(address)
);

initial begin
    clk = 1'b0;
    forever #2 clk = ~clk;
end

initial begin
    $dumpfile("t_IF.vcd");
    $dumpvars(0,t_IF);
    mux_control=0;
    immediate=64'd0;
    #10 immediate=64'd6; mux_control=1;
    #50 $finish;
end

initial begin
    $monitor("Time: %0t |clk:%d |address:%d |instruction:%h",$time,clk,address,instruction);
end

endmodule
