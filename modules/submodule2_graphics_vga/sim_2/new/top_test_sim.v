`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/12 23:17:20
// Design Name: 
// Module Name: top_test_sim
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


module top_test_sim();
    reg clk;

    reg rst_vga;

    reg i_en_block1;
    reg i_en_block2;
    reg [3:0]i_squeeze_man;
    reg i_title;
    reg i_gameover;

    wire [3:0]o_r;
    wire [3:0]o_g;
    wire [3:0]o_b;
    wire o_vs;
    wire o_hs;

    wire [9:0]x_read;
    wire [9:0]y_read;
    wire [3:0]R, G, B;
    
    wire [31:0]div_res;
    reg rst;

    wire [11:0]o_dout_ani_jump_0_14;
    wire [11:0]o_dout_img_block1;
    wire [11:0]o_dout_img_block2;

    clkdiv clkdiv_inst(
       .clk(clk),
       .rst(rst),
       .div_res(div_res)
    );

    graphics graphics_inst(
       .clk(clk),
       .i_x_block1(10'd0),
       .i_en_block1(i_en_block1),
       .i_x_block2(10'd10),
       .i_en_block2(i_en_block2),
       .i_x_man(10'd0),
       .i_y_man(10'd0),
       .i_squeeze_man(i_squeeze_man),
       .i_x_read(x_read),
       .i_y_read(y_read),
       .i_type_block1(4'd0),
       .i_type_block2(4'd0),
       .i_title(i_title),
       .i_gameover(i_gameover),
       .o_r(R),
       .o_g(G),
       .o_b(B)
    );

    vga vga_inst(
        .clk_vga(div_res[1]),
        .rst_vga(rst_vga),
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
        forever #1 clk = ~clk;
    end

    initial begin
        i_en_block1 = 1;
        i_en_block2 = 1;
        i_squeeze_man = 0;
        i_title = 1;
        
        i_gameover = 0;

        rst = 1;
        rst_vga = 1;
        #2;
        rst = 0;
        #50;
        rst_vga = 0;

    end
    

endmodule
