module full_adder(
    input wire A,
    input wire B,
    input wire Cin,
    output wire S,
    output wire Cout
);
    wire x,y,z;
    xor xor1(x,A,B);
    and and1(y,A,B);
    and and2(z,x,Cin);
    xor xor2(S,x,Cin);
    or or1(Cout,y,z);
endmodule