`timescale 1ns/1ps

module ALU_tb;
    
    reg [63:0] A, B;
    reg [3:0] ALU_control;
    wire [63:0] out;
    wire zero;

    ALU_64 ALU(
        .A(A),
        .B(B),
        .ALU_control(ALU_control),
        .out(out),
        .zero(zero)
    );

    initial
    begin
        $monitor("ALU_control=\t%d\nA\t=%d\nB\t=%d\nout\t=%d\nzero\t=%d\n", ALU_control,A, B, out,zero);
    end

    initial 
    begin
        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, ALU_tb);
        // normal case
        // A = 64'b0000000000000000000000000000000000000000000000000000000000000011;
        // B = 64'b0000000000000000000000000000000000000000000000000000000000000101;
        // ALU_control = 4'b0000;  // ADD
        // #10;
        // ALU_control = 4'b0001;  // SUB
        // #10;
        // ALU_control = 4'b0010;  // AND
        // #10;
        // ALU_control = 4'b0011;  // OR
        // #10;
       

        // A = 64'b0000000000000000000000000000000000000000000000000000000000000000;
        // B = 64'b0000000000000000000000000000000000000000000000000000000000000000;
        // ALU_control = 4'b0000;  // ADD
        // #10;
        // ALU_control = 4'b0001;  // SUB
        // #10;
        // ALU_control = 4'b0010;  // AND
        // #10;
        // ALU_control = 4'b0011;  // OR
        // #10;

        // // all 1
        // A = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        // B = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        // ALU_control = 4'b0000;  // ADD
        // #10;
        // ALU_control = 4'b0001;  // SUB
        // #10;
        // ALU_control = 4'b0010;  // AND
        // #10;
        // ALU_control = 4'b0011;  // OR
        // #10;

        // A = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        // B = 64'b0000000000000000000000000000000000000000000000000000000000000000;
        // ALU_control = 4'b0000;  // ADD
        // #10;
        // ALU_control = 4'b0001;  // SUB
        // #10;
        // ALU_control = 4'b0010;  // AND
        // #10;
        // ALU_control = 4'b0011;  // OR
        // #10;

        // A = 64'b0000000000000000000000000000000000000000000000000000000000000000;
        // B = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        // ALU_control = 4'b0000;  // ADD
        // #10;
        // ALU_control = 4'b0001;  // SUB
        // #10;
        // ALU_control = 4'b0010;  // AND
        // #10;
        // ALU_control = 4'b0011;  // OR
        // #10;

        // // edge case 
        // A = 64'h7FFFFFFFFFFFFFFF;
        // B = 64'h1;
        // ALU_control = 4'b0000;  // ADD
        // #10;
        // ALU_control = 4'b0001;  // SUB
        // #10;
        // ALU_control = 4'b0010;  // AND
        // #10;
        // ALU_control = 4'b0011;  // OR
        // #10;


        // A = 64'h8000000000000000;
        // B = 64'h1;
        // ALU_control = 4'b0000;  // ADD
        // #10;
        // ALU_control = 4'b0001;  // SUB
        // #10;
        // ALU_control = 4'b0010;  // AND
        // #10;
        // ALU_control = 4'b0011;  // OR
        // #10;

        // A = 64'hFFFFFFFFFFFFFFF6;
        // B = 64'h0000000000000005;
        // ALU_control = 4'b0000;  // ADD
        // #10;
        // ALU_control = 4'b0001;  // SUB
        // #10;
        // ALU_control = 4'b0010;  // AND
        // #10;
        // ALU_control = 4'b0011;  // OR
        // #10;
    
        // A = 64'hFFFFFFFFFFFFFFFF;
        // B = 64'h1;    
        // ALU_control = 4'b0000;  // ADD
        // #10;
        // ALU_control = 4'b0001;  // SUB
        // #10;
        // ALU_control = 4'b0010;  // AND
        // #10;
        // ALU_control = 4'b0011;  // OR
        // #10;
        
        
        A = 64'h10; 
        B = 64'h12;
        ALU_control = 4'b0010;  // ADD
        #10;
        ALU_control = 4'b0110;  // SUB
        #10;
        ALU_control = 4'b0000;  // AND
        #10;
        ALU_control = 4'b0001;  // OR
        #10;
        ALU_control = 4'b0111;  //slt
        #10
            
        // ALU_control = 4'b1111;  // not defined operation
        $finish;
    end

endmodule