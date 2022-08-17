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
    input [31:0]D, //PC_next
    input INT,
    input ecall,
    input mret,
    input ill_instr,
    output [31:0]Q,
    output [31:0]mepc_res
    );
    reg [31:0]mtvec_int = 4'h000c;
    reg [31:0]mtvec_ecall = 4'h0008;
    reg [31:0]mtvec_ill_instr = 4'h0004;
    
    reg [31:0]mepc;
    assign mepc_res = mepc;
    reg begin_int, last_int=0;
    reg[31:0] res;
    reg [31:0]metvc;
    always @(posedge clk or posedge rst)begin
        if(INT != last_int)
        begin
            begin_int = INT;
            last_int = INT;
        end
        if(rst == 1)
        begin
            res = 0;
            mepc <= 0;
        end
        else if(rst == 0 && CE == 1)
        begin
            if(begin_int||ecall||ill_instr)
            begin
                mepc = D;
                if(begin_int)
                res = mtvec_int;
                else if(ecall)
                res = mtvec_ecall;
                else if(ill_instr)
                res = mtvec_ill_instr;
            end
            else if(mret)
            begin
                res = mepc;
                mepc = 0;
            end
            else
            res = D;
        end
        begin_int = 0; 
    end
    assign Q = res;
endmodule
