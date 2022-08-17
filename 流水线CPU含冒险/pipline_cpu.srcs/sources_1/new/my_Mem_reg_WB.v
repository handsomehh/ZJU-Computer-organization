`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 16:33:49
// Design Name: 
// Module Name: my_Mem_reg_WB
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


module my_Mem_reg_WB(
input clk_MemWB, //�Ĵ���ʱ
input rst_MemWB, //�Ĵ�����λ
input en_MemWB, //�Ĵ���ʹ��
input[31:0] PC4_in_MemWB, //PC+4����
input[4:0] Rd_addr_MemWB, //дĿ�ĵ�ַ����
input[31:0] ALU_in_MemWB, //ALU����
input[31:0] Dmem_data_MemWB, //�洢����������
input[1:0] MemtoReg_in_MemWB, //д��
input RegWrite_in_MemWB, //�Ĵ����Ѷ�д
output reg[31:0] PC4_out_MemWB, //PC+4���
output reg[4:0] Rd_addr_out_MemWB, //дĿ�ĵ�ַ���
output reg[31:0] ALU_out_MemWB, //ALU���
output reg[31:0] DMem_data_out_MemWB, //�洢���������
output reg[1:0] MemtoReg_out_MemWB, //д��
output reg RegWrite_out_MemWB,//�Ĵ����Ѷ�д
input [31:0]Inst_in_MEMWB,
output reg[31:0]Inst_out_MEMWB
); 
always @(negedge clk_MemWB or posedge rst_MemWB)begin
    if (rst_MemWB==1)begin
        PC4_out_MemWB = 0;
        Rd_addr_out_MemWB = 0;
        ALU_out_MemWB = 0;
        DMem_data_out_MemWB = 0;
        MemtoReg_out_MemWB = 0;
        RegWrite_out_MemWB = 0;
        Inst_out_MEMWB = 0;
    end
    else if (en_MemWB == 1)begin 
        PC4_out_MemWB = PC4_in_MemWB;
        Rd_addr_out_MemWB = Rd_addr_MemWB;
        ALU_out_MemWB = ALU_in_MemWB;
        DMem_data_out_MemWB = Dmem_data_MemWB;
        MemtoReg_out_MemWB = MemtoReg_in_MemWB;
        RegWrite_out_MemWB = RegWrite_in_MemWB;
        Inst_out_MEMWB = Inst_in_MEMWB;
    end
end
endmodule
