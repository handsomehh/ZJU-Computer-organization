`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 16:23:48
// Design Name: 
// Module Name: IP2CPU_pipcpu
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


module IP2CPU_pipcpu(
    input clk, //Ê±ÖÓ
    input rst, //¸´Î»
    input[31:0] Data_in, //´æ´¢Æ÷Êý¾ÝÊäÈë
    input[31:0] inst_IF, //È¡Ö¸½×¶ÎÖ¸Áî
    output [31:0] PC_out_IF, //È¡Ö¸½×¶ÎPCÊä³ö
    output [31:0] PC_out_ID, //ÒëÂë½×¶ÎPCÊä³ö
    output [31:0] inst_ID, //ÒëÂë½×¶ÎÖ¸Áî
    output [31:0] PC_out_Ex, //Ö´ÐÐ½×¶ÎPCÊä³ö
    output [31:0] MemRW_Ex, //Ö´ÐÐ½×¶Î´æ´¢Æ÷¶ÁÐ´
    output [31:0] MemRW_Mem, //·Ã´æ½×¶Î´æ´¢Æ÷¶ÁÐ´
    output [31:0] Addr_out, //µØÖ·Êä³ö
    output [31:0] Data_out, //CPUÊý¾ÝÊä³ö
    output [31:0] Data_out_WB, //Ð´»ØÊý¾ÝÊä³ö
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
    output [31:0]IdEx_inst,
    output IdEx_valid,
    output [4:0]IdEx_rd,
    output [4:0]IdEx_rs1,
    output [4:0]IdEx_rs2,
    output [31:0]IdEx_rs1_val,
    output [31:0]IdEx_rs2_val,
    output IdEx_reg_wen,
    output IdEx_is_imm,
    output [31:0]IdEx_imm,
    output IdEx_mem_ren,
    output IdEx_is_branch,
    output IdEx_is_jal,
    output IdEx_is_jalr,
    output IdEx_is_auipc,
    output IdEx_is_lui,
    output [3:0]IdEx_alu_ctrl,
    output IdEx_cmp_ctrl,
    output [31:0]ExMa_pc,
    output [31:0]ExMa_inst,
    output ExMa_valid,
    output [4:0]ExMa_rd,
    output ExMa_reg_wen,
    output [4:0]MEMWB_rd,
    output MEMWB_reg_wen,
    output [31:0]MEMWB_pc,
    output [31:0]MEMWB_inst
);
wire en_IF;
wire en_IFID;
wire NOP_IFID;
wire NOP_IDEX;
wire [4:0]Rs1_addr_out_ID;
wire [4:0]Rs2_addr_out_ID;
wire Rs1_used;
wire Rs2_used;

wire en;
wire [31:0]PC_out_EXMem;
assign en = 1;
wire PCSrc_IF;
wire [4:0]Rd_addr_out_EXMem;
wire [31:0]real_PC_out_IF;
wire [4:0]Rd_addr_out_MemWB;
my_PIP_IF Pipeline_IF(.clk_IF(clk), .rst_IF(rst), .en_IF(en_IF), .PC_in_IF(PC_out_EXMem), .PCSrc(PCSrc_IF), .PC_out_IF(real_PC_out_IF));
assign PC_out_IF = real_PC_out_IF;

wire [31:0]PC_out_IFID;
wire [31:0]inst_out_IFID;

my_IF_reg_ID IF_reg_ID(.clk_IFID(clk), .rst_IFID(rst), .en_IFID(en_IFID), .PC_in_IFID(real_PC_out_IF), 
  .inst_in_IFID(inst_IF),.NOP_IFID(NOP_IFID), .PC_out_IFID(PC_out_IFID), .inst_out_IFID(inst_out_IFID));
assign PC_out_ID = PC_out_IFID;
assign inst_ID = inst_out_IFID;
wire RegWrite_in_ID;
wire [4:0]Rd_addr_ID;
wire [31:0]Wt_data_ID;

wire [4:0]Rd_addr_out_ID;
wire [31:0]Rs1_out_ID;
wire [31:0]Rs2_out_ID;
wire [31:0]Imm_out_ID;
wire ALUSrc_B_ID;
wire [3:0]ALU_control_ID;
wire Branch_ID;
wire BranchN_ID;
wire MemRW_ID;
wire Jump_ID;
wire [1:0]MemtoReg_ID;
wire RegWrite_out_ID;

wire RegWrite_out_MemWB;

my_PIP_ID Pipeline_ID(.clk_ID(clk), .rst_ID(rst), .RegWrite_in_ID(RegWrite_out_MemWB), .Rd_addr_ID(Rd_addr_out_MemWB), 
  .Wt_data_ID(Wt_data_ID), .Inst_in_ID(inst_out_IFID), .Rd_addr_out_ID(Rd_addr_out_ID),
   .Rs1_out_ID(Rs1_out_ID), .Rs2_out_ID(Rs2_out_ID), .Imm_out_ID(Imm_out_ID), .ALUSrc_B_ID(ALUSrc_B_ID), 
  .ALU_control_ID(ALU_control_ID), .Branch_ID(Branch_ID), .BranchN_ID(BranchN_ID),
   .MemRW_ID(MemRW_ID), .Jump_ID(Jump_ID), .MemtoReg_ID(MemtoReg_ID), .RegWrite_out_ID(RegWrite_out_ID),
   .Rs1_addr_out_ID(Rs1_addr_out_ID), .Rs2_addr_out_ID(Rs2_addr_out_ID),
   .Rs1_used(Rs1_used),.Rs2_used(Rs2_used),
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
        .reg_val_31(reg_val_31));


wire [31:0]PC_out_IDEX;
wire [4:0]Rd_addr_out_IDEX;
wire [31:0]Rs1_out_IDEX;
wire [31:0]Rs2_out_IDEX;
wire [31:0]Imm_out_IDEX;
wire ALUSrc_B_out_IDEX;
wire [3:0]ALU_control_out_IDEX;
wire Branch_out_IDEX;
wire BranchN_out_IDEX;
wire Jump_out_IDEX;
wire MemRW_out_IDEX;
wire [1:0]MemtoReg_out_IDEX;
wire RegWrite_out_IDEX;
wire [31:0]inst_out_IDEX;

my_ID_reg_Ex ID_reg_Ex(.clk_IDEX(clk), .rst_IDEX(rst), .en_IDEX(en), .PC_in_IDEX(PC_out_IFID), 
    .Rd_addr_IDEX(Rd_addr_out_ID), .Rs1_in_IDEX(Rs1_out_ID), .Rs2_in_IDEX(Rs2_out_ID), .Imm_in_IDEX(Imm_out_ID), 
    .ALUSrc_B_in_IDEX(ALUSrc_B_ID), .ALU_control_in_IDEX(ALU_control_ID), 
    .Branch_in_IDEX(Branch_ID), .BranchN_in_IDEX(BranchN_ID), .MemRW_in_IDEX(MemRW_ID), 
    .Jump_in_IDEX(Jump_ID), .MemtoReg_in_IDEX(MemtoReg_ID), 
    .RegWrite_in_IDEX(RegWrite_out_ID),.NOP_IDEX(NOP_IDEX), .PC_out_IDEX(PC_out_IDEX), .Rd_addr_out_IDEX(Rd_addr_out_IDEX), 
    .Rs1_out_IDEX(Rs1_out_IDEX), .Rs2_out_IDEX(Rs2_out_IDEX), .Imm_out_IDEX(Imm_out_IDEX), 
    .ALUSrc_B_out_IDEX(ALUSrc_B_out_IDEX), .ALU_control_out_IDEX(ALU_control_out_IDEX), 
    .Branch_out_IDEX(Branch_out_IDEX), .BranchN_out_IDEX(BranchN_out_IDEX), 
    .MemRW_out_IDEX(MemRW_out_IDEX), .Jump_out_IDEX(Jump_out_IDEX), .MemtoReg_out_IDEX(MemtoReg_out_IDEX), 
    .RegWrite_out_IDEX(RegWrite_out_IDEX),.Inst_in_IDEX(inst_out_IFID),.Inst_out_IDEX(inst_out_IDEX));


wire [31:0]real_PC_out_EX;
wire [31:0]PC4_out_EX;
wire zero_out_EX;
wire [31:0]ALU_out_EX;
wire [31:0]Rs2_out_EX;

my_pip_Ex Pipeline_Ex(.PC_in_EX(PC_out_IDEX), .Rs1_in_EX(Rs1_out_IDEX),
 .Rs2_in_EX(Rs2_out_IDEX), .Imm_in_EX(Imm_out_IDEX),
 .ALUSrc_B_in_EX(ALUSrc_B_out_IDEX), .ALU_control_in_EX(ALU_control_out_IDEX),
 .PC_out_EX(real_PC_out_EX), .PC4_out_EX(PC4_out_EX), .zero_out_EX(zero_out_EX), .ALU_out_EX(ALU_out_EX), 
 .Rs2_out_EX(Rs2_out_EX));
 
assign IdEx_rd = Rd_addr_out_IDEX;
assign IdEx_rs1 = inst_out_IDEX[19:15];
assign IdEx_rs2 = inst_out_IDEX[24:20];
assign IdEx_rs1_val = Rs1_out_IDEX;
assign IdEx_rs2_val = Rs2_out_IDEX;
assign IdEx_alu_ctrl = ALU_control_out_IDEX;
assign IdEx_reg_wen = RegWrite_out_IDEX;
assign IdEx_is_branch=(Branch_out_IDEX||BranchN_out_IDEX);
assign IdEx_is_jal=Jump_out_IDEX;
assign IdEx_imm =Imm_out_IDEX ;
assign IdEx_inst = inst_out_IDEX;

wire [31:0]PC4_out_EXMem;

wire zero_out_EXMem;
wire [31:0]ALU_out_EXMem;
wire [31:0]Rs2_out_EXMem;
wire Branch_out_EXMem;
wire BranchN_out_EXMem;
wire Jump_out_EXMem; 
wire [1:0]MemtoReg_out_EXMem;
wire RegWrite_out_EXMem;
wire MemRW_out_EXMem;
wire [31:0]Inst_out_EXMEM;
assign Data_out = Rs2_out_EXMem;
/* my_EX_reg_MEM Ex_reg_Mem(.clk(clk), .rst(rst), .en(en), real_PC_out_EX, 
   PC4_out_EX, Rd_addr_out_IDEX, zero_out_EX, ALU_out_EX, Rs2_out_EX, Branch_out_IDEX, 
   BranchN_out_IDEX, MemRW_out_IDEX, Jump_out_IDEX, MemtoReg_out_IDEX, RegWrite_out_IDEX, 
   PC_out_EXMem, PC4_out_EXMem, Rd_addr_out_EXMem, zero_out_EXMem, ALU_out_EXMem, 
   Rs2_out_EXMem, Branch_out_EXMem, BranchN_out_EXMem, MemRW_Mem, Jump_out_EXMem, 
   MemtoReg_out_EXMem, RegWrite_out_EXMem);*/
my_EX_reg_MEM Ex_reg_Mem(
    .clk_EXMem(clk), //¼Ä´æÆ÷Ê±ÖÓ
    .rst_EXMem(rst), //¼Ä´æÆ÷¸´Î»
    .en_EXMem(en), //¼Ä´æÆ÷Ê¹ÄÜ
    .PC_in_EXMem(real_PC_out_EX), //PCÊäÈë
    .PC4_in_EXMem(PC4_out_EX), //PC+4ÊäÈë
    .Rd_addr_EXMem(Rd_addr_out_IDEX), //Ð´Ä¿µÄ¼Ä´æÆ÷µØÖ·ÊäÈë
    .zero_in_EXMem(zero_out_EX), //zero
    .ALU_in_EXMem(ALU_out_EX), //ALUÊäÈë
    .Rs2_in_EXMem(Rs2_out_EX), //²Ù×÷Êý2ÊäÈë
    .Branch_in_EXMem(Branch_out_IDEX), //Beq
    .BranchN_in_EXMem(BranchN_out_IDEX), //Bne
    .MemRW_in_EXMem(MemRW_out_IDEX), //´æ´¢Æ÷¶ÁÐ´
    .Jump_in_EXMem(Jump_out_IDEX), //Jal
    .MemtoReg_in_EXMem(MemtoReg_out_IDEX), //Ð´»Ø
    .RegWrite_in_EXMem(RegWrite_out_IDEX), //¼Ä´æÆ÷¶Ñ¶ÁÐ´
    .PC_out_EXMem(PC_out_EXMem), //PCÊä³ö
    .PC4_out_EXMem(PC4_out_EXMem), //PC+4Êä³ö
    .Rd_addr_out_EXMem(Rd_addr_out_EXMem), //Ð´Ä¿µÄ¼Ä´æÆ÷Êä³ö
    .zero_out_EXMem(zero_out_EXMem), //zero
    .ALU_out_EXMem(ALU_out_EXMem), //ALUÊä³ö
    .Rs2_out_EXMem(Rs2_out_EXMem), //²Ù×÷Êý2Êä³ö
    .Branch_out_EXMem(Branch_out_EXMem), //Beq
    .BranchN_out_EXMem(BranchN_out_EXMem), //Bne
    .MemRW_out_EXMem(MemRW_out_EXMem), //´æ´¢Æ÷¶ÁÐ´
    .Jump_out_EXMem(Jump_out_EXMem), //Jal
    .MemtoReg_out_EXMem(MemtoReg_out_EXMem), //Ð´»Ø
    .RegWrite_out_EXMem(RegWrite_out_EXMem), //¼Ä´æÆ÷¶Ñ¶ÁÐ´
    .Inst_in_EXMEM(inst_out_IDEX),.Inst_out_EXMEM(Inst_out_EXMEM)
 );
assign MemRW_Ex = MemRW_out_IDEX;
assign PC_out_Ex = real_PC_out_EX;
assign MemRW_Mem = MemRW_out_EXMem;
assign ExMa_pc = PC_out_EXMem;
assign ExMa_rd = Rd_addr_out_EXMem;
assign ExMa_reg_wen=RegWrite_out_EXMem;
assign ExMa_inst = Inst_out_EXMEM;
my_pipline_Mem Pipeline_Mem(.zero_in_Mem(zero_out_EXMem), .Branch_in_Mem(Branch_out_EXMem), .BranchN_in_Mem(BranchN_out_EXMem), 
  .Jump_in_Mem(Jump_out_EXMem), .PCSrc(PCSrc_IF));
    
  
wire [31:0]PC4_out_MemWB;
wire [31:0]ALU_out_MemWB;
wire [31:0]DMem_data_out_MemWB;
wire [1:0]MemtoReg_out_MemWB;
wire [31:0]Inst_out_MEMWB;
my_Mem_reg_WB Mem_reg_WB(.clk_MemWB(clk), .rst_MemWB(rst), .en_MemWB(en), .PC4_in_MemWB(PC4_out_EXMem), 
    .Rd_addr_MemWB(Rd_addr_out_EXMem),.ALU_in_MemWB(ALU_out_EXMem), .Dmem_data_MemWB(Data_in), .MemtoReg_in_MemWB(MemtoReg_out_EXMem),
     .RegWrite_in_MemWB(RegWrite_out_EXMem), .PC4_out_MemWB(PC4_out_MemWB),
      .ALU_out_MemWB(ALU_out_MemWB), .DMem_data_out_MemWB(DMem_data_out_MemWB), .MemtoReg_out_MemWB(MemtoReg_out_MemWB),.Rd_addr_out_MemWB(Rd_addr_out_MemWB),
    .RegWrite_out_MemWB(RegWrite_out_MemWB),.Inst_in_MEMWB(Inst_out_EXMEM),.Inst_out_MEMWB(Inst_out_MEMWB));
assign Addr_out = ALU_out_EXMem;
  
my_pip_WB pip_WB(.PC4_in_WB(PC4_out_EXMem), .ALU_in_WB(ALU_out_MemWB),. Dmem_data_WB(DMem_data_out_MemWB), 
      .MemtoReg_in_WB(MemtoReg_out_MemWB), .Data_out_WB(Wt_data_ID));
assign Data_out_WB = Wt_data_ID;
assign MEMWB_rd = Rd_addr_out_MemWB;
assign MEMWB_reg_wen = RegWrite_out_MemWB;
assign MEMWB_pc = PC4_out_MemWB;
assign MEMWB_inst = Inst_out_MEMWB;
stall stall(.rst_stall(rst),
        .RegWrite_out_IDEX(RegWrite_out_IDEX),
        .Rd_addr_out_IDEX(Rd_addr_out_IDEX),
        .RegWrite_out_EXMem(RegWrite_out_EXMem),
        .Rd_addr_out_EXMem(Rd_addr_out_EXMem),
        .Rs1_addr_ID(Rs1_addr_out_ID),
        .Rs2_addr_ID(Rs2_addr_out_ID),
        .Rs1_used(Rs1_used),
        .Rs2_used(Rs2_used),
        .Branch_ID(Branch_ID),
        .BranchN_ID(BranchN_ID),
        .Jump_ID(Jump_ID),
        .Branch_out_IDEX(Branch_out_IDEX),
        .BranchN_out_IDEX(BranchN_out_IDEX),
        .Jump_out_IDEX(Jump_out_IDEX),
        .Branch_out_EXMem(Branch_out_EXMem),
        .BranchN_out_EXMem(BranchN_out_EXMem),
        .Jump_out_EXMem(Jump_out_EXMem),
        .en_IF(en_IF),
        .en_IFID(en_IFID),
        .NOP_IFID(NOP_IFID),
        .NOP_IDEX(NOP_IDEX));
endmodule