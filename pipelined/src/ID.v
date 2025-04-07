`ifndef ID 
`define ID
`include "control.v"
`include "regfile.v"
`include "imm_gen.v"
module ID(
    input clk,
    input [31:0] instruction,
    input write_enable,
    input [63:0] write_data,
    input ID_EX_MuxSelect,
    input [4:0] rd3,
    output reg branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg [1:0] ALUOp,
    output [4:0] IF_ID_rs1,
    output [4:0] IF_ID_rs2,
    output [63:0] read_data1,
    output [63:0] read_data2,
    output [63:0] immediate,
    output [4:0] rd,
    output [2:0] funct3,
    output [6:0] funct7
    );
    wire intermediate_branch;
    wire intermediate_MemRead;
    wire intermediate_MemtoReg;
    wire intermediate_MemWrite;
    wire intermediate_ALUSrc;
    wire intermediate_RegWrite;
    wire [1:0]intermediate_ALUOp;





    control u1(
        .instruction(instruction[6:0]),
        .branch(intermediate_branch),
        .MemRead(intermediate_MemRead),
        .MemtoReg(intermediate_MemtoReg),
        .MemWrite(intermediate_MemWrite),
        .ALUSrc(intermediate_ALUSrc),
        .RegWrite(intermediate_RegWrite),
        .ALUOp(intermediate_ALUOp)
    );
    register_file u2(
        .clk(clk),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(rd3),
        .write_data(write_data),
        .write_enable(write_enable),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    immediate_generate u3(
        .instruction(instruction),
        .immediate(immediate)
    );
    assign funct7 = instruction[31:25];
    assign funct3 = instruction[14:12];
    assign IF_ID_rs1=instruction[19:15];
    assign IF_ID_rs2=instruction[24:20];
    assign rd=instruction[11:7];
    
    always @(*) begin
        if (ID_EX_MuxSelect == 1'b1) begin
            branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
            ALUOp = 2'b00;
        end else begin
            branch = intermediate_branch;
            MemRead = intermediate_MemRead;
            MemtoReg = intermediate_MemtoReg;
            MemWrite = intermediate_MemWrite;
            ALUSrc = intermediate_ALUSrc;
            RegWrite = intermediate_RegWrite;
            ALUOp = intermediate_ALUOp;
        end
    end



endmodule





//delete comments after confirmation

// module control(input [6:0]instruction,
//                 output reg branch ,
//                 output reg MemRead ,
//                 output reg MemtoReg,
//                 output reg MemWrite,
//                 output reg ALUSrc,
//                 output reg RegWrite,
//                 output reg [1:0] ALUOp);

//     //add ,sub,or,and 000001 -> 10
//     //ld 011011 -> 00
//     //sd 000111 -> 00
//     //beq 100010 ->01
//     always @(*) begin
//         branch=0;
//         MemRead=0;
//         MemtoReg = 0;
//         MemWrite = 0;
//         ALUSrc = 0;
//         RegWrite = 0;
//         ALUOp = 2'b11;
//         case(instruction)
//             7'b0110011:begin //add,sub.or,and
//                 RegWrite=1;
//                 ALUOp=2'b10;
//             end
//             7'b0000011:begin  //ld
//                 MemRead=1;
//                 MemtoReg=1;
//                 ALUSrc=1;
//                 RegWrite=1;
//                 ALUOp=2'b00;
//             end
//             7'b0100011:begin //sd
//                 MemWrite=1;
//                 ALUSrc=1;
//                 ALUOp=2'b00;
//             end
//             7'b1100011:begin  //beq
//                 branch=1;
//                 ALUOp=2'b01;
//             end
//         default:ALUOp=2'bx;
//         endcase
//     end
// endmodule

// module register_file (
//     input wire clk,
//     input wire write_enable,
//     input wire [4:0] rs1, rs2, rd,
//     input wire [63:0] write_data,
//     output wire [63:0] read_data1, read_data2
// );

//     reg [63:0] registers [31:0]; // 32 registers of 64-bit each

//     // Asynchronous Read
//     assign read_data1 = (rs1 != 0) ? registers[rs1] : 32'b0;
//     assign read_data2 = (rs2 != 0) ? registers[rs2] : 32'b0;

//     // Synchronous Write
//     always @(posedge clk) begin
//         if (write_enable && rd != 0)
//             registers[rd] <= write_data;
//     end

//  initial begin
//     registers[22]=64'd1;
//     registers[24]=64'd15;
//     registers[23]=64'd0;
//     registers[5]=64'd15;
//  end

// initial begin
//     #10000;  
//     $writememh("reg_dump.hex", registers);  
// end

// endmodule


// module immediate_generate(input wire[31:0]instruction,output reg[63:0] immediate);  

//     reg [11:0] imm;
//     always @(*) begin
//         case(instruction[6:0])
//             7'b0000011:begin  //ld
//                 imm = instruction[31:20];
//                 immediate = {{52{imm[11]}}, imm}; 
//             end
//             7'b0100011:begin //sd
//                 imm[11:5] = instruction[31:25];
//                 imm[4:0] = instruction[11:7];
//                 immediate = {{52{imm[11]}}, imm}; 
//             end
//             7'b1100011:begin  //beq
//                 imm[11] = instruction[31];
//                 imm[10] = instruction[7];
//                 imm[9:4] = instruction[30:25];
//                 imm[3:0] = instruction[11:8];
//                 immediate = {{52{imm[11]}}, imm}; 
//             end
//             default:begin
//                 immediate=64'bx;
//             end
//         endcase
        
//     end

// endmodule

`endif