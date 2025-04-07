`timescale 1ns/1ps

module HazardDetectionUnit_tb;
    // Testbench signals
    reg [4:0] ID_EX_RegisterRd;
    reg [4:0] IF_ID_RegisterRs1;
    reg [4:0] IF_ID_RegisterRs2;
    reg ID_EX_MEMRead;
    wire PCWrite;
    wire IF_ID_Write;
    wire ID_EX_MuxSelect;

    // Instantiate the HazardDetectionUnit module
    HazardDetectionUnit uut (
        .ID_EX_RegisterRd(ID_EX_RegisterRd),
        .IF_ID_RegisterRs1(IF_ID_RegisterRs1),
        .IF_ID_RegisterRs2(IF_ID_RegisterRs2),
        .ID_EX_MEMRead(ID_EX_MEMRead),
        .PCWrite(PCWrite),
        .IF_ID_Write(IF_ID_Write),
        .ID_EX_MuxSelect(ID_EX_MuxSelect)
    );

    initial begin
        $dumpfile("HazardDetectionUnit_tb.vcd"); // For waveform visualization
        $dumpvars(0, HazardDetectionUnit_tb);

        // Initialize Inputs
        ID_EX_RegisterRd = 5'b00000;
        IF_ID_RegisterRs1 = 5'b00000;
        IF_ID_RegisterRs2 = 5'b00000;
        ID_EX_MEMRead = 1'b0;
        #10;

        // Test Case 1: No hazard
        ID_EX_RegisterRd = 5'b00010;
        IF_ID_RegisterRs1 = 5'b00011;
        IF_ID_RegisterRs2 = 5'b00100;
        ID_EX_MEMRead = 1'b0;
        #10;
        
        // Test Case 2: Hazard on Rs1
        ID_EX_RegisterRd = 5'b00010;
        IF_ID_RegisterRs1 = 5'b00010;
        IF_ID_RegisterRs2 = 5'b00100;
        ID_EX_MEMRead = 1'b1;
        #10;
        
        // Test Case 3: Hazard on Rs2
        ID_EX_RegisterRd = 5'b00011;
        IF_ID_RegisterRs1 = 5'b00101;
        IF_ID_RegisterRs2 = 5'b00011;
        ID_EX_MEMRead = 1'b1;
        #10;
        
        // Test Case 4: No hazard (Different Registers)
        ID_EX_RegisterRd = 5'b01000;
        IF_ID_RegisterRs1 = 5'b01100;
        IF_ID_RegisterRs2 = 5'b01101;
        ID_EX_MEMRead = 1'b1;
        #10;

        // Test Case 5: No hazard, MEMRead=0
        ID_EX_RegisterRd = 5'b00001;
        IF_ID_RegisterRs1 = 5'b00001;
        IF_ID_RegisterRs2 = 5'b00010;
        ID_EX_MEMRead = 1'b0;
        #10;

        $finish; // End simulation
    end

    initial 
    begin
        $monitor("Time=%0t | ID_EX_RegisterRd=%d, IF_ID_RegisterRs1=%d, IF_ID_RegisterRs2=%d, ID_EX_MEMRead=%b, PCWrite=%b, IF_ID_Write=%b, ID_EX_MuxSelect=%b", 
                 $time, ID_EX_RegisterRd, IF_ID_RegisterRs1, IF_ID_RegisterRs2, ID_EX_MEMRead, PCWrite, IF_ID_Write, ID_EX_MuxSelect);
    end
endmodule
