`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/01 20:37:41
// Design Name: 
// Module Name: RegFile
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


module RegFile( input clk, rst, RegWrite,
    input[4:0]Rs1_addr,Rs2_addr,Wt_addr,
    input [31:0]Wt_data,
    output [31:0]Rs1_data,Rs2_data,
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
    output [31:0]reg_val_31
    );
    
    reg [31:0] register [1:31];
    integer i;
    assign Rs1_data=(Rs1_addr== 0)?0:register[Rs1_addr];
    assign Rs2_data = (Rs2_addr== 0) ? 0 : register[Rs2_addr];
    always @(posedge clk or posedge rst)
    begin if (rst==1) for (i=1; i<32; i=i+1)register[i]<= 0;
    else if((Wt_addr!= 0)&&(RegWrite == 1))
    register[Wt_addr] <= Wt_data;
end
assign reg_val_1 = register[1];
assign reg_val_2 = register[2];
assign reg_val_3 = register[3];
assign reg_val_4 = register[4];
assign reg_val_5 = register[5];
assign reg_val_6 = register[6];
assign reg_val_7 = register[7];
assign reg_val_8 = register[8];
assign reg_val_9 = register[9];
assign reg_val_10 = register[10];
assign reg_val_11 = register[11];
assign reg_val_12 = register[12];
assign reg_val_13 = register[13];
assign reg_val_14 = register[14];
assign reg_val_15 = register[15];
assign reg_val_16 = register[16];
assign reg_val_17 = register[17];
assign reg_val_18 = register[18];
assign reg_val_19 = register[19];
assign reg_val_20 = register[20];
assign reg_val_21 = register[21];
assign reg_val_22 = register[22];
assign reg_val_23 = register[23];
assign reg_val_24 = register[24];
assign reg_val_25= register[25];
assign reg_val_26 = register[26];
assign reg_val_27= register[27];
assign reg_val_28 = register[28];
assign reg_val_29 = register[29];
assign reg_val_30 = register[30];
assign reg_val_31 = register[31];
endmodule
