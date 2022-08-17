`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/17 19:31:48
// Design Name: 
// Module Name: my_PIP_ID
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



module my_PIP_ID(
    input clk_ID, //时钟
    input rst_ID, //复位
    input RegWrite_in_ID,//寄存器堆使能
    input [4:0] Rd_addr_ID, //写目的地址输入
    input [31:0] Wt_data_ID, //写数据输入
    input [31:0] Inst_in_ID, //指令输入
    output  [31:0] Rd_addr_out_ID, //写目的地址输出
    output  [31:0] Rs1_out_ID, //操作数1输出
    output  [31:0] Rs2_out_ID, //操作数2输出
    output [31:0] Imm_out_ID, //立即数输出
    output  ALUSrc_B_ID, //ALU B端输入选择
    output  [3:0] ALU_control_ID,//ALU控制
    output  Branch_ID,//Beq控制
    output  BranchN_ID,//Bne控制
    output  MemRW_ID,//存储器读写
    output  Jump_ID,//Jal控制
    output  [1:0] MemtoReg_ID,//寄存器写回选择
    output  RegWrite_out_ID,//寄存器堆读写
    
     output [31:0]reg_val_1,
    output [31:0]reg_val_2,
    output [31:0]reg_val_3,
    output [31:0]reg_val_4,
    output [31:0]reg_val_5,
    output [31:0]reg_val_6,
    output [31:0]reg_val_7,
    output [31:0]reg_val_8,
    output [31:0]reg_val_9,
    output [31:0]reg_val_10,
    output [31:0]reg_val_11,
    output [31:0]reg_val_12,
    output [31:0]reg_val_13,
    output [31:0]reg_val_14,
    output [31:0]reg_val_15,
    output [31:0]reg_val_16,
    output [31:0]reg_val_17,
    output [31:0]reg_val_18,
    output [31:0]reg_val_19,
    output [31:0]reg_val_20,
    output [31:0]reg_val_21,
    output [31:0]reg_val_22,
    output [31:0]reg_val_23,
    output [31:0]reg_val_24,
    output [31:0]reg_val_25,
    output [31:0]reg_val_26,
    output [31:0]reg_val_27,
    output [31:0]reg_val_28,
    output [31:0]reg_val_29,
    output [31:0]reg_val_30,
    output [31:0]reg_val_31,
    output [4:0]Rs1_addr_out_ID,
    output [4:0]Rs2_addr_out_ID,
    output Rs1_used,
    output Rs2_used
);
assign Rd_addr_out_ID = Inst_in_ID[11:7];
wire [31:0]inst_field=Inst_in_ID;
wire [2:0]ImmSel;
    ImmGen ImmGen_1(
        .ImmSel(ImmSel),
        .inst_field(Inst_in_ID),
        .Imm_out(Imm_out_ID)
    );
    
    SCPU_4921 controller(
    .OPcode(Inst_in_ID[6:0]),
    .Fun3(Inst_in_ID[14:12]),
    .Fun7(Inst_in_ID[30]),
    .MIO_ready(),
    .ImmSel(ImmSel),
    .ALUSrc_B(ALUSrc_B_ID),
    .MemtoReg(MemtoReg_ID),
    .Jump(Jump_ID),
    .Branch(Branch_ID),
    .BranchN(BranchN_ID),
    .RegWrite(RegWrite_out_ID),
    .MemRW(MemRW_ID),
    .ALU_Control(ALU_control_ID),
    .CPU_MIO(),
    .Rs1_used(Rs1_used),
    .Rs2_used(Rs2_used)
  );
  assign Rs1_addr_out_ID = Inst_in_ID[19:15];
  assign Rs2_addr_out_ID = Inst_in_ID[24:20];
//  assign Rs1_used = 1;
//  assign Rs2_used = !ALUSrc_B_ID;
   RegFile RegFile_1(
         .clk(clk_ID),
         .rst(rst_ID),
         .RegWrite(RegWrite_in_ID),
         .Rs1_addr(Inst_in_ID[19:15]),
         .Rs2_addr(Inst_in_ID[24:20]),
         .Wt_addr(Rd_addr_ID),
         .Wt_data(Wt_data_ID),
         .Rs1_data(Rs1_out_ID),
         .Rs2_data(Rs2_out_ID),
        .reg_val_1(reg_val_1),
        .reg_val_2(reg_val_2),
        .reg_val_3(reg_val_3),
        .reg_val_4(reg_val_4),
        .reg_val_5(reg_val_5),
        .reg_val_6(reg_val_6),
        .reg_val_7(reg_val_7),
        .reg_val_8(reg_val_8),
        .reg_val_9(reg_val_9),
        .reg_val_10(reg_val_10),
        .reg_val_11(reg_val_11),
        .reg_val_12(reg_val_12),
        .reg_val_13(reg_val_13),
        .reg_val_14(reg_val_14),
        .reg_val_15(reg_val_15),
        .reg_val_16(reg_val_16),
        .reg_val_17(reg_val_17),
        .reg_val_18(reg_val_18),
        .reg_val_19(reg_val_19),
        .reg_val_20(reg_val_20),
        .reg_val_21(reg_val_21),
        .reg_val_22(reg_val_22),
        .reg_val_23(reg_val_23),
        .reg_val_24(reg_val_24),
        .reg_val_25(reg_val_25),
        .reg_val_26(reg_val_26),
        .reg_val_27(reg_val_27),
        .reg_val_28(reg_val_28),
        .reg_val_29(reg_val_29),
        .reg_val_30(reg_val_30),
        .reg_val_31(reg_val_31)
    );
endmodule
