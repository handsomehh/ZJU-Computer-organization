`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 14:55:59
// Design Name: 
// Module Name: my_pipline_Mem
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


module my_pipline_Mem(
    input zero_in_Mem, //zero
    input Branch_in_Mem, //beq
    input BranchN_in_Mem, //bne
    input Jump_in_Mem, //jal
    output PCSrc //PCÑ¡Ôñ¿ØÖÆÊä³ö
);
assign PCSrc = ((Branch_in_Mem&&zero_in_Mem)||(BranchN_in_Mem&&(~zero_in_Mem)))||Jump_in_Mem;
endmodule
