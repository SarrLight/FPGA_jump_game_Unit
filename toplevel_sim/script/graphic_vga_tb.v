`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/02 16:30:17
// Design Name: 
// Module Name: graphic_vga_tb
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


module graphic_vga_tb();

    reg clk;
    reg rst;

    //用户输入的按钮，前期可以用开关代替，做好防抖之后再换成按钮
    reg i_bt;

    //vga接口
    wire o_vs;
    wire o_hs;
    wire [3:0] o_r;
    wire [3:0] o_g;
    wire [3:0] o_b;

    //graphics模块的输出的当前读取像素的颜色，输入给vga模块
    wire [3:0] R;
    wire [3:0] G;
    wire [3:0] B;

    //当前读取的x，y坐标，由vga模块输出，输入给graphics模块
    wire [10:0] x_read;
    wire [10:0] y_read;

    //根据当前状态确定是否显示标题和游戏结束画面
    wire title;
    wire gameover;

    graphics graphics_inst(

       .clk(clk),

       //接收来自wechat_jump_fsm的信号
       .i_x_block1(0),
       .i_en_block1(1'b1),
       .i_x_block2(0),
       .i_en_block2(0),
       .i_x_man(11'd0-11'd1),
       //.i_x_man(300),
       .i_y_man(0),
       .i_squeeze_man(0),
       .i_type_block1(0),
       .i_type_block2(0),
       .i_title(0),
       .i_gameover(0),

       //和vga模块的连接
       .i_x_read(x_read),
       .i_y_read(y_read),
       .o_r(R),
       .o_g(G),
       .o_b(B)
    );

    vga vga_inst(
        //接收来自top模块的信号
        .clk_vga(clk),
        .rst_vga(rst),  //同步复位，高有效
        
        //与graphics模块的连接
        .i_r(R),
        .i_g(G),
        .i_b(B),
        .o_x(x_read),
        .o_y(y_read),

        //给top的vga接口信号
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
        #10 rst = 0;
    end

endmodule
