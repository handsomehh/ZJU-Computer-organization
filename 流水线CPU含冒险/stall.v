`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/31 18:45:11
// Design Name: 
// Module Name: stall
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


module stall(
    input rst_stall,
    input [4:0]Rs1_addr_ID,
    input [4:0]Rs2_addr_ID,
    input RegWrite_out_IDEX,
    input [4:0]Rd_addr_out_IDEX,
    input RegWrite_out_EXMem,
    input [4:0]Rd_addr_out_EXMem,
    //last 2 insts
    input Rs1_used,
    input Rs2_used,
    input Branch_ID,
    input BranchN_ID,
    input Jump_ID,
    input Branch_out_IDEX,
    input BranchN_out_IDEX,
    input Jump_out_IDEX,
    input Branch_out_EXMem,
    input BranchN_out_EXMem,
    input Jump_out_EXMem,
    output en_IF,
    output en_IFID,
    output NOP_IDEX,
    output NOP_IFID
    //last_2_inst
    );
    wire data_stall, control_stall;
    
     assign data_stall =
        (RegWrite_out_EXMem && Rs1_used && (Rs1_addr_ID == Rd_addr_out_EXMem) && (Rs1_addr_ID!=0))||
        (RegWrite_out_EXMem && Rs2_used && (Rs2_addr_ID == Rd_addr_out_EXMem) && (Rs2_addr_ID!=0))||
        (RegWrite_out_IDEX && Rs1_used && (Rs1_addr_ID == Rd_addr_out_IDEX) && (Rs1_addr_ID!=0))||
        (RegWrite_out_IDEX && Rs2_used && (Rs2_addr_ID == Rd_addr_out_IDEX) && (Rs2_addr_ID!=0));
      
      assign control_stall =
            Branch_ID || BranchN_ID || Jump_ID ||
            Branch_out_IDEX || BranchN_out_IDEX || Jump_out_IDEX ||
            Branch_out_EXMem || BranchN_out_EXMem || Jump_out_EXMem ;
            
      assign en_IF = !(data_stall || control_stall);
      assign en_IFID = !(data_stall || control_stall);
      assign NOP_IDEX = data_stall;
      assign NOP_IFID = control_stall;
        
endmodule
