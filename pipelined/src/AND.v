module AND_64(
    input [63:0] A,
    input [63:0] B,
    output [63:0] Y
);
    // generating the output via genvar
    genvar i;
    generate
        for(i=0; i<64; i=i+1) 
        begin: gen_and
            and and1(Y[i], A[i], B[i]);
        end
    endgenerate
endmodule
