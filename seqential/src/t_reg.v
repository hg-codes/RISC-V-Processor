module t_reg();

reg [4:0] rs1, rs2, rd;
reg clk,write_enable;
reg [63:0] write_data;
wire [63:0] read_data1, read_data2;

register_file uut(
    .clk(clk),
    .rs1(rs1),
    .rs2(rs2),
    .write_enable(write_enable),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2),
    .rd(rd)
);

initial begin
    clk = 1'b1;
    forever #1 clk = ~clk;
end

initial begin
    $dumpfile("t_reg.vcd");
    $dumpvars(0,t_reg);
/*--------------------------------------------------Test1-------------------------------------------
    rd=5'd5;
    write_enable=1;
    write_data=64'd50;

    #2 
   rd=5'd6;
    write_enable=1;
    write_data=64'd200;

    #2

    rs1=5'd5;
    rs2=5'd6;
    write_enable=0;
  ----------------------------------------------------------------------------------------------------------------*/  

  /*--------------------------------------------------Test2--------------------------------------------------
    rd=5'd0;
    write_enable=1;
    write_data=64'd50;

    

    #2

    rs1=5'd0;
    rs2=5'd1;
    write_enable=0;
  ----------------------------------------------------------------------------------------------------------------  */
/*----------------------------------TEST3---------------------------------------------------------------
  rd=5'd3;
    write_enable=1;
    write_data=64'd50;

    #2 
   rd=5'd3;
    write_enable=1;
    write_data=64'd300;

    #2

    rs1=5'd3;
    rs2=5'd4;
    write_enable=0;
----------------------------------------------------------------------------------------------------------*/

//TEST 4
// rd=5'd3;
//     write_enable=1;
//     write_data=64'd20;

//     #2 
//    rd=5'd3;
//     write_enable=1;
//     write_data=64'd30;

//    #2 
//    rd=5'd3;
//     write_enable=1;
//     write_data=64'd20;

//     #2

//     rs1=5'd3;
//     rs2=5'd3;
//     write_enable=0;


//TEST 5

// rd=5'd1;
//     write_enable=0;
//     write_data=64'd20;

    

//     #2

//     rs1=5'd1;
//     rs2=5'd1;
//     write_enable=0;


//TEST 6

// rd=5'd1;
//     write_enable=0;
//     write_data=64'd20;

//     #2
//     rd=5'd2;
//     write_enable=1;
//     write_data=64'd30;


//     #2

//     rs1=5'd1;
//     rs2=5'd2;
//     write_enable=0;


//TEST 7
rd=5'd0;
    write_enable=0;
    write_data=64'd20;

    #2
    rd=5'd0;
    write_enable=1;
    write_data=64'd30;


    #2

    rs1=5'd0;
    rs2=5'd0;
    write_enable=0;
 #6 $finish;
end

initial begin
    $monitor("Time: %0t | clk: %d | rs1: %d | rs2: %d | write_enable: %d | rd: %d | writedata: %d | read_data1: %d | read_data2: %d", 
             $time, clk, rs1, rs2, write_enable, rd, write_data, read_data1, read_data2);
end


endmodule


