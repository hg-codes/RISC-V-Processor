`ifndef IF_ID
`define IF_ID
module IF_ID(input wire clk,
                        input wire IF_ID_Flush,
                        input wire [63:0] address_in,
                        input wire [31:0] instruction_in,
                        input wire IF_ID_Write,
                        output reg [63:0] address_out,
                        output reg [31:0] instruction_out);
    always@(posedge clk)
begin
    if(IF_ID_Flush==0)begin
        if(IF_ID_Write==1)begin
        address_out<=address_in;
        instruction_out<=instruction_in;
        end
    end
    else begin
        address_out<=64'bx;
        instruction_out<=64'bx;
    end
   //if beq==1 ,flush everything
   //else
end

endmodule
`endif
