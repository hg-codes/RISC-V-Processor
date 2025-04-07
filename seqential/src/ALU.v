`ifndef ADD_V
`define ADD_V
`include "ADD.v"
`endif

`ifndef SUB_V
`define SUB_V
`include "SUB.v"
`endif

`ifndef AND_V
`define AND_V
`include "AND.v"
`endif

`ifndef OR_V
`define OR_V
`include "OR.v"
`endif

`ifndef NOT_V
`define NOT_V
`include "NOT.v"
`endif

`ifndef FULL_ADDER_V
`define FULL_ADDER_V
`include "full_adder.v"
`endif

`ifndef NEG_V
`define NEG_V
`include "NEG.v"
`endif

`ifndef SLT_v
`define SLT_v
`include "SLT.v"
`endif

module ALU_64(
    input [63:0] A,
    input [63:0] B,
    input [3:0] ALU_control,
    output [63:0] out,
    output zero
);
    wire [63:0] add_out, sub_out, and_out, or_out,slt_out, z1;
    wire Overflow, Cout;
    wire zero;
    reg [63:0] temp;
    reg z2;

    ADD_64 add1(A, B, 1'b0, add_out, Cout, Overflow);
    SUB_64 sub1(A, B, sub_out, Overflow);
    SUB_64 sub2(A, B, z1, Overflow);
    AND_64 and1(A, B, and_out);
    OR_64 or1(A, B, or_out);
    SLT_64 slt(A,B,slt_out);

    // zero flag implementation
//    always @(*)
//    begin
//         case(z1)
//             64'd0: z2 = 1'b1;
//             default: z2 = 1'b0;
//         endcase
        
//    end

  always @(*)
  begin 
    case(ALU_control)
       4'b0110: z2=(z1==0)? 1'b1:1'b0;        
       4'b0111: z2=(slt_out[0]==1) ? 1'b1:1'b0;
       default: z2= 1'b0;
       endcase
  end


   assign zero = z2;




    // ALU output implementation
   always @(*)
   begin
        case(ALU_control)
            4'b0010: temp = add_out;
            4'b0110: temp = sub_out;
            4'b0000: temp = and_out;
            4'b0001: temp = or_out;
            4'b0111: temp=  slt_out;
            default: temp = 64'b0;
        endcase
   end
    assign out = temp;

endmodule