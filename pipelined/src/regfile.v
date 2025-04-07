module register_file (
    input wire clk,
    input wire write_enable,
    input wire [4:0] rs1, rs2, rd,
    input wire [63:0] write_data,
    output wire [63:0] read_data1, read_data2
);

    reg [63:0] registers [31:0]; // 32 registers of 64-bit each

    // Asynchronous Read
    assign read_data1 = (rs1 != 0) ? registers[rs1] : 32'b0;
    assign read_data2 = (rs2 != 0) ? registers[rs2] : 32'b0;

    // Synchronous Write
    always @(*) begin
        if (write_enable && rd != 0)
            registers[rd] <= write_data;
    end

 initial begin  
    $readmemb("initial_registers.txt",registers);
    /*
    ideally we intialised like this without python script
    registers[1]=64'd5;
    registers[2]=64'd0;
    registers[6]=64'd1;
    registers[7]=64'd2;
    */

 end

initial begin
    #10000;  
     $display("Writing memory to file");
    $writememh("reg_dump.hex", registers);
        $display("Memory write completed.");  
end

endmodule
