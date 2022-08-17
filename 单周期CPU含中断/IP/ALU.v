`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/01 19:03:28
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALU_operation,
    output reg [31:0] res,
    output  zero
    );
reg [31:0] temp_2;
wire Co = ALU_operation[2:2];
reg [31:0] temp ;
reg [32:0] result;
always @(*)
    begin
    temp = B ^{32{Co}};
    result = {1'b0,A} + {Co^1'b0,temp} + Co;
        case(ALU_operation)
        4'b0000: res = A & B;
        4'b0001: res = A | B;
        4'b1100: res = A ^ B;
        4'b0100: res = ~(A | B);
        4'b0010: begin
            res = result;
            end
        4'b0110: begin
            res = result;
            end
        4'b0111:begin
            res = $signed(A)<$signed(B) ;
            end
        4'b1101:res = A >> B[4:0];
        4'b1110:res = A << B[4:0];
        4'b1001:res = A<B;
        4'b1111:res = A >>> B[4:0];        
        endcase;
     end
     assign zero = ~( | res);
endmodule
