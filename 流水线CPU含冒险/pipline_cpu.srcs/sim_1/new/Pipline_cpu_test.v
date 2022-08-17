`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 19:13:47
// Design Name: 
// Module Name: Pipline_cpu_test
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


module Pipline_cpu_test(

    );
    reg clk,rst;
   reg[31:0] spo;
reg[31:0] Cpu_data4bus;
 wire [31:0] PC_out_IF; //È¡Ö¸½×¶ÎPCÊä³ö
    wire [31:0] PC_out_ID; //ÒëÂë½×¶ÎPCÊä³ö
    wire [31:0] inst_ID; //ÒëÂë½×¶ÎÖ¸Áî
    wire [31:0] PC_out_Ex; //Ö´ÐÐ½×¶ÎPCÊä³ö
    wire [31:0] MemRW_Ex; //Ö´ÐÐ½×¶Î´æ´¢Æ÷¶ÁÐ´
    wire [31:0] MemRW_Mem; //·Ã´æ½×¶Î´æ´¢Æ÷¶ÁÐ´
    wire [31:0] Addr_out; //µØÖ·Êä³ö
    wire [31:0] Data_out; //CPUÊý¾ÝÊä³ö
    wire [31:0] Data_out_WB; //Ð´»ØÊý¾ÝÊä³ö
    wire [31:0]Rs_data1;
    wire [31:0]Rs_data2;
    wire [4:0] IdEx_rs1;
     wire [4:0]IdEx_rs2;
    wire [3:0]IdEx_alu_ctrl;
    wire [31:0]IdEx_imm;
    
    wire [31:0]reg_val_1;
    wire [31:0]reg_val_2;
    wire [31:0]reg_val_3;
    wire [31:0]reg_val_4;
    wire [31:0]reg_val_5;
    wire [31:0]reg_val_6;
    wire [31:0]reg_val_7;
    wire [31:0]reg_val_8;
    wire [31:0]reg_val_9;
    wire [31:0]reg_val_10;
    wire [31:0]reg_val_11;
    wire [31:0]reg_val_12;
    wire [31:0]reg_val_13;
    wire [31:0]reg_val_14;
    wire [31:0]reg_val_15;
    wire [31:0]reg_val_16;
    wire [31:0]reg_val_17;
    wire [31:0]reg_val_18;
    wire [31:0]reg_val_19;
    wire [31:0]reg_val_20;
    wire [31:0]reg_val_21;
    wire [31:0]reg_val_22;
    wire [31:0]reg_val_23;
    wire [31:0]reg_val_24;
    wire [31:0]reg_val_25;
    wire [31:0]reg_val_26;
    wire [31:0]reg_val_27;
    wire [31:0]reg_val_28;
    wire [31:0]reg_val_29;
    wire [31:0]reg_val_30;
    wire [31:0]reg_val_31;
    
    wire IdEx_is_branch;
    wire IdEx_is_jal;
//    wire IdEx_is_jalr;
//    wire IdEx_is_auipc;
//    wire IdEx_is_lui;
//    wire [3:0]IdEx_alu_ctrl;
//    wire IdEx_cmp_ctrl;
    wire [31:0]ExMa_pc;
    wire [31:0]ExMa_inst;
//    wire ExMa_valid;
    wire [4:0]ExMa_rd;
    wire ExMa_reg_wen;
    wire [4:0]MEMWB_rd;
    wire MEMWB_reg_wen;
    wire [31:0]MEMWB_pc;
    wire [31:0]MEMWB_inst;
 IP2CPU_pipcpu U1(
    .clk(clk),
    .rst(rst),
    .Data_in(Cpu_data4bus),
    .inst_IF(spo),
    .PC_out_IF(PC_out_IF),
    .PC_out_ID(PC_out_ID),
    .inst_ID(inst_ID),
    .PC_out_Ex(PC_out_Ex),
    .MemRW_Ex(MemRW_Ex),
    .MemRW_Mem(MemRW_Mem),
    .Addr_out(Addr_out),
    .Data_out(Data_out),
    .Data_out_WB(Data_out_WB),
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
    .reg_val_31(reg_val_31),
    .IdEx_rs1(IdEx_rs1),
    .IdEx_rs2(IdEx_rs2),
    .IdEx_rs1_val(Rs_data1),
    .IdEx_rs2_val(Rs_data2),
    .IdEx_alu_ctrl(IdEx_alu_ctrl),
    .IdEx_imm(IdEx_imm),
    .IdEx_mem_ren(),
    .IdEx_is_branch(IdEx_is_branch),
    .IdEx_is_jal(IdEx_is_jal),
    .IdEx_is_jalr(),
    .IdEx_is_auipc(),
    .IdEx_is_lui(),
    .IdEx_cmp_ctrl(),
    .ExMa_pc(ExMa_pc),
    .ExMa_inst(ExMa_inst),
    .ExMa_valid(),
    .ExMa_rd(ExMa_rd),
    .ExMa_reg_wen(ExMa_reg_wen),
    .MEMWB_rd(MEMWB_rd),
    .MEMWB_reg_wen(MEMWB_reg_wen),
   . MEMWB_pc(MEMWB_pc),
    .MEMWB_inst(MEMWB_inst)
);
initial begin
    clk = 0;
    rst = 1;
    #10
    rst = 0;
    Cpu_data4bus = 32'h80000000;
    spo = 32'h00100093;
    #10;
    spo = 32'h00100113;
    #10;
    spo = 32'h00100193;
    #10;
    spo = 32'h00100213;
    #10;
    spo = 32'h00802283;
    #10;
    spo = 32'h00128333;
    #10;
    spo = 32'h00128333;
    #10;
    spo = 32'h00128333;
    #10;
    spo = 32'h0020C3B3;
    #10;
    spo = 32'h40708433;
    #10;
    spo = 32'h40708433;
    #10;
     spo = 32'h40708433;
    #10;
    Cpu_data4bus = 32'hFFFFFFFF;
    spo = 32'h05C02483;
    #10;
    spo = 32'h00327533;
    #10;
    spo = 32'h00502223;
    #10;
    spo = 32'h005335B3;
    #10;
    spo = 32'h0AA3C613;
    #10;
    spo = 32'h00818663;
    #10;
    spo = 32'h00000013;
    #10;
    spo = 32'h00000033;
    #10; 
    spo = 32'h0012D6B3;
    #10;
     spo = 32'h00147713;
        #10;
         spo = 32'h0034E7B3;
        #10;
         spo = 32'h00A50833;
        #10;
         spo = 32'h0085C8B3;
        #10;
         spo = 32'h00402903;
        #10;
         spo = 32'h004629B3;
        #10;
         spo = 32'h0016DA13;
        #10;
         spo = 32'h00677AB3;
        #10;
        spo = 32'h01071463;
        #10;
         spo = 32'h00000013;
         #10;
         
        spo = 32'h40128B33;
        #10;
        spo = 32'h00150B93;
        #10;
        spo = 32'h00986C33;
        #10;
        spo = 32'h00B9CCB3;
        #10;
        spo = 32'h0FFA7D13;
        #10;
        spo = 32'h00390DB3;
        #10;
        spo = 32'h002A5E33;
        #10;
        spo = 32'h0AF9EE93;
        #10;
        spo = 32'h001A0F33;
        #10;
        spo = 32'h00802F83;
        #10;
        spo = 32'hF6DFF06F;
        #10;
        spo = 32'h00000033;
        #10;
        spo = 32'h00000033;
        #10;
        spo = 32'h00000033;
        #10; 
end

always begin
    clk =clk + 1;
    #5;
end
endmodule
