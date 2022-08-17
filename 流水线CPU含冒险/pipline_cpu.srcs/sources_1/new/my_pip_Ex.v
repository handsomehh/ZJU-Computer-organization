`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 14:44:26
// Design Name: 
// Module Name: my_pip_Ex
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


module my_pip_Ex(
input[31:0] PC_in_EX,//PC����
input[31:0] Rs1_in_EX,//������1����
input[31:0] Rs2_in_EX,//������2����
input[31:0] Imm_in_EX,//����������
input ALUSrc_B_in_EX,//ALU Bѡ��
input[3:0] ALU_control_in_EX,//ALUѡ�����
output  [31:0] PC_out_EX,//PC���
output  [31:0] PC4_out_EX,//PC+4���
output  zero_out_EX,//ALU��0���
output  [31:0] ALU_out_EX,//ALU�������
output  [31:0] Rs2_out_EX//������2���
);
wire [31:0]o;
ALU my_alu(
    .A(Rs1_in_EX),
    .B(o),
    .ALU_operation(ALU_control_in_EX),
    .res(ALU_out_EX),
    .zero(zero_out_EX)
);
assign PC_out_EX = PC_in_EX+Imm_in_EX;
assign PC4_out_EX=PC_in_EX+3'b100;
assign o = ALUSrc_B_in_EX?Imm_in_EX:Rs2_in_EX;
assign Rs2_out_EX = Rs2_in_EX;
endmodule
