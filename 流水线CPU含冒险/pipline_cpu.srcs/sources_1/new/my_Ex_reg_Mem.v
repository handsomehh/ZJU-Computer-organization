`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 16:19:45
// Design Name: 
// Module Name: my_EX_reg_MEM
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


module my_EX_reg_MEM(
input clk_EXMem, //寄存器时钟
input rst_EXMem, //寄存器复位
input en_EXMem, //寄存器使能
input[31:0] PC_in_EXMem, //PC输入
input[31:0] PC4_in_EXMem, //PC+4输入
input [4:0] Rd_addr_EXMem, //写目的寄存器地址输入
input zero_in_EXMem, //zero
input[31:0] ALU_in_EXMem, //ALU输入
input[31:0] Rs2_in_EXMem, //操作数2输入
input Branch_in_EXMem, //Beq
input BranchN_in_EXMem, //Bne
input MemRW_in_EXMem, //存储器读写
input Jump_in_EXMem, //Jal
input [1:0] MemtoReg_in_EXMem, //写回
input RegWrite_in_EXMem, //寄存器堆读写
output reg[31:0] PC_out_EXMem, //PC输出
output reg[31:0] PC4_out_EXMem, //PC+4输出
output reg[4:0] Rd_addr_out_EXMem, //写目的寄存器输出
output reg zero_out_EXMem, //zero
output reg[31:0] ALU_out_EXMem, //ALU输出
output reg[31:0] Rs2_out_EXMem, //操作数2输出
output reg Branch_out_EXMem, //Beq
output reg BranchN_out_EXMem, //Bne
output reg MemRW_out_EXMem, //存储器读写
output reg Jump_out_EXMem, //Jal
output reg [1:0]MemtoReg_out_EXMem, //写回
output reg RegWrite_out_EXMem, //寄存器堆读写
input [31:0]Inst_in_EXMEM,
output reg [31:0]Inst_out_EXMEM
 );
 
always @(negedge clk_EXMem or posedge rst_EXMem)
if (rst_EXMem==1)begin
     PC_out_EXMem = 0;//PC输出
     Rd_addr_out_EXMem = 0; //目的地址输出
     PC4_out_EXMem= 0;//操作数1输出
     Rs2_out_EXMem= 0; //操作数2输出
     zero_out_EXMem= 0 ; //立即数输出
      ALU_out_EXMem= 0 ; //ALU B选择
          Branch_out_EXMem= 0; //Beq
          BranchN_out_EXMem= 0; //Bne
          MemRW_out_EXMem= 0; //存储器读写
          Jump_out_EXMem= 0; //Jal
         MemtoReg_out_EXMem = 0; //写回
         RegWrite_out_EXMem = 0; //寄存器堆读写
         Inst_out_EXMEM = 0;
end
else if (en_EXMem == 1)begin 
   PC_out_EXMem = PC_in_EXMem;//PC输出
    Rd_addr_out_EXMem = Rd_addr_EXMem; //目的地址输出
    PC4_out_EXMem=  PC4_in_EXMem;//;//操作数1输出
    Rs2_out_EXMem= Rs2_in_EXMem;//; //操作数2输出
    zero_out_EXMem= zero_in_EXMem; //立即数输出
      ALU_out_EXMem= ALU_in_EXMem; //ALU B选择
      Branch_out_EXMem= Branch_in_EXMem; //Beq
      BranchN_out_EXMem= BranchN_in_EXMem; //Bne
      MemRW_out_EXMem= MemRW_in_EXMem; //存储器读写
      Jump_out_EXMem= Jump_in_EXMem; //Jal
     MemtoReg_out_EXMem = MemtoReg_in_EXMem; //写回
     RegWrite_out_EXMem = RegWrite_in_EXMem; //寄存器堆读写
     Inst_out_EXMEM = Inst_in_EXMEM;
end
endmodule
