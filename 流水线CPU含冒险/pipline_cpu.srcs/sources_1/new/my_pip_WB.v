`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 14:59:06
// Design Name: 
// Module Name: my_pip_WB
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


module my_pip_WB(
input[31:0] PC4_in_WB, //PC+4����
input[31:0] ALU_in_WB, //ALU������
input[31:0] Dmem_data_WB, //�洢����������
input[1:0] MemtoReg_in_WB, //д��ѡ�����
output [31:0] Data_out_WB //д���������
);
assign Data_out_WB = (MemtoReg_in_WB==2'b00)?ALU_in_WB:(MemtoReg_in_WB==2'b01)?Dmem_data_WB:PC4_in_WB;
endmodule
