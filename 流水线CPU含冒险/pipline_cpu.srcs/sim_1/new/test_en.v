`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 15:17:55
// Design Name: 
// Module Name: test_en
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_en(

    );
    
reg clk_IFID; //寄存器时钟
reg rst_IFID; //寄存器复位
reg en_IFID;//寄存器使能
reg [31:0] PC_in_IFID; //PC输入
reg [31:0]inst_in_IFID; //指令输入
wire [31:0] PC_out_IFID; //PC输出
wire  [31:0] inst_out_IFID; //指令输出
my_IF_reg_ID new(
.clk_IFID(clk_IFID), //寄存器时钟
. rst_IFID(rst_IFID), //寄存器复位
. en_IFID(en_IFID), //寄存器使能
.  PC_in_IFID(PC_in_IFID), //PC输入
. inst_in_IFID(inst_in_IFID), //指令输入
.PC_out_IFID(PC_out_IFID), //PC输出
.inst_out_IFID(inst_out_IFID) //指令输出
); 
initial begin
    clk_IFID = 0;
    rst_IFID = 1;
    en_IFID = 1;
    PC_in_IFID = 32'h00000010;
    inst_in_IFID = 32'h00000011;
    #100;
    rst_IFID = 0;
    #100;
    en_IFID = 0;
    PC_in_IFID = 32'h10000010;
    inst_in_IFID = 32'h10000011;
    #100;
    rst_IFID = 1;
    #100;
    rst_IFID = 0;
    en_IFID = 1;
    #100;
    en_IFID = 0;
     PC_in_IFID = 32'h10010010;
     inst_in_IFID = 32'h10000000;
     #100;
      PC_in_IFID = 32'h10010011;
     inst_in_IFID = 32'h10000011;
end
always begin
 clk_IFID = clk_IFID+1;
 #20;
end
endmodule
