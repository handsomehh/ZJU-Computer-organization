`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/10 13:26:39
// Design Name: 
// Module Name: RV_INT_0
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


module RV_INT_0(
    input clk,
    input reset,
    input INT,
    input ecall,
    input mret,
    input ill_instr,
    input [31:0]pc_next,
    output [31:0]pc
    );
    reg [31:0]mepc;
    reg [31:0]mstatus;
    reg [31:0]pc_out;
    always @(posedge clk)begin
        if(reset)begin
            pc_out = 0;
            mstatus = 32'h0;
            mepc = 0;
        end
        else begin
            if(INT)begin
                mepc = pc_next;
                pc_out = 32'h0c;
                mstatus = 32'h1;
                end
            else if(ecall)begin
                mepc = pc_next;
                pc_out = 32'h08;
                mstatus = 32'h1;
                end
             else if(ill_instr)begin
                mepc = pc_next;
                pc_out = 32'h04;
                mstatus = 32'h1;
                end
             else begin
                if(mret)begin
                    pc_out = mepc;
                    mepc = 0;
                    mstatus = 32'h0;
                end
                else begin
                    pc_out = pc_next;
                end
             end
        end
    end
    assign pc = pc_out;
endmodule
