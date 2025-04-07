module HazardDetectionUnit(
    input [4:0] ID_EX_RegisterRd,
    input [4:0] IF_ID_RegisterRs1,
    input [4:0] IF_ID_RegisterRs2,
    input ID_EX_MEMRead,
    output reg PCWrite,
    output  reg IF_ID_Write,
    output  reg ID_EX_MuxSelect
);  

initial begin
         PCWrite <= 1'b1;
        IF_ID_Write <= 1'b1;
        ID_EX_MuxSelect <= 1'b0;
end
 


    always @(*) begin
        // Default values (No Stall)
        PCWrite <= 1'b1;
        IF_ID_Write <= 1'b1;
        ID_EX_MuxSelect <= 1'b0;

        // Stall condition: Load-use hazard
        if (ID_EX_MEMRead && ((IF_ID_RegisterRs1 == ID_EX_RegisterRd) || (IF_ID_RegisterRs2 == ID_EX_RegisterRd))) begin
            PCWrite <= 1'b0;      // Stop PC update
            IF_ID_Write <= 1'b0;  // Stop IF/ID pipeline register update
            ID_EX_MuxSelect <= 1'b1; // Stall the EX stage
        end
    end
endmodule
