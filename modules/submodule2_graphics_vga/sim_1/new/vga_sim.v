`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/12 22:36:21
// Design Name: 
// Module Name: vga_sim
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


module vga_sim();
    reg clk_vga;
    reg rst_vga;
    reg [3:0] i_r;
    reg [3:0] i_g;
    reg [3:0] i_b;
    wire [9:0] o_x;
    wire [9:0] o_y;
    wire o_vga_vs;
    wire o_vga_hs;
    wire [3:0]o_vga_r;
    wire [3:0]o_vga_g;
    wire [3:0]o_vga_b;


    vga vga_inst(
       .clk_vga(clk_vga),
       .rst_vga(rst_vga),
       .i_r(i_r),
       .i_g(i_g),
       .i_b(i_b),
       .o_x(o_x),
       .o_y(o_y),
       .o_vga_vs(o_vga_vs),
       .o_vga_hs(o_vga_hs),
       .o_vga_r(o_vga_r),
       .o_vga_g(o_vga_g),
       .o_vga_b(o_vga_b)
    );

    initial begin
        clk_vga = 0;
        forever #1 clk_vga = ~clk_vga;
    end

    initial begin
        rst_vga = 1;
        i_r = 4'b1111;
        i_g = 4'b1111;
        i_b = 4'b1111;
        #100 rst_vga = 0;
    end

endmodule
