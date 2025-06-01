`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/28 17:08:09
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input rst,

    //用户输入的按钮，前期可以用开关代替，做好防抖之后再换成按钮
    input i_bt,

    //vga接口
    output wire o_vs,
    output wire o_hs,
    output wire [3:0] o_r,
    output wire [3:0] o_g,
    output wire [3:0] o_b

    );


    //分频器的分频结果
    wire [31:0] div_res;
    //小人的x，y坐标
    wire [9:0] x_man;
    wire [9:0] y_man;
    //block1和block2的x坐标
    wire [9:0] x_block1;
    wire [9:0] x_block2;
    //block1和block2的类型，有效范围是0-5
    wire [3:0] type_block1;
    wire [3:0] type_block2;

    wire en_block2;

    //小人的压缩程度，有效范围是0-14 对应压缩0~100%
    wire [3:0] squeeze_man;

    //当前读取的x，y坐标，由vga模块输出，输入给graphics模块
    wire [9:0] x_read;
    wire [9:0] y_read;

    //graphics模块的输出的当前读取像素的颜色，输入给vga模块
    wire [3:0] R;
    wire [3:0] G;
    wire [3:0] B;

    //根据当前状态确定是否显示标题和游戏结束画面
    wire title;
    wire gameover;


    //跳跃结束的信号
    wire jump_done;
    //小人跳跃的高度，有效范围暂不确定
    wire [8:0] jump_height;
    //小人跳跃的距离，有效范围暂不确定
    wire [10:0] jump_dist;
    //小人跳跃的初始速度，有效范围暂不确定
    wire [7:0] jump_v_init; 

    //32位的计数器，作为分频器
    clkdiv clkdiv_inst(
        .clk(clk),
        .rst(rst),
        .div_res(div_res)
    );


    jump jump_inst(
        .en(jump_en),
        .clk_jump(div_res[18]),      //此处分频次数需根据实际情况调大
        .i_v_init(jump_v_init),
        .o_height(jump_height),
        .o_dist(jump_dist),
        .o_done(jump_done)
    );

    wechat_jump_fsm wechat_jump_fsm_inst(  
        //接收来自top的信号
        .clk_machine(div_res[1]),
        .rst_machine(rst),  //异步复位，高有效
        .i_btn(i_bt),

        //输出传递给graphics模块的信号
        .o_x_man(x_man),
        .o_y_man(y_man),
        .o_x_block1(x_block1),
        .o_x_block2(x_block2),
        .o_type_block1(type_block1),
        .o_type_block2(type_block2),
        .o_en_block2(en_block2),
        .o_squeeze_man(squeeze_man),
        .o_title(title),
        .o_gameover(gameover),

        //与jump模块的连接
        .o_jump_en(jump_en),
        .o_jump_v_init(jump_v_init),
        .i_jump_dist(jump_dist),
        .i_jump_height(jump_height),
        .i_jump_done(jump_done)

    );

    graphics graphics_inst(

       .clk(div_res[1]),

       //接收来自wechat_jump_fsm的信号
       .i_x_block1(x_block1),
       .i_en_block1(1'b1),
       .i_x_block2(x_block2),
       .i_en_block2(en_block2),
       .i_x_man(x_man),
       .i_y_man(y_man),
       .i_squeeze_man(squeeze_man),
       .i_type_block1(type_block1),
       .i_type_block2(type_block2),
       .i_title(title),
       .i_gameover(gameover),

       //和vga模块的连接
       .i_x_read(x_read),
       .i_y_read(y_read),
       .o_r(R),
       .o_g(G),
       .o_b(B)
    );

    vga vga_inst(
        //接收来自top模块的信号
        .clk_vga(div_res[1]),
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



endmodule
