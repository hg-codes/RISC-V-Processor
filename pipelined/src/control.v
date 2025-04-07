`ifndef control
`define control
module control(input [6:0]instruction,
                output reg branch ,
                output reg MemRead ,
                output reg MemtoReg,
                output reg MemWrite,
                output reg ALUSrc,
                output reg RegWrite,
                output reg [1:0] ALUOp);

    //add ,sub,or,and 000001 -> 10
    //ld 011011 -> 00
    //sd 000111 -> 00
    //beq 100010 ->01
    always @(*) begin
        branch=0;
        MemRead=0;
        MemtoReg = 0;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 0;
        ALUOp = 2'b11;
        case(instruction)
            7'b0110011:begin //add,sub.or,and
                RegWrite=1;
                ALUOp=2'b10;
            end
            7'b0000011:begin  //ld
                MemRead=1;
                MemtoReg=1;
                ALUSrc=1;
                RegWrite=1;
                ALUOp=2'b00;
            end
            7'b0100011:begin //sd
                MemWrite=1;
                ALUSrc=1;
                ALUOp=2'b00;
            end
            7'b1100011:begin  //beq or blt
                branch=1;
                ALUOp=2'b01;
            end
        default:ALUOp=2'bx;
        endcase
    end


endmodule
`endif 