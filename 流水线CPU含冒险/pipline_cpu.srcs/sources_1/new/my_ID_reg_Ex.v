`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 16:37:42
// Design Name: 
// Module Name: my_ID_reg_Ex
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


module my_ID_reg_Ex(
input clk_IDEX, //寄存器时钟
input rst_IDEX, //寄存器复位
input en_IDEX, //寄存器使能
input[31:0] PC_in_IDEX, //PC输入
input[4:0] Rd_addr_IDEX, //写目的地址输入
input[31:0] Rs1_in_IDEX,//操作数1输入
input[31:0] Rs2_in_IDEX,//操作数2输如
input[31:0] Imm_in_IDEX , //立即数输入
input ALUSrc_B_in_IDEX , //ALU B输入选择
input[3:0] ALU_control_in_IDEX, //ALU选择控制
input Branch_in_IDEX, //Beq
input BranchN_in_IDEX, //Bne
input MemRW_in_IDEX, //存储器读写
input Jump_in_IDEX, //Jal
input[1:0] MemtoReg_in_IDEX, //写回选择
input RegWrite_in_IDEX, //寄存器堆读写
input NOP_IDEX,
output reg[31:0] PC_out_IDEX,//PC输出
output reg[4:0] Rd_addr_out_IDEX, //目的地址输出
output reg[31:0] Rs1_out_IDEX,//操作数1输出
output reg[31:0] Rs2_out_IDEX, //操作数2输出
output reg[31:0] Imm_out_IDEX , //立即数输出
output reg ALUSrc_B_out_IDEX , //ALU B选择
output reg[3:0] ALU_control_out_IDEX, //ALU控制
output reg Branch_out_IDEX, //Beq
output reg BranchN_out_IDEX, //Bne
output reg MemRW_out_IDEX, //存储器读写
output reg Jump_out_IDEX, //Jal
output reg [1:0] MemtoReg_out_IDEX, //写回
output reg RegWrite_out_IDEX ,//寄存器堆读写
input [31:0]Inst_in_IDEX,
output reg [31:0]Inst_out_IDEX
);

always @(negedge clk_IDEX or posedge rst_IDEX)
if (rst_IDEX == 1)begin
    PC_out_IDEX = 0;//PC输出
    Rd_addr_out_IDEX = 0; //目的地址输出
    Rs1_out_IDEX= 0;//操作数1输出
    Rs2_out_IDEX= 0; //操作数2输出
    Imm_out_IDEX= 0 ; //立即数输出
      ALUSrc_B_out_IDEX= 0 ; //ALU B选择
     ALU_control_out_IDEX= 0; //ALU控制
      Branch_out_IDEX= 0; //Beq
      BranchN_out_IDEX= 0; //Bne
      MemRW_out_IDEX= 0; //存储器读写
      Jump_out_IDEX= 0; //Jal
     MemtoReg_out_IDEX = 0; //写回
     RegWrite_out_IDEX = 0; //寄存器堆读写
     Inst_out_IDEX = 0;
end
else if(NOP_IDEX == 1)begin
        PC_out_IDEX = 32'h00000000;//PC输出
        Rd_addr_out_IDEX = 0; //目的地址输出
        Rs1_out_IDEX= 0;//;//操作数1输出
        Rs2_out_IDEX= 0;//; //操作数2输出
        Imm_out_IDEX= 0; //立即数输出
        ALUSrc_B_out_IDEX= 0; //ALU B选择
        ALU_control_out_IDEX= 0; //ALU控制
        Branch_out_IDEX= 0; //Beq
        BranchN_out_IDEX= 0; //Bne
        MemRW_out_IDEX= 0; //存储器读写
        Jump_out_IDEX= 0; //Jal
        MemtoReg_out_IDEX = 0; //写回
        RegWrite_out_IDEX = 0; //寄存器堆读写
	end
else if (en_IDEX == 1)begin 
    PC_out_IDEX = PC_in_IDEX;//PC输出
    Rd_addr_out_IDEX = Rd_addr_IDEX; //目的地址输出
    Rs1_out_IDEX= Rs1_in_IDEX;//;//操作数1输出
    Rs2_out_IDEX= Rs2_in_IDEX;//; //操作数2输出
    Imm_out_IDEX= Imm_in_IDEX; //立即数输出
      ALUSrc_B_out_IDEX= ALUSrc_B_in_IDEX; //ALU B选择
     ALU_control_out_IDEX= ALU_control_in_IDEX; //ALU控制
      Branch_out_IDEX= Branch_in_IDEX; //Beq
      BranchN_out_IDEX= BranchN_in_IDEX; //Bne
      MemRW_out_IDEX= MemRW_in_IDEX; //存储器读写
      Jump_out_IDEX= Jump_in_IDEX; //Jal
     MemtoReg_out_IDEX = MemtoReg_in_IDEX; //写回
     RegWrite_out_IDEX = RegWrite_in_IDEX; //寄存器堆读写
     Inst_out_IDEX = Inst_in_IDEX;
end
endmodule
