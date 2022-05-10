`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/12 19:02:44
// Design Name: 
// Module Name: IP2CPU
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


module IP2CPU(
  input clk,
  input rst,
  input MIO_ready,
  input [31:0]inst_in,
  input [31:0]Data_in,
  output CPU_MIO,
  output MemRW,
  output [31:0]PC_out,
  output [31:0]Data_out,
  output [31:0]Addr_out,
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
    output [31:0] imm,
    output [31:0]Rs_data1,
    output [31:0]Rs_data2,
    output [31:0]Wt_data,
    output [31:0]b_val,
    output [3:0]ALU_Control,
    output [1:0]MemtoReg,
    output RegWrite
  );
  wire BranchN;
  wire [2:0]ImmSel;
  wire ALUSrc_B;
  wire [1:0]Jump;
  wire Branch;
  SCPU_4921 controller(
    .OPcode(inst_in[6:0]),
    .Fun3(inst_in[14:12]),
    .Fun7(inst_in[30]),
    .MIO_ready(MIO_ready),
    .ImmSel(ImmSel),
    .ALUSrc_B(ALUSrc_B),
    .MemtoReg(MemtoReg),
    .Jump(Jump),
    .Branch(Branch),
    .BranchN(BranchN),
    .RegWrite(RegWrite),
    .MemRW(MemRW),
    .ALU_Control(ALU_Control),
    .CPU_MIO(CPU_MIO)
  );
  
  DataPath_2022 DataPath(
  .ImmSel(ImmSel),
  .ALUSrc_B(ALUSrc_B),
  .MemtoReg(MemtoReg),
  .Jump(Jump),
  .Branch(Branch),
  .BranchN(BranchN),
  .RegWrite(RegWrite),
  .ALU_operation(ALU_Control),
  .clk(clk),
  .inst_field(inst_in),
  .rst(rst),
  .ALU_out(Addr_out),
  .Data_out(Data_out),
  .PC_out(PC_out),
  .Data_in(Data_in),
  
  .b_val(b_val),
  .Wt_data(Wt_data),
  .Rs_data1(Rs_data1),
  .Rs_data2(Rs_data2),
  .imm(imm),
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
