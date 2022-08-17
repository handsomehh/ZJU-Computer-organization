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
    
reg clk_IFID; //�Ĵ���ʱ��
reg rst_IFID; //�Ĵ�����λ
reg en_IFID;//�Ĵ���ʹ��
reg [31:0] PC_in_IFID; //PC����
reg [31:0]inst_in_IFID; //ָ������
wire [31:0] PC_out_IFID; //PC���
wire  [31:0] inst_out_IFID; //ָ�����
my_IF_reg_ID new(
.clk_IFID(clk_IFID), //�Ĵ���ʱ��
. rst_IFID(rst_IFID), //�Ĵ�����λ
. en_IFID(en_IFID), //�Ĵ���ʹ��
.  PC_in_IFID(PC_in_IFID), //PC����
. inst_in_IFID(inst_in_IFID), //ָ������
.PC_out_IFID(PC_out_IFID), //PC���
.inst_out_IFID(inst_out_IFID) //ָ�����
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
