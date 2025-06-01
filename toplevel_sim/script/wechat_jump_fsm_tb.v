`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/31 23:36:46
// Design Name: 
// Module Name: wechat_jump_fsm_tb
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


module wechat_jump_fsm_tb( );
    
    /*
    module wechat_jump_fsm (
    // 基础控制信号
    input  wire        clk_machine,    // 主时钟 (25.175MHz)
    input  wire        rst_machine,    // 异步复位 (高有效)
    input  wire        i_btn,          // 玩家按键输入

    //与jump模块的连接
    input  wire        i_jump_done,    // 物理引擎跳跃完成信号
    input  wire [10:0] i_jump_dist,
    input  wire [8:0] i_jump_height,
    output wire  [10:0]  o_jump_v_init,  // 跳跃初速度
    output reg         o_jump_en,       // 物理引擎使能
    
    
    // 状态输出
    output reg  [2:0]  state,          // 当前状态码
    
    // 输出传递给graphics模块的信号
    output reg  [9:0] o_x_man,
    output reg  [9:0] o_y_man,
    output reg  [9:0] o_x_block1,     // 箱子1的X坐标
    output reg  [9:0] o_x_block2,     // 箱子2的X坐标
    output reg         o_en_block2,     // 箱子2显示使能
    output reg  [3:0]  o_type_block1, // 箱子1种类
    output reg  [3:0]  o_type_block2, // 箱子2种类
    //修改解释：我把原本的color改成了type，因为graphics中block有不同的种类，每一个种类对应一张图片
    //注：箱子种类的有效范围是0~5
    output wire  [3:0]  o_squeeze_man,  // 小人压扁度 (0-14)

    //增添解释：输出给graphics模块，表示是否显示标题和游戏结束画面
    output reg o_title,
    output reg o_gameover
    
    );
    */
    
    reg clk_machine;
    reg rst_machine;
    reg i_btn;
    wire i_jump_done;
    wire [10:0] i_jump_dist;
    wire [8:0] i_jump_height;
    wire [10:0] o_jump_v_init;
    wire o_jump_en;
    wire [2:0] state;
    wire [9:0] o_x_man;
    wire [9:0] o_y_man;
    wire [9:0] o_x_block1;
    wire [9:0] o_x_block2;
    wire o_en_block2;
    wire [3:0] o_type_block1;
    wire [3:0] o_type_block2;
    wire [3:0] o_squeeze_man;
    wire o_title;
    wire o_gameover;

    wire [31:0] div_res;

    /*
    module clkdiv(clk,rst,div_res);
    input   clk;
    input   rst;
    output reg [31:0] div_res;
    */

    clkdiv clkdiv_inst(
        .clk(clk_machine),
        .rst(rst_machine),
        .div_res(div_res)
    );




    wechat_jump_fsm wechat_jump_fsm_inst(
        .clk_machine(clk_machine),
        .rst_machine(rst_machine),
        .i_btn(i_btn),
        .i_jump_done(i_jump_done),
        .i_jump_dist(i_jump_dist),
        .i_jump_height(i_jump_height),
        .o_jump_v_init(o_jump_v_init),
        .o_jump_en(o_jump_en),
        .state(state),
        .o_x_man(o_x_man),
        .o_y_man(o_y_man),
        .o_x_block1(o_x_block1),
        .o_x_block2(o_x_block2),
        .o_en_block2(o_en_block2),
        .o_type_block1(o_type_block1),
        .o_type_block2(o_type_block2),
        .o_squeeze_man(o_squeeze_man),
        .o_title(o_title),
        .o_gameover(o_gameover)

    );
    /*
    module jump(
        input en,
        input clk_jump,
        input [10:0] i_v_init,  // 初始速度，当初速度为127时，跳跃高度为256，距离为260
        output [8:0] o_height,
        output reg [10:0] o_dist,
        output reg o_done
    );
    */

    jump jump_inst(
        .en(o_jump_en),
        .clk_jump(div_res[17]),
        .i_v_init(o_jump_v_init),
        .o_height(i_jump_height),
        .o_dist(i_jump_dist),
        .o_done(i_jump_done)
    );

    // 信号初始化
    initial begin
        clk_machine = 0;
        forever #5 clk_machine = ~clk_machine;
    end

    initial begin
        rst_machine = 1;
        #10 rst_machine = 0;
        i_btn = 1;

    end
endmodule
