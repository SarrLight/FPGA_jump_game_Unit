`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/13 11:35:58
// Design Name: 
// Module Name: vga_tb
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


module vga_tb();

    reg clk;
    reg rst;
    reg [3:0] R;
    reg [3:0] G;
    reg [3:0] B;
    wire o_vs;
    wire o_hs;
    wire [3:0] o_r;
    wire [3:0] o_g;
    wire [3:0] o_b;
    wire [10:0] x_read;
    wire [10:0] y_read;

    vga vga_inst(
        .clk_vga(clk),
        .rst_vga(rst),  //同步复位，高有效
        
        
        .i_r(R),
        .i_g(G),
        .i_b(B),
        .o_x(x_read),
        .o_y(y_read),

        .o_vga_vs(o_vs),
        .o_vga_hs(o_hs),
        .o_vga_r(o_r),
        .o_vga_g(o_g),
        .o_vga_b(o_b)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        rst = 1;
        R = 4'b1111;
        G = 4'b1111;
        B = 4'b1111;
        #10 rst = 0;

    end

endmodule
