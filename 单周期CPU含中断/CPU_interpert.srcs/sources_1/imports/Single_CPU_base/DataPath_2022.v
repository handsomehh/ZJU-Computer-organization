`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/19 13:52:31
// Design Name: 
// Module Name: DataPath
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


module DataPath_2022(
    input Branch,
    input [1:0]Jump,
    input [31:0]Data_in,
    input [1:0]MemtoReg,
    input ALUSrc_B,
    input [2:0]ImmSel,
    input [31:0]inst_field,
    input [3:0]ALU_operation,
    input clk,
    input rst,
    input RegWrite,
    input BranchN,
    input int,
    input ecall,
    input mret,
    input ill_instr,
    output [31:0]ALU_out,
    output [31:0]Data_out,
    output [31:0]PC_out,
    output [31:0]imm,
    output [31:0]Rs_data1,
    output [31:0]Rs_data2,
    output [31:0]Wt_data,
    output [31:0] b_val,
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
    output [31:0]mepc_res
    );
    wire[31:0]c0;
    wire[31:0]c1;
    wire [31:0]o0;
    wire [31:0]o1;
    wire [31:0]o2;
    wire [31:0]o3;
    wire [31:0]Rs2_data;
    wire [31:0]Rs1_data;
    wire [31:0]ALU_res;
    wire [31:0]Imm_out;
    wire [31:0]Q;
    wire zero;
    
    /*MUX2T1_32 MUX2T1_32_1(
        .I0(c0),
        .I1(c1),
        .s((Branch&&zero)||(BranchN&&zero)),
        .o(o0)
    );*/
    
    assign c0 = Q+4;
    assign c1 = Q+Imm_out;
    
    ALU ALU_1(
        .A(Rs1_data),
        .B(o3),
        .ALU_operation(ALU_operation),
        .res(ALU_res),
        .zero(zero)
    );
    assign o0 = ((Branch&&zero)||(BranchN&&(~zero)))?c1:c0;
   /* MUX4T1_32 MUX4T1_32_0(
        .I0(ALU_res),
        .I1(Data_in),
        .I2(c0),
        .I3(Imm_out),
        .s(MemtoReg),
        .o(o1)
    );*/
    assign o1 = (MemtoReg==2'b00)?ALU_res:(MemtoReg==2'b01)?Data_in:(MemtoReg==2'b10)?c0:Imm_out;
     /*MUX4T1_32 MUX2T1_32_3(
        .I0(o0),
        .I1(c1),
        .I2(ALU_res),
        .I3(ALU_res),
        .s(Jump),
        .o(o2)
    );*/
    assign o2 = (Jump==2'b00)?o0:(Jump==2'b01)?c1:(Jump==2'b10)?ALU_res:ALU_res;
    /*MUX2T1_32 MUX2T1_32_0(
        .I0(Rs2_data),
        .I1(Imm_out),
        .s(ALUSrc_B),
        .o(o3)
    );*/
    assign o3 = ALUSrc_B?Imm_out:Rs2_data;
    assign b_val = o3;
    RegFile RegFile_1(
         .clk(clk),
         .rst(rst),
         .RegWrite(RegWrite),
         .Rs1_addr(inst_field[19:15]),
         .Rs2_addr(inst_field[24:20]),
         .Wt_addr(inst_field[11:7]),
         .Wt_data(o1),
         .Rs1_data(Rs1_data),
         .Rs2_data(Rs2_data),
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
    PC PC_1(
        .clk(clk),
        .rst(rst),
        .INT(int),
        .ecall(ecall),
        .mret(mret),
        .ill_instr(ill_instr),
        .CE(1'b1),
        .D(o2),
        .Q(Q),
        .mepc_res(mepc_res)
    );
    ImmGen ImmGen_1(
        .ImmSel(ImmSel),
        .inst_field(inst_field),
        .Imm_out(Imm_out)
    );
    assign PC_out = Q;
    assign ALU_out = ALU_res;
    assign Data_out=Rs2_data;
    assign imm = Imm_out;
    assign Rs_data1 = Rs1_data;
    assign Rs_data2 = Rs2_data;
    assign Wt_data = o1;
endmodule
