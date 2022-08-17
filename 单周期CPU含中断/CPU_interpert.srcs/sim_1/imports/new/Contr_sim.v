`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/27 16:48:48
// Design Name: 
// Module Name: Contr_sim
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


module Contr_sim(

    );
    reg [6:0]OPcode; //OPcode------inst[6:0] //
    reg [2:0]Fun3; //Function-----inst[14:12]
    reg Fun7; //Function-----inst[30]
    reg MIO_ready; //CPU Wait
     wire [2:0]ImmSel; //立即数选择控制 //
     wire ALUSrc_B; //源操作数2选择
     wire [1:0]MemtoReg; //写回数据选择控制
     wire [1:0]Jump; //jal //
     wire Branch; //beq
     wire BranchN; //bne //
     wire RegWrite; //寄存器写使能
     wire MemRW; //存储器读写使能
     wire [3:0]ALU_Control; //alu控制 //
     wire CPU_MIO; //not use
     
SCPU_4921 tb(
     .OPcode(OPcode), //OPcode------inst[6:0] //
     .Fun3(Fun3), //Function-----inst[14:12]
     .Fun7(Fun7), //Function-----inst[30]
     .MIO_ready(MIO_ready), //CPU Wait
      .ImmSel(ImmSel), //立即数选择控制 //
      .ALUSrc_B(ALUSrc_B), //源操作数2选择
      .MemtoReg(MemtoReg), //写回数据选择控制
      .Jump(Jump), //jal //
      .Branch(Branch), //beq
      .BranchN(BranchN), //bne //
      .RegWrite(RegWrite), //寄存器写使能
      .MemRW(MemRW),//存储器读写使能
      .ALU_Control(ALU_Control), //alu控制 //
      .CPU_MIO(CPU_MIO) //not use
     );
initial begin
// Initialize Inputs
OPcode = 0;
MIO_ready = 0; #40;
// Wait 40 ns for global reset to finish。以上是测试模板代码。
// Add stimulus here
//检查输出信号和关键信号输出是否满足真值表
OPcode = 7'b0010011;
Fun3 = 3'b111;
#20
OPcode = 7'b0110111;
#20
OPcode = 7'b0110011; //ALU指令，检查 ALUop=2'b10; RegWrite=1
Fun3 = 3'b000; Fun7 = 1'b0;//add,检查ALU_Control=3'b010
#20;
Fun3 = 3'b000; Fun7 = 1'b1;//sub,检查ALU_Control=3'b110
#20;
Fun3 = 3'b111; Fun7 = 1'b0;//and,检查ALU_Control=3'b000
#20;
Fun3 = 3'b110; Fun7 = 1'b0;//or,检查ALU_Control=3'b001
#20;
Fun3 = 3'b010; Fun7 = 1'b0 ;//slt,检查ALU_Control=3'b111
#20;
Fun3 = 3'b101; Fun7 = 1'b0; //srl,检查ALU_Control=3'b101
#20;
Fun3 = 3'b100; Fun7 = 1'b0; //xor,检查ALU_Control=3'b011
#20;
Fun3 = 3'b111; Fun7 = 1'b1; //间隔
#1;
OPcode = 7'b0100011; //S-Type,load指令，检查 ALUop=2'b00, #20; // ALUSrc_B=1, MemtoReg=1, RegWrite=1
Fun3 = 3'b010;
#20

OPcode = 7'b1100011;//B-Type,
Fun3 = 3'b000;//Beq
#20
Fun3 = 3'b001;//Bne
#20

OPcode = 7'b0110111;//lui
#20
OPcode = 7'b1101111;//J-Type,jal
#20
OPcode = 7'b0000011;//I-Type,lw
#20
OPcode = 7'b1100111;//jalr
#20
OPcode = 7'b0010011;//I-Type
Fun7 = 0;
Fun3 = 3'b000;
#20
Fun3 = 3'b001;
#20
Fun3 = 3'b010;
#20
Fun3 = 3'b011;
#20
Fun3 = 3'b100;
#20
Fun3 = 3'b101;
#20
Fun3 = 3'b110;
#20
Fun3 = 3'b111;
#20

OPcode = 7'b0100011; #20; //store指令，检查ALUop=2'b00, MemRW=1, ALUSrc_B=1
OPcode = 7'b1100011;//beq指令，检查 ALUop=2'b01, Branch=1 #20;
OPcode = 7'b1101111; //jump指令，检查 Jump=1
OPcode = 7'b0010011; //I指令，检查 ALUop=2'b11; RegWrite=1 #20;
Fun3 = 3'b000; //addi,检查ALU_Control=3'b010
#20;
OPcode = 5'h1f; //间隔
Fun3 = 3'b000; Fun7 = 1'b0;//间隔
end
endmodule