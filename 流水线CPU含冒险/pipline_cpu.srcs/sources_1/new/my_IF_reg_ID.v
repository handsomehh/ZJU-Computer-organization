`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/17 19:21:41
// Design Name: 
// Module Name: my_IF_reg_ID
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


module my_IF_reg_ID(
input clk_IFID, //�Ĵ���ʱ��
input rst_IFID, //�Ĵ�����λ
input en_IFID, //�Ĵ���ʹ��
input [31:0] PC_in_IFID, //PC����
input [31:0]inst_in_IFID, //ָ������
input NOP_IFID,
output reg [31:0] PC_out_IFID, //PC���
output reg [31:0] inst_out_IFID //ָ�����
); 
always @(negedge clk_IFID or posedge rst_IFID)
if (rst_IFID==1)begin
    PC_out_IFID = 0;
    inst_out_IFID = 32'h00000000;
end
else if (NOP_IFID) begin
    PC_out_IFID = 32'h00000000;
    inst_out_IFID = 32'h00000013;
end
else if (en_IFID == 1)begin 
    PC_out_IFID = PC_in_IFID;
    inst_out_IFID = inst_in_IFID;
end
endmodule
