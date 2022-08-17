`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/08 18:50:01
// Design Name: 
// Module Name: soc
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


module soc(

input wire clk_100mhz,
input wire RSTN,
input wire[3:0] BTN_y,
input wire[15:0] SW,
output wire HSYNC,
output wire VSYNC,
output wire[3:0] Red,
output wire[3:0] Green,
output wire[3:0] Blue,
output wire led_clk,
output wire led_sout,
output wire led_clrn,
output wire LED_PEN,
output wire seg_clk,
output wire seg_clrn,
output wire SEG_PEN,
output wire seg_sout
    );
   
wire [3:0] BTN_OK;
wire [15:0] SW_OK;
wire rst;

SAnti_jitter U9(
    .clk(clk_100mhz),
    .RSTN(RSTN),
    .Key_y(BTN_y),
    .SW(SW),
    .BTN_OK(BTN_OK),
    .SW_OK(SW_OK),
    .rst(rst)
);

wire OR_0_res = SW_OK[10] || BTN_OK[10];

wire [31:0]clkdiv;
wire Clk_CPU;

clk_div U8(
    .clk(clk_100mhz),
    .rst(rst),
    .SW2(SW_OK[2]),
    .SW8(SW_OK[8]),
    .STEP(OR_0_res),
    .clkdiv(clkdiv),
    .Clk_CPU(Clk_CPU)
);

wire Clk_CPUn;
assign Clk_CPUn = ~Clk_CPU;

wire counter_we;

wire counter0_OUT;
wire counter1_OUT;
wire counter2_OUT;
wire[31:0] counter_out;
wire[31:0] Peripheral_in;

wire[1:0] counter_set;
Counter_x U10(
    .clk(Clk_CPUn),
    .rst(rst),
    .clk0(clkdiv[6]),
    .clk1(clkdiv[9]),
    .clk2(clkdiv[11]),
    .counter_we(counter_we),
    .counter_val(Peripheral_in),
    .counter_ch(counter_set),
    .counter0_OUT(counter0_OUT),
    .counter1_OUT(counter1_OUT),
    .counter2_OUT(counter2_OUT),
    .counter_out(counter_out)
);

wire MemRW;
wire[31:0] PC_out;
wire[31:0] spo;
wire[31:0] Cpu_data4bus;

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
    wire [31:0]imm;
    wire [31:0]Wt_data;
    wire [31:0]Rs_data1;
    wire [31:0]Rs_data2;
    wire [31:0]b_val;
    wire [3:0]ALU_Control;
    wire [1:0]MemtoReg;
    wire RegWrite;
    
    wire [31:0] PC_out_IF; //È¡Ö¸½×¶ÎPCÊä³ö
    wire [31:0] PC_out_ID; //ÒëÂë½×¶ÎPCÊä³ö
    wire [31:0] inst_ID; //ÒëÂë½×¶ÎÖ¸Áî
    wire [31:0] PC_out_Ex; //Ö´ÐÐ½×¶ÎPCÊä³ö
    wire [31:0] MemRW_Ex; //Ö´ÐÐ½×¶Î´æ´¢Æ÷¶ÁÐ´
    wire [31:0] MemRW_Mem; //·Ã´æ½×¶Î´æ´¢Æ÷¶ÁÐ´
    wire [31:0] Addr_out; //µØÖ·Êä³ö
    wire [31:0] Data_out; //CPUÊý¾ÝÊä³ö
    wire [31:0] Data_out_WB; //Ð´»ØÊý¾ÝÊä³ö
    wire [31:0]IdEx_inst;
    wire IdEx_valid;
    wire [4:0]IdEx_rd;
    wire [4:0]IdEx_rs1;
    wire [4:0]IdEx_rs2;
    wire [31:0]IdEx_rs1_val;
    wire [31:0]IdEx_rs2_val;
    wire IdEx_reg_wen;
    wire IdEx_is_imm;
    wire [31:0]IdEx_imm;
    wire IdEx_mem_ren;
    wire IdEx_is_branch;
    wire IdEx_is_jal;
    wire IdEx_is_jalr;
    wire IdEx_is_auipc;
    wire IdEx_is_lui;
    wire [3:0]IdEx_alu_ctrl;
    wire IdEx_cmp_ctrl;
    wire [31:0]ExMa_pc;
    wire [31:0]ExMa_inst;
    wire ExMa_valid;
    wire [4:0]ExMa_rd;
    wire ExMa_reg_wen;
        wire [4:0]MEMWB_rd;
    wire MEMWB_reg_wen;
    wire [31:0]MEMWB_pc;
    wire [31:0]MEMWB_inst;
IP2CPU_pipcpu U1(
    .clk(Clk_CPU),
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
    //---------------------
//assign IdEx_rd = Rd_addr_out_IDEX;
//assign IdEx_rs1 = inst_out_IDEX[19:15];
//assign IdEx_rs2 = inst_out_IDEX[24:20];
//assign IdEx_rs1_val = Rs1_out_ID;
//assign IdEx_rs2_val = Rs2_out_ID;
//assign IdEx_alu_ctrl = ALU_control_out_IDEX;
//assign IdEx_reg_wen = RegWrite_out_IDEX;
//assign IdEx_is_branch=(Branch_out_IDEX||BranchN_out_IDEX);
//assign IdEx_is_jal=Jump_out_IDEX;
//assign IdEx_imm =Imm_out_IDEX ;
//assign IdEx_inst = inst_out_IDEX;
//assign MemRW_Ex = MemRW_out_IDEX;
//assign PC_out_Ex = real_PC_out_EX;
//assign MemRW_Mem = MemRW_out_EXMem;
//assign ExMa_pc = PC_out_EXMem;
//assign ExMa_rd = Rd_addr_out_EXMem;
//assign ExMa_reg_wen=RegWrite_out_EXMem;
//assign ExMa_inst = Inst_out_EXMEM;
    .IdEx_inst(IdEx_inst),
    .IdEx_valid(),
    .IdEx_rd(IdEx_rd),
    .IdEx_rs1(IdEx_rs1),
    .IdEx_rs2(IdEx_rs2),
    .IdEx_rs1_val(IdEx_rs1_val),
    .IdEx_rs2_val(IdEx_rs2_val),
    .IdEx_reg_wen(IdEx_reg_wen),
    .IdEx_is_imm(),
    .IdEx_imm(IdEx_imm),
    .IdEx_mem_ren(),
    .IdEx_is_branch(IdEx_is_branch),
    .IdEx_is_jal(IdEx_is_jal),
    .IdEx_is_jalr(),
    .IdEx_is_auipc(),
    .IdEx_is_lui(),
    .IdEx_alu_ctrl(IdEx_alu_ctrl),
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
assign PC_out = PC_out_IF;

ROM_D U2(
    .a(PC_out[11:2]),
    .spo(spo)
);

wire[31:0] douta;
wire[31:0] ram_data_in;
wire[9:0] ram_addr;
wire data_ram_we;

RAM_B U3(
    .clka(~clk_100mhz),
    .wea(data_ram_we),
    .addra(ram_addr),
    .dina(ram_data_in),
    .douta(douta)
);

wire GPIOf0000000_we;
wire GPIOe0000000_we;
wire[15:0] LED_out;
MIO_BUS U4(
    .clk(clk_100mhz),
    .rst(rst),
    .BTN(BTN_OK),
    .SW(SW_OK),
    .mem_w(MemRW_Mem),
    .Cpu_data2bus(Data_out),
    .addr_bus(Addr_out),
    .ram_data_out(douta),
    .led_out(LED_out),
    .counter_out(counter_out),
    .counter0_out(counter0_OUT),
    .counter1_out(counter1_OUT),
    .counter2_out(counter2_OUT),
    .Cpu_data4bus(Cpu_data4bus),
    .ram_data_in(ram_data_in),
    .ram_addr(ram_addr),
    .data_ram_we(data_ram_we),
    .GPIOf0000000_we(GPIOf0000000_we),
    .GPIOe0000000_we(GPIOe0000000_we),
    .counter_we(counter_we),
    .Peripheral_in(Peripheral_in)
);

wire[7:0] point_out;
wire[7:0] LE_out;
wire[31:0] Disp_num;

Multi_8CH32(
    .clk(Clk_CPUn),
    .rst(rst),
    .EN(GPIOe0000000_we),
    .Test(SW_OK[7:5]),
    .point_in({clkdiv[31:0],clkdiv[31:0]}),
    .LES(64'b0),
    .Data0(Peripheral_in),
    .data1({2'b0,PC_out[31:2]}),
    .data2(spo),
    .data3(counter_out),
    .data4(Addr_out),
    .data5(Data_out),
    .data6(Cpu_data4bus),
    .data7(PC_out),
    .point_out(point_out),
    .LE_out(LE_out),
    .Disp_num(Disp_num)
);

VGA U11( 
    .clk_25m(clkdiv[1]),
    .clk_100m(clk_100mhz),
    .rst(rst),
    .inst_IF(spo),
    .PC_IF(PC_out_IF),
    .PC_ID(PC_out_ID),
    .inst_ID(inst_ID),
    .PC_Ex(PC_out_Ex),
    .MemRW_Ex(MemRW_Ex),
    .MemRW_Mem(MemRW_Mem),
    .Data_out(Data_out),
    .Addr_out(Addr_out),
    .Data_out_WB(Data_out_WB),
    .hs(HSYNC),
    .vs(VSYNC),
    .vga_r(Red),
    .vga_g(Green),
    .vga_b(Blue),
    //self-define part
    //.imm(imm),
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
    /* .Wt_data(Wt_data),
     .Rs_data1(Rs_data1),
     .Rs_data2(Rs_data2),
     .b_val(b_val),
    .ALU_Control(ALU_Control),
    .MemtoReg(MemtoReg),
    .RegWrite(RegWrite)*/
.IdEx_inst(IdEx_inst),
    .IdEx_valid(),
    .IdEx_rd(IdEx_rd),
    .IdEx_rs1(IdEx_rs1),
    .IdEx_rs2(IdEx_rs2),
    .IdEx_rs1_val(IdEx_rs1_val),
    .IdEx_rs2_val(IdEx_rs2_val),
    .IdEx_reg_wen(IdEx_reg_wen),
    .IdEx_is_imm(),
    .IdEx_imm(IdEx_imm),
    .IdEx_mem_ren(),
    .IdEx_is_branch(IdEx_is_branch),
    .IdEx_is_jal(IdEx_is_jal),
    .IdEx_is_jalr(),
    .IdEx_is_auipc(),
    .IdEx_is_lui(),
    .IdEx_alu_ctrl(IdEx_alu_ctrl),
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

SPIO U7(
    .clk(Clk_CPUn),
    .rst(rst),
    .Start(clkdiv[20]),
    .EN(GPIOf0000000_we),
    .P_Data(Peripheral_in),
    .counter_set(counter_set),
    .LED_out(LED_out),
    .led_clk(led_clk),
    .led_sout(led_sout),
    .led_clrn(led_clrn),
    .LED_PEN(LED_PEN)
);

SSeg7_Dev(
    .clk(clk_100mhz),
    .flash(clkdiv[25]),
    .Hexs(Disp_num),
    .LES(LE_out),
    .point(point_out),
    .rst(rst),
    .Start(clkdiv[20]),
    .SW0(SW_OK[0]),
    .seg_clk(seg_clk),
    .seg_clrn(seg_clrn),
    .SEG_PEN(SEG_PEN),
    .seg_sout(seg_sout)
);
endmodule
