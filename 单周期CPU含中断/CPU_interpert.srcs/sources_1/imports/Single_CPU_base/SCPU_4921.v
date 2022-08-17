`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/12 18:25:17
// Design Name: 
// Module Name: SCPU_4921
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
module SCPU_4921( 
    input[6:0]OPcode, //OPcode------inst[6:0] //
    input[2:0]Fun3, //Function-----inst[14:12]
    input Fun7, //Function-----inst[30]
    input MIO_ready, //CPU Wait
    input [2:0]Fun_ecall,
    input [1:0]Fun_mret,
    output reg [2:0]ImmSel, //立即数选择控制 //
    output reg ALUSrc_B, //源操作数2选择
    output reg [1:0]MemtoReg, //写回数据选择控制
    output reg [1:0]Jump, //jal //
    output reg Branch, //beq
    output reg BranchN, //bne //
    output reg RegWrite, //寄存器写使能
    output reg MemRW, //存储器读写使能
    output reg [3:0]ALU_Control, //alu控制 //
    output reg CPU_MIO, //not use
    output reg ecall,
    output reg mret,
    output reg ill_instr
); 

    wire Rop = (OPcode[6:2] == 5'b01100);
    wire Iop = (OPcode[6:2] == 5'b00100);
    wire Bop = (OPcode[6:2] == 5'b11000);
    wire Lop = (OPcode[6:2] == 5'b00000);
    wire Sop = (OPcode[6:2] == 5'b01000);
    wire Jop = (OPcode[6:2] == 5'b11011);
    wire Uop = (OPcode[6:2] == 5'b01101)||(OPcode[6:2] == 5'b00101);
    wire Jalr = (OPcode[6:2] == 5'b11001);
    wire int = (OPcode == 7'b1110011);
    wire int_ecall = int && (Fun_ecall == 3'b000);
    wire int_mret = int && (Fun_mret == 2'b11);
    wire int_ill = !(Rop||Iop||Bop||Lop||Sop||Jop||Uop||Jalr||int_ecall||int_mret);
    reg [1:0] ALU_op;
    
wire [1:0]ALU_op_add=2'b00;
wire [1:0] ALU_op_sub=2'b01;
wire [1:0] ALU_op_r=2'b10;
wire [1:0] ALU_op_i=2'b11;

   
       always@(*)
    begin
        Jump = Jop? 2'b01:
               Jalr? 2'b10:
               2'b00;
        Branch = Bop&(Fun3==3'b000);
        BranchN = Bop&(Fun3==3'b001);
        ImmSel = Jop ? 3'b100:
                 Bop ? 3'b011:
                 Sop ? 3'b010:
                 Iop|Lop|Jalr ? 3'b001:
                 3'b000;//Uop, lui
        ALUSrc_B = Rop|Bop? 0:1;
        MemtoReg = Rop|Iop? 2'b00:
                   Lop? 2'b01:
                   Uop? 2'b11:
                   2'b10;
        /*if(Uop|Rop)RegWrite=1;
        else if(Iop|Lop)RegWrite=1;
        else if(Jop)RegWrite=1;
        else RegWrite=0;*/
        RegWrite = Uop|Rop|Iop|Lop|Jop|Jalr? 1:0;//Rop|Iop|Lop|Jop
        MemRW = Sop? 1:0;
        ALU_op = Rop ? ALU_op_r:
                 Iop ? ALU_op_i:
                 Sop|Lop ? ALU_op_add:
                 ALU_op_sub;
        case(ALU_op)
            2'b00:ALU_Control = 4'b0010;
            2'b01:ALU_Control = 4'b0110;
            2'b10:
                case({Fun3,Fun7})
                    4'b0000:ALU_Control = 4'b0010;
                    4'b0001:ALU_Control = 4'b0110;
                    4'b0100:ALU_Control = 4'b0111;
                    4'b1000:ALU_Control = 4'b1100;
                    4'b1010:ALU_Control = 4'b1101;
                    4'b1100:ALU_Control = 4'b0001;
                    4'b1110:ALU_Control = 4'b0000;
                    4'b0010:ALU_Control = 4'b1110;
                    4'b0110:ALU_Control = 4'b1001;
                    4'b1011:ALU_Control = 4'b1111;
                    
                endcase
            2'b11:
                case(Fun3)
                    3'b000:ALU_Control = 4'b0010;
                    3'b010:ALU_Control = 4'b0111;
                    3'b100:ALU_Control = 4'b1100;
                    3'b110:ALU_Control = 4'b0001;
                    3'b111:ALU_Control = 4'b0000;
                    3'b011:ALU_Control = 4'b1001;
                    3'b001:ALU_Control = 4'b1110;
                    3'b101:ALU_Control = Fun7?4'b1111:4'b1101;
                endcase
           endcase
           ecall = int_ecall;
           mret = int_mret;
           ill_instr = int_ill;
    end
endmodule