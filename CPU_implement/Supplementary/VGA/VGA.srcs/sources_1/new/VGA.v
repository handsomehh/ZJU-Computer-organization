`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/02/20 18:40:52
// Design Name: 
// Module Name: VGA
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


module VGA(
    input wire clk_25m,
    input wire clk_100m,
    input wire rst,
    input wire [31:0] pc,
    input wire [31:0] inst,
    input wire [31:0] alu_res,
    input wire mem_wen,
    input wire [31:0] dmem_o_data,
    input wire [31:0] dmem_i_data,
    input wire [31:0] dmem_addr,
    input [31:0] imm,
    output wire hs,
    output wire vs,
    output wire [3:0] vga_r,
    output wire [3:0] vga_g,
    output wire [3:0] vga_b,
    input [31:0]reg_val_1,
    input [31:0]reg_val_2,
    input [31:0]reg_val_3,
    input [31:0]reg_val_4,
    input [31:0]reg_val_5,
    input [31:0]reg_val_6,
    input [31:0]reg_val_7,
    input [31:0]reg_val_8,
    input [31:0]reg_val_9,
    input [31:0]reg_val_10,
    input [31:0]reg_val_11,
    input [31:0]reg_val_12,
    input [31:0]reg_val_13,
    input [31:0]reg_val_14,
    input [31:0]reg_val_15,
    input [31:0]reg_val_16,
    input [31:0]reg_val_17,
    input [31:0]reg_val_18,
    input [31:0]reg_val_19,
    input [31:0]reg_val_20,
    input [31:0]reg_val_21,
    input [31:0]reg_val_22,
    input [31:0]reg_val_23,
    input [31:0]reg_val_24,
    input [31:0]reg_val_25,
    input [31:0]reg_val_26,
    input [31:0]reg_val_27,
    input [31:0]reg_val_28,
    input [31:0]reg_val_29,
    input [31:0]reg_val_30,
    input [31:0]reg_val_31,
    input [31:0]Rs_data1,
    input [31:0]Rs_data2,
    input [31:0]Wt_data,
    input [31:0]inst_field,
    input [31:0]b_val,
    input [3:0]ALU_Control,
    input [1:0]MemtoReg,
    input RegWrite
    );
    wire [9:0] vga_x;
    wire [8:0] vga_y;
    wire video_on;
    VgaController vga_controller(
           .clk          (clk_25m      ),
           .rst          (rst          ),
           .vga_x        (vga_x        ),
           .vga_y        (vga_y        ),
           .hs           (hs           ),
           .vs           (vs           ),
           .video_on     (video_on     )
      );
 wire display_wen;
 wire [11:0] display_w_addr;
 wire [7:0] display_w_data;
 VgaDisplay vga_display(
          .clk          (clk_100m      ),
          .video_on     (video_on      ),
          .vga_x        (vga_x         ),
          .vga_y        (vga_y         ),
          .vga_r        (vga_r         ),
          .vga_g        (vga_g         ),
          .vga_b        (vga_b         ),
          .wen          (display_wen   ),
          .w_addr       (display_w_addr),
          .w_data       (display_w_data)
      );
 VgaDebugger vga_debugger(
         .clk           (clk_100m      ),
         .display_wen   (display_wen   ),
         .display_w_addr(display_w_addr),
         .display_w_data(display_w_data),
         .pc            (pc             ),
         .inst          (inst           ),
         .rs1           (inst_field[19:15]               ),
         .rs1_val       ( Rs_data1              ),
         .rs2           (inst_field[24:20]               ),
         .rs2_val       (Rs_data2               ),
         .rd            (inst_field[11:7]               ),
         .reg_i_data    (Wt_data               ),
         .reg_wen       (               ),
         .is_imm        (               ),
         .is_auipc      (               ),
         .is_lui        (RegWrite               ),
         .imm           (imm              ),
         .a_val         (Rs_data1               ),
         .b_val         (b_val               ),
         .alu_ctrl      (ALU_Control               ),
         .cmp_ctrl      (MemtoReg               ),
         .alu_res       (alu_res        ),
         .cmp_res       (               ),
         .is_branch     (               ),
         .is_jal        (               ),
         .is_jalr       (               ),
         .do_branch     (               ),
         .pc_branch     (               ),
         .mem_wen       (mem_wen        ),
         .mem_ren       (               ),
         .dmem_o_data   (dmem_o_data    ),
         .dmem_i_data   (dmem_i_data    ),
         .dmem_addr     (dmem_addr      ),
         .csr_wen       (               ),
         .csr_ind       (               ),
         .csr_ctrl      (               ),
         .csr_r_data    (               ),
         .x0            (               ),
         .ra            (reg_val_1               ),
         .sp            (reg_val_2               ),
         .gp            (reg_val_3               ),
         .tp            (reg_val_4               ),
         .t0            (reg_val_5               ),
         .t1            (reg_val_6               ),
         .t2            (reg_val_7               ),
         .s0            (reg_val_8               ),
         .s1            (reg_val_9               ),
         .a0            (reg_val_10               ),
         .a1            (reg_val_11               ),
         .a2            (reg_val_12               ),
         .a3            (reg_val_13               ),
         .a4            (reg_val_14               ),
         .a5            (reg_val_15               ),
         .a6            (reg_val_16               ),
         .a7            (reg_val_17              ),
         .s2            (reg_val_18               ),
         .s3            (reg_val_19               ),
         .s4            (reg_val_20               ),
         .s5            (reg_val_21               ),
         .s6            (reg_val_22               ),
         .s7            (reg_val_23               ),
         .s8            (reg_val_24               ),
         .s9            (reg_val_25               ),
         .s10           (reg_val_26               ),
         .s11           (reg_val_27               ),
         .t3            (reg_val_28               ),
         .t4            (reg_val_29               ),
         .t5            (reg_val_30               ),
         .t6            (reg_val_31               ),
         .mstatus_o     (               ),
         .mcause_o      (               ),
         .mepc_o        (               ),
         .mtval_o       (               ),
         .mtvec_o       (               ),
         .mie_o         (               ),
         .mip_o         (               )
     );
endmodule
