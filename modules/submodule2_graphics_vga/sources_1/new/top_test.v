module top_test(
    input clk,
    input [3:0]i_squeeze_man,
    input i_title,
    input i_gameover,
    input [3:0]type_block2,

    input rst,
    input rst_vga,

    output [3:0]o_r,
    output [3:0]o_g,
    output [3:0]o_b,
    output o_vs,
    output o_hs
    );


    wire [9:0]x_read;
    wire [9:0]y_read;
    wire [3:0]R, G, B;
    wire [31:0]div_res;

    clkdiv clkdiv_inst(
       .clk(clk),
       .rst(rst),
       .div_res(div_res)
    );


    graphics graphics_inst(
       .clk(div_res[1]),
       .i_x_block1(10'd0),
       .i_en_block1(1'b1),
       .i_x_block2(10'd15),
       .i_en_block2(1'b1),
       .i_x_man(10'd0),
       .i_y_man(10'd0),
       .i_squeeze_man(i_squeeze_man),
       .i_x_read(x_read),
       .i_y_read(y_read),
       .i_type_block1(4'd0),
       .i_type_block2(type_block2),
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


endmodule