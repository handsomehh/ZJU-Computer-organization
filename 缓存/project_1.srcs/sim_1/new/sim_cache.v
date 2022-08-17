`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/06 22:07:14
// Design Name: 
// Module Name: sim_cache
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


module sim_cache(
    );
    reg clk; // clock
    reg rst; // reset
    reg [31:0] data_cpu_write; // data write in
    reg [31:0] data_mem_read; // data read in
    reg [31:0] addr_cpu; // cpu addr
    reg wr_cpu; // cpu write enable
    reg rd_cpu; // cpu read enable
    reg ready_mem; // memory ready
    wire wr_mem; // memory write enable
    wire rd_mem; // memory read enable
    wire [31:0] data_mem_write; // data to mem
    wire [31:0] data_cpu_read; // data to cpu
    wire [31:0] addr_mem; // memory addr
 Cache ch(
        .clk(clk), // clock
        .rst(rst), // reset
        .data_cpu_write(data_cpu_write), // data write in
        .data_mem_read(data_mem_read), // data read in
        .addr_cpu(addr_cpu), // cpu addr
        .wr_cpu(wr_cpu), // cpu write enable
        .rd_cpu(rd_cpu), // cpu read enable
        .ready_mem(ready_mem), // memory ready
        .wr_mem(wr_mem), // memory write 
         .rd_mem(rd_mem), // memory read 
         .data_mem_write(data_mem_write), // data to mem
        .data_cpu_read(data_cpu_read), // data to cpu
        .addr_mem (addr_mem )// memory addr
);
always begin
clk = clk+1;
#10;
end
initial begin
rst = 1;
clk = 0;
ready_mem = 0;
data_cpu_write = 0;
#20;
rst = 0;
#20;
addr_cpu = 32'b0111_1001_1100_1110_0100_0010_0000_0000;//read hit
wr_cpu = 0;
rd_cpu = 1;
data_mem_read = 32'h87654321;
#60;
addr_cpu = 32'b0111_1001_1100_1110_0100_0010_0000_0001;//write hit
wr_cpu = 1;
rd_cpu = 0;
data_mem_read = 32'h87654321;
data_cpu_write = 32'h11111111;
#40;
addr_cpu = 32'b0111_1001_1100_1110_0100_0010_0000_0100;//read miss but clean
wr_cpu = 0;
rd_cpu = 1;
#80;
ready_mem = 1;
#40;
ready_mem = 0;
addr_cpu = 32'b0111_1001_1100_1110_0100_0010_0000_1000;//write miss but clean
wr_cpu = 1;
rd_cpu = 0;
data_cpu_write = 32'h22222222;
data_mem_read = 32'h66666666;
#100;
ready_mem = 1;
#40;
wr_cpu = 0;
rd_cpu = 0;
ready_mem = 0;
#40;

addr_cpu = 32'b1010_1101_1111_1001_1011_1010_0000_0000;//write hit
wr_cpu = 1;
rd_cpu = 0;
data_mem_read = 32'h87654321;
data_cpu_write = 32'h33333333;
#60;
data_mem_read = 32'hffffffff;
addr_cpu = 32'b0000_0000_0000_0000_0000_0010_0000_0000;
wr_cpu = 0;
rd_cpu = 1;
#80;
ready_mem = 1;
#20;
ready_mem = 0;
#100;
ready_mem = 1;

end
endmodule
//0111 1001 1100 1110 0100 0010 0000 00
