module NOT_64(
    input [63:0] A,
    output [63:0] Y
);
    genvar i;
    generate
        for(i=0; i<64; i=i+1) 
        begin: gen_not
            not not1(Y[i], A[i]);
        end
    endgenerate
endmodule
