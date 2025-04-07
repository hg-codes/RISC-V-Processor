module immediate_generate(input wire[31:0]instruction,output reg[63:0] immediate);  

    reg [11:0] imm;
    always @(*) begin
        case(instruction[6:0])
            7'b0000011:begin  //ld
                imm = instruction[31:20];
                immediate = {{52{imm[11]}}, imm}; 
            end
            7'b0100011:begin //sd
                imm[11:5] = instruction[31:25];
                imm[4:0] = instruction[11:7];
                immediate = {{52{imm[11]}}, imm}; 
            end
            7'b1100011:begin  //beq
                imm[11] = instruction[31];
                imm[10] = instruction[7];
                imm[9:4] = instruction[30:25];
                imm[3:0] = instruction[11:8];
                immediate = {{52{imm[11]}}, imm}; 
                // 00000000000000000000010101100011
            end
            default:begin
                immediate=64'bx;
            end
        endcase
        
    end

endmodule