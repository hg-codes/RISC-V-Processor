`ifndef alu_control
`define alu_control
module alu_control(input[6:0]funct7,input[2:0]funct3,input [1:0]alu_op,output reg [3:0]alu_ctl);

    always @(*) begin
        case(alu_op)
        2'b00:begin
            alu_ctl=4'b0010;
        end
        2'b01:begin
            case(funct3)
            3'b000: alu_ctl=4'b0110;
            3'b100: alu_ctl=4'b0111;
            default: alu_ctl=4'b0000;
        endcase
        end
        2'b10:begin
            case(funct7)
            7'b0000000:begin
                case(funct3)
                3'b000:begin
                    alu_ctl=4'b0010; 
                end
                3'b110:begin
                    alu_ctl=4'b0001;

                end
                3'b111:begin
                    alu_ctl=4'b0000;
                end
                default:begin
                      alu_ctl = 4'bxxxx; // Default value for undefined 
                end
                endcase
            end
            7'b0100000: begin
                alu_ctl=4'b0110;
            end
            default: begin
                  alu_ctl = 4'bxxxx; // Default value for undefined 
            end

            endcase
        end
        default: begin
              alu_ctl = 4'bxxxx; // Default value for undefined funct3
        end
    endcase
    end
endmodule
`endif 