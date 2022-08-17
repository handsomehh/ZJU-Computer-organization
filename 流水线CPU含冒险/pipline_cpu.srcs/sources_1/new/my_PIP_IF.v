`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/17 19:31:23
// Design Name: 
// Module Name: my_PIP_IF
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


module my_PIP_IF(
input clk_IF, //�Ĵ���ʱ��
input rst_IF, //�Ĵ�����λ
input en_IF, //�Ĵ���ʹ��
input [31:0] PC_in_IF, //PC����
input PCSrc, //ָ������
output [31:0] PC_out_IF //PC���
    );
wire [31:0] o;
wire [31:0]Q;
assign o = PCSrc?PC_in_IF:(Q+3'b100);
assign Q= PC_out_IF ;
PC PC_2(
        .clk(clk_IF),
        .rst(rst_IF),
        .CE(en_IF),
        .D(o),
        . INT(1'b0),
        . ecall(1'b0),
        . mret(1'b0),
        . ill_instr(1'b0),
        .Q(PC_out_IF)
    );
endmodule
