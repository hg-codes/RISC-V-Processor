`timescale 1ns/1ps

module MUX2_tb;

// Inputs
reg a;
reg b;
reg sel;

// Outputs
wire y;

MUX2 UUT (
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
);

initial $monitor("a=%d, b=%d, sel=%d, y=%d", a, b, sel, y);

initial
begin
    $dumpfile("MUX2_tb.vcd");
    $dumpvars(0, MUX2_tb);

    // Test Case 1: sel = 0, Expecting y = a
    a = 0; b = 1; sel = 0;
    #10;

    // Test Case 2: sel = 1, Expecting y = b
    a = 0; b = 1; sel = 1;
    #10;

    // Test Case 3: sel = 0, Expecting y = a
    a = 1; b = 0; sel = 0;
    #10;

    // Test Case 4: sel = 1, Expecting y = b
    a = 1; b = 0; sel = 1;
    #10;

    // Test Case 5: sel = 0, Expecting y = a
    a = 1; b = 1; sel = 0;
    #10;

    // Test Case 6: sel = 1, Expecting y = b
    a = 1; b = 1; sel = 1;
    #10;

    $finish;
end

endmodule