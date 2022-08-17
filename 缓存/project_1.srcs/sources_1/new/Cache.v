`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/06 18:55:32
// Design Name: 
// Module Name: Cache
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


module Cache(
    input wire clk, // clock
    input wire rst, // reset
    input wire [31:0] data_cpu_write, // data write in
    input wire [31:0] data_mem_read, // data read in
    input wire [31:0] addr_cpu, // cpu addr
    input wire wr_cpu, // cpu write enable
    input wire rd_cpu, // cpu read enable
    input wire ready_mem, // memory ready
    output reg wr_mem, // memory write enable
    output reg rd_mem, // memory read enable
    output reg [31:0] data_mem_write, // data to mem
    output reg [31:0] data_cpu_read, // data to cpu
    output reg [31:0] addr_mem // memory addr
);
parameter Block_width = 128,IDLE = 0,CTAG = 1,ALL = 2,WB = 3;
parameter NUM_of_sets = 128;
parameter TAG_width = 23,V = 1,U = 1,D = 1;
reg [Block_width-1:0] cache_data_0 [0:NUM_of_sets-1];
reg [Block_width-1:0] cache_data_1 [0:NUM_of_sets-1];
reg [TAG_width+V+U+D-1:0] cache_TAG_0 [0:NUM_of_sets-1];
reg [TAG_width+V+U+D-1:0] cache_TAG_1 [0:NUM_of_sets-1];
reg [1:0] state;
reg [1:0]next_state;
wire [7:0]index;
assign index = addr_cpu[8:2];
wire[7:0]index_high;
wire[7:0]index_low;
assign index_high = ((addr_cpu[1:0]== 2'b00)?31:
                        (addr_cpu[1:0]== 2'b01)?63:
                          (addr_cpu[1:0]== 2'b10)?95:127);
assign index_low = ((addr_cpu[1:0]== 2'b00)?0:
                        (addr_cpu[1:0]== 2'b01)?32:
                          (addr_cpu[1:0]== 2'b10)?64:96);
integer i;
wire cpu_req_valid;
wire hit,hit_0,hit_1,old_is_clean,will_be_replace;
assign cpu_req_valid = wr_cpu || rd_cpu;
assign hit_0 = ((addr_cpu[31:9]==cache_TAG_0[addr_cpu[8:2]][TAG_width-1:0])&&(cache_TAG_0[addr_cpu[8:2]][TAG_width+V+U+D-1]==1'b1));
assign hit_1 = ((addr_cpu[31:9]==cache_TAG_1[addr_cpu[8:2]][TAG_width-1:0])&&(cache_TAG_1[addr_cpu[8:2]][TAG_width+V+U+D-1]==1'b1));
assign hit = hit_0||hit_1;
wire is_clean_1,is_clean_0;
assign is_clean_0 = (cache_TAG_0[addr_cpu[8:2]][TAG_width+D-1]==1'b0);
assign is_clean_1 = (cache_TAG_1[addr_cpu[8:2]][TAG_width+D-1]==1'b0);
assign old_is_clean = is_clean_0||is_clean_1;
assign will_be_replace =1 ;
reg [1:0] count;
reg [31:0]add_res;
initial begin
    $readmemh("D://c_0.txt", cache_data_0);
    $readmemh("D://c_1.txt", cache_data_1);
    $readmemb("D://t_0.txt", cache_TAG_0);
    $readmemb("D://t_1.txt", cache_TAG_1);
end
always@(posedge clk or posedge rst)begin
    if(rst)begin
    state=IDLE;
    data_mem_write = 0;
    data_cpu_read = 0;
    end
    else begin
    state=next_state;
    end
    case(state)
    IDLE:if(cpu_req_valid)
       next_state = CTAG;
    else
        next_state=IDLE;
    CTAG: if(hit) //»Ùhit
        next_state = IDLE;
    else if(old_is_clean)begin
        next_state = ALL;
    end
    else 
        next_state = WB;
    ALL:
        if(ready_mem)begin
        next_state=CTAG;
        wr_mem = 0;
        rd_mem = 1;
        end
    else begin
        next_state = ALL;
        wr_mem = 0;
        rd_mem = 1;
        end
    WB:if(ready_mem)begin
        next_state = ALL;
        wr_mem = 1;
        rd_mem = 0;
       end
       else begin
       next_state = WB; 
       wr_mem = 1;
        rd_mem = 0;
        end
    default:next_state=IDLE;
    endcase
end
//always@(posedge clk)begin
//    case(state)
//    IDLE:if(cpu_req_valid)
//       next_state = CTAG;
//    else
//        next_state=IDLE;
//    CTAG: if(hit) //»Ùhit
//        next_state = IDLE;
//    else if(old_is_clean)begin
//        next_state = ALL;
//    end
//    else 
//        next_state = WB;
//    ALL:
//        if(ready_mem)begin
//        next_state=CTAG;
//        wr_mem = 0;
//        rd_mem = 1;
//        end
//    else begin
//        next_state = ALL;
//        wr_mem = 0;
//        rd_mem = 1;
//        end
//    WB:if(ready_mem)begin
//        next_state = ALL;
//        wr_mem = 1;
//        rd_mem = 0;
//       end
//       else begin
//       next_state = WB; 
//       wr_mem = 1;
//        rd_mem = 0;
//        end
//    default:next_state=IDLE;
//    endcase
//end

always @(posedge clk)begin
    if(rst)begin
        for(i=0;i<NUM_of_sets;i=i+1)begin
//           cache_data_0[i] = 0;
//           cache_data_1[i] = 0;
//           cache_TAG_0[i] = 0;
//           cache_TAG_1[i] = 0;
        end
    end
    else begin
        if(state == IDLE)begin
            
        end
        else if(state == CTAG)begin
            if(hit && next_state ==IDLE)begin
             wr_mem = 0;
             rd_mem = 0;
                if(rd_cpu)begin
                    if(hit_1)begin
                        if(addr_cpu[1:0]== 2'b00)data_cpu_read = cache_data_1[addr_cpu[8:2]][31:0];
                        if(addr_cpu[1:0]== 2'b01)data_cpu_read = cache_data_1[addr_cpu[8:2]][63:32];
                        if(addr_cpu[1:0]== 2'b10)data_cpu_read = cache_data_1[addr_cpu[8:2]][95:64];
                        if(addr_cpu[1:0]== 2'b11)data_cpu_read = cache_data_1[addr_cpu[8:2]][127:96];
//                        data_cpu_read = cache_data_1[addr_cpu[8:2]][index_high:index_low];
                        cache_TAG_1[addr_cpu[8:2]][TAG_width+U+D-1] = 1;
                        cache_TAG_0[addr_cpu[8:2]][TAG_width+U+D-1] = 0;
                    end else begin
                        if(addr_cpu[1:0]== 2'b00)data_cpu_read = cache_data_0[addr_cpu[8:2]][31:0];
                        if(addr_cpu[1:0]== 2'b01)data_cpu_read = cache_data_0[addr_cpu[8:2]][63:32];
                        if(addr_cpu[1:0]== 2'b10)data_cpu_read = cache_data_0[addr_cpu[8:2]][95:64];
                        if(addr_cpu[1:0]== 2'b11)data_cpu_read = cache_data_0[addr_cpu[8:2]][127:96];
//                        data_cpu_read = cache_data_0[addr_cpu[8:2]][index_high:index_low];
                        cache_TAG_1[addr_cpu[8:2]][TAG_width+U+D-1] = 0;
                        cache_TAG_0[addr_cpu[8:2]][TAG_width+U+D-1] = 1;
                    end
                end
                else if(wr_cpu)begin
                    if(hit_1)begin
                        if(addr_cpu[1:0]== 2'b00)cache_data_1[addr_cpu[8:2]][31:0] = data_cpu_write;
                        if(addr_cpu[1:0]== 2'b01) cache_data_1[addr_cpu[8:2]][63:32] = data_cpu_write;
                        if(addr_cpu[1:0]== 2'b10)cache_data_1[addr_cpu[8:2]][95:64] = data_cpu_write;
                        if(addr_cpu[1:0]== 2'b11)cache_data_1[addr_cpu[8:2]][127:96] = data_cpu_write;
//                        cache_data_1[addr_cpu[8:2]][index_high:index_low] = data_cpu_write;
                        cache_TAG_1[addr_cpu[8:2]][TAG_width+V+U+D-1] = 1;
                        cache_TAG_1[addr_cpu[8:2]][TAG_width+U+D-1] = 1;
                        cache_TAG_1[addr_cpu[8:2]][TAG_width+D-1] = 1;
                        cache_TAG_0[addr_cpu[8:2]][TAG_width+U+D-1] = 0;
                     end
                     else begin
                        if(addr_cpu[1:0]== 2'b00)cache_data_0[addr_cpu[8:2]][31:0] = data_cpu_write;
                        if(addr_cpu[1:0]== 2'b01) cache_data_0[addr_cpu[8:2]][63:32] = data_cpu_write;
                        if(addr_cpu[1:0]== 2'b10)cache_data_0[addr_cpu[8:2]][95:64] = data_cpu_write;
                        if(addr_cpu[1:0]== 2'b11)cache_data_0[addr_cpu[8:2]][127:96] = data_cpu_write;
//                        cache_data_0[addr_cpu[8:2]][index_high:index_low] = data_cpu_write;
                        cache_TAG_0[addr_cpu[8:2]][TAG_width+V+U+D-1] = 1;
                        cache_TAG_0[addr_cpu[8:2]][TAG_width+U+D-1] = 1;
                        cache_TAG_0[addr_cpu[8:2]][TAG_width+D-1] = 1;
                        cache_TAG_1[addr_cpu[8:2]][TAG_width+U+D-1] = 0;
                     end
                end
            end//if(hit)
            else begin
                if(old_is_clean)begin
                    addr_mem = {addr_cpu[31:2],2'b0};
                    wr_mem = 0;
                    rd_mem = 1;
                    count = 0;
                end
                else begin
                    wr_mem = 1;
                    rd_mem = 0;
                    count = 0;
                end
            end 
        end//if(CTAG)
        else if(state == ALL)begin
           if(is_clean_0)begin
               if(count==0)begin cache_data_0[index][31:0] = data_mem_read;addr_mem = {addr_cpu[31:2],2'b1};count = count+1;end
               else if(count==1)begin cache_data_0[index][63:32] = data_mem_read;addr_mem = {addr_cpu[31:2],2'b10};count = count+1;end
               else if(count==2)begin cache_data_0[index][95:64] = data_mem_read;addr_mem = {addr_cpu[31:2],2'b11};count = count+1;end
               else if(count==3)begin cache_data_0[index][127:96] = data_mem_read;count = count+1;end
               cache_TAG_0[index][TAG_width+V+U+D-1] = 1;
               cache_TAG_0[index][TAG_width+V+U-1] = 1;
               cache_TAG_1[index][TAG_width+V+U-1] = 0;
               cache_TAG_0[index][TAG_width+D-1] = 0;
               cache_TAG_0[index][TAG_width-1:0] = addr_cpu[31:9];
           end
           else if(is_clean_1)begin
               if(count==0)begin cache_data_1[index][31:0] = data_mem_read;addr_mem = {addr_cpu[31:2],2'b1};count = count+1;end
               if(count==1)begin cache_data_1[index][63:32] = data_mem_read;addr_mem = {addr_cpu[31:2],2'b10};count = count+1;end
               if(count==2)begin cache_data_1[index][95:64] = data_mem_read;addr_mem = {addr_cpu[31:2],2'b11};count = count+1;end
               if(count==3)begin cache_data_1[index][127:96] = data_mem_read;count = count+1;rd_mem = 0;end
               cache_TAG_1[index][TAG_width+V+U+D-1] = 1;
               cache_TAG_1[index][TAG_width+V+U-1] = 1;
               cache_TAG_0[index][TAG_width+V+U-1] = 0;
               cache_TAG_1[index][TAG_width+D-1] = 0;
               cache_TAG_1[index][TAG_width-1:0] = addr_cpu[31:9];
           end
        end//if(state = ALL)
        else if(state == WB)begin
            if(cache_TAG_1[index][TAG_width+V+U-1]==0 && cache_TAG_1[index][TAG_width+V+U-1]==0)begin//ªª0
                if(count==0)begin data_mem_write = cache_data_1[index][31:0];addr_mem = {cache_TAG_1[index][TAG_width-1:0],index,2'b00};count = count+1;end
                else if(count==1)begin data_mem_write = cache_data_1[index][63:32];addr_mem = {cache_TAG_1[index][TAG_width-1:0],index,2'b01};count = count+1;end
                else if(count==2)begin data_mem_write = cache_data_1[index][95:64];addr_mem = {cache_TAG_1[index][TAG_width-1:0],index,2'b10};count = count+1;end
                else if(count==3)begin data_mem_write = cache_data_1[index][127:96];addr_mem = {cache_TAG_1[index][TAG_width-1:0],index,2'b11};count = count+1;
//                    cache_TAG_1[index][TAG_width+V+U-1] = 1;
//                    cache_TAG_0[index][TAG_width+V+U-1] = 0;
                    cache_TAG_1[index][TAG_width+D-1] = 0;
                end
            end
            else begin
                if(count==0)begin data_mem_write = cache_data_0[index][31:0];addr_mem = {cache_TAG_1[index][TAG_width-1:0],index,2'b00};count = count+1;end
                else if(count==1)begin data_mem_write = cache_data_0[index][63:32];addr_mem = {cache_TAG_1[index][TAG_width-1:0],index,2'b01};count = count+1;end
                else if(count==2)begin data_mem_write = cache_data_0[index][95:64];addr_mem = {cache_TAG_1[index][TAG_width-1:0],index,2'b10};count = count+1;end
                else if(count==3)begin data_mem_write = cache_data_0[index][127:96];addr_mem = {cache_TAG_1[index][TAG_width-1:0],index,2'b11};count = count+1;
//                     cache_TAG_1[index][TAG_width+V+U-1] = 1;
//                     cache_TAG_0[index][TAG_width+V+U-1] = 0;
                     cache_TAG_0[index][TAG_width+D-1] = 0;
                end
            end
        end
    end
end

endmodule