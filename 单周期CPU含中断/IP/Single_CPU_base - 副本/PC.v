`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/12 19:47:29
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input rst,
    input CE,
    input [31:0]D,
    output [31:0]Q
    );
    reg[31:0] res;
    always @(posedge clk or posedge rst)begin
        if(rst == 1)res=0;
        else if(rst == 0 && CE == 1)res = D;
    end
    assign Q = res;
endmodule
