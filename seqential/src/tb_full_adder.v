`timescale 1ns/1ps

module full_adder_tb;

reg A;
reg B;
reg Cin;

wire S;
wire Cout;

full_adder UUT (
    .A(A),
    .B(B),
    .Cin(Cin),
    .S(S),
    .Cout(Cout)
);

initial $monitor("A=%b, B=%b, Cin=%b, S=%b, Cout=%b", A, B, Cin, S, Cout);

initial
begin
    $dumpfile("full_adder_tb.vcd");
    $dumpvars(0, full_adder_tb);

    // Test Case 1: A = 0, B = 0, Cin = 0
    A = 0; B = 0; Cin = 0;
    #10;

    // Test Case 2: A = 0, B = 0, Cin = 1
    A = 0; B = 0; Cin = 1;
    #10;

    // Test Case 3: A = 0, B = 1, Cin = 0
    A = 0; B = 1; Cin = 0;
    #10;

    // Test Case 4: A = 0, B = 1, Cin = 1
    A = 0; B = 1; Cin = 1;
    #10;

    // Test Case 5: A = 1, B = 0, Cin = 0
    A = 1; B = 0; Cin = 0;
    #10;

    // Test Case 6: A = 1, B = 0, Cin = 1
    A = 1; B = 0; Cin = 1;
    #10;

    // Test Case 7: A = 1, B = 1, Cin = 0
    A = 1; B = 1; Cin = 0;
    #10;

    // Test Case 8: A = 1, B = 1, Cin = 1
    A = 1; B = 1; Cin = 1;
    #10;

    $finish;
end

endmodule