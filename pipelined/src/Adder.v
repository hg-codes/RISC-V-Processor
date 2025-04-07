`ifndef ADDER
`define ADDER

module fullAdder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

wire w1,w2,w3;
 xor(sum,a,b,cin);
 and(w1,a,b);
 and(w2,b,cin);
 and(w3,a,cin);
 or(cout,w1,w2,w3);

endmodule



module Adder(
    input [63:0] a,
    input [63:0] b,
    input cin,
    output[63:0] sum

);

genvar i;
wire ctemp[64:0];
assign ctemp[0]=cin;
generate
    for(i=0;i<64;i=i+1)
    begin
      fullAdder f1(.a(a[i]),.b(b[i]),.cin(ctemp[i]),.sum(sum[i]),.cout(ctemp[i+1]));
    end
endgenerate

endmodule


module Subtractor(
    input [63:0]a,
    input [63:0]b,
    output [63:0]out
);

wire [63:0] bin;
//invert each bit of the 2nd number by xoring with 1
assign bin = b ^ {64{1'b1}};

Adder subtractuut(
    .a(a),
    .b(bin),
    .cin(1'b1),    //give cin as 1 for the adder, so that x'=~x+1;
    .sum(out)
);


endmodule

`endif 
