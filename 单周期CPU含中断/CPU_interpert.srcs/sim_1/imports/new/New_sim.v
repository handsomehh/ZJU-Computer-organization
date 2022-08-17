`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/28 16:26:41
// Design Name: 
// Module Name: New_sim
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


module New_sim(
    );
reg Clk_CPU;
reg rst;
reg [31:0]Cpu_data4bus;
reg [31:0]inst_in;
wire [31:0]PC_out;
reg INT0;
wire [31:0]reg_val_13;
    wire [31:0]reg_val_14;
    wire [31:0]reg_val_15;
    wire [31:0]imm;
    wire [31:0]Wt_data;
    wire [31:0]Rs_data1;
    wire [31:0]Rs_data2;
    wire [31:0]b_val;
    wire [3:0]ALU_Control;
    wire [1:0]MemtoReg;
    wire RegWrite;
    wire MemRW;
    wire [31:0]Addr_out;
    wire [31:0]Data_out;
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
IP2CPU U0(
    .clk(Clk_CPU),
    .rst(rst),
    .Data_in(Cpu_data4bus),
    .inst_in(inst_in),
    .MIO_ready(),
    .CPU_MIO(),
    .INT0(INT0),
    .MemRW(MemRW),
    .imm(imm),
    .Addr_out(Addr_out),
    .Data_out(Data_out),
    .PC_out(PC_out),
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
    .Wt_data(Wt_data),
    .Rs_data1(Rs_data1),
    .Rs_data2(Rs_data2),
    .b_val(b_val),
    .ALU_Control(ALU_Control),
    .MemtoReg(MemtoReg),
    .RegWrite(RegWrite)
);
initial begin
    Cpu_data4bus = 32'h80000000;
    Clk_CPU=0;
    rst = 1;
    INT0 = 0;
    #20
    rst = 0;
    Cpu_data4bus = 32'h80000000;
    inst_in=32'h0200006f;//main
    #20;
    inst_in=32'h00007293;//andi
    #20;
    inst_in=32'h00007313;//andi
    #20;
    inst_in=32'h88888137; //lui
    #20;
    inst_in=32'hffffffff;//illegal
    #20
     inst_in=32'h0C40006F;//ill_init
     #20
     inst_in=32'h00168693;//addi
     #20
    inst_in=32'h00168693;//addi
    #20
     inst_in=32'h30200073;//mret
     #20
     inst_in=32'h00832183;//lw
    #20;
     inst_in=32'h00000073;//ecall
    #20;
     inst_in=32'h0D80006F;//jal
    #20;
    inst_in=32'h00128793;//jal
    #20;
     inst_in=32'h00178793;//addi x15
     #20;
     inst_in=32'h30200073;//mret
     #20;
     inst_in=32'h0032A223;//sw
     #20;
     INT0 = 1;
     inst_in=32'h0C80006F;
     #1;
     INT0 = 0;
     inst_in=32'h0C80006F;
     #19;
      inst_in=32'h00168693;
      #20;
      inst_in=32'h00168693;
      #20;
      inst_in=32'h00168693;
      #20;
      inst_in=32'h30200073;
      #20;
      inst_in=32'h01C02383;
      #20;
end
    always begin
    #10;
    Clk_CPU = Clk_CPU+1;   
    end
    always begin
    #65;
    INT0 = 1;
    #10;
    INT0 = 0;
    #1000;
    end
endmodule

