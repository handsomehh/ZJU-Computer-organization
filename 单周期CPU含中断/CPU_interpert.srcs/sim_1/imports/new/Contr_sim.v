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
     wire [2:0]ImmSel; //������ѡ����� //
     wire ALUSrc_B; //Դ������2ѡ��
     wire [1:0]MemtoReg; //д������ѡ�����
     wire [1:0]Jump; //jal //
     wire Branch; //beq
     wire BranchN; //bne //
     wire RegWrite; //�Ĵ���дʹ��
     wire MemRW; //�洢����дʹ��
     wire [3:0]ALU_Control; //alu���� //
     wire CPU_MIO; //not use
     
SCPU_4921 tb(
     .OPcode(OPcode), //OPcode------inst[6:0] //
     .Fun3(Fun3), //Function-----inst[14:12]
     .Fun7(Fun7), //Function-----inst[30]
     .MIO_ready(MIO_ready), //CPU Wait
      .ImmSel(ImmSel), //������ѡ����� //
      .ALUSrc_B(ALUSrc_B), //Դ������2ѡ��
      .MemtoReg(MemtoReg), //д������ѡ�����
      .Jump(Jump), //jal //
      .Branch(Branch), //beq
      .BranchN(BranchN), //bne //
      .RegWrite(RegWrite), //�Ĵ���дʹ��
      .MemRW(MemRW),//�洢����дʹ��
      .ALU_Control(ALU_Control), //alu���� //
      .CPU_MIO(CPU_MIO) //not use
     );
initial begin
// Initialize Inputs
OPcode = 0;
MIO_ready = 0; #40;
// Wait 40 ns for global reset to finish�������ǲ���ģ����롣
// Add stimulus here
//�������źź͹ؼ��ź�����Ƿ�������ֵ��
OPcode = 7'b0010011;
Fun3 = 3'b111;
#20
OPcode = 7'b0110111;
#20
OPcode = 7'b0110011; //ALUָ���� ALUop=2'b10; RegWrite=1
Fun3 = 3'b000; Fun7 = 1'b0;//add,���ALU_Control=3'b010
#20;
Fun3 = 3'b000; Fun7 = 1'b1;//sub,���ALU_Control=3'b110
#20;
Fun3 = 3'b111; Fun7 = 1'b0;//and,���ALU_Control=3'b000
#20;
Fun3 = 3'b110; Fun7 = 1'b0;//or,���ALU_Control=3'b001
#20;
Fun3 = 3'b010; Fun7 = 1'b0 ;//slt,���ALU_Control=3'b111
#20;
Fun3 = 3'b101; Fun7 = 1'b0; //srl,���ALU_Control=3'b101
#20;
Fun3 = 3'b100; Fun7 = 1'b0; //xor,���ALU_Control=3'b011
#20;
Fun3 = 3'b111; Fun7 = 1'b1; //���
#1;
OPcode = 7'b0100011; //S-Type,loadָ���� ALUop=2'b00, #20; // ALUSrc_B=1, MemtoReg=1, RegWrite=1
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

OPcode = 7'b0100011; #20; //storeָ����ALUop=2'b00, MemRW=1, ALUSrc_B=1
OPcode = 7'b1100011;//beqָ���� ALUop=2'b01, Branch=1 #20;
OPcode = 7'b1101111; //jumpָ���� Jump=1
OPcode = 7'b0010011; //Iָ���� ALUop=2'b11; RegWrite=1 #20;
Fun3 = 3'b000; //addi,���ALU_Control=3'b010
#20;
OPcode = 5'h1f; //���
Fun3 = 3'b000; Fun7 = 1'b0;//���
end
endmodule