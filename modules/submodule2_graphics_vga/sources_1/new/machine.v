`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/28 16:52:52
// Design Name: 
// Module Name: machine
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


module machine(
    input  wire        clk_machine,    // 主时钟 (25.175MHz)
    input  wire        rst_machine,    // 异步复位 (高有效)
    input  wire        i_btn,          // 玩家按键输入
    input  wire        i_jump_done,    // 物理引擎跳跃完成信号

    output reg [9:0] o_x_man,
    output reg [9:0] o_y_man,
    output reg [9:0] o_x_block1,
    output reg [9:0] o_x_block2,

    output reg [3:0] o_type_block1,
    output reg [3:0] o_type_block2,

    output reg o_gameover,    // 游戏结束信号
    output reg o_titile,

    output reg  [7:0]  o_jump_v_init,  // 跳跃初速度
    output reg  [2:0]  o_squeeze_man,  // 小人压扁度 (0-7)
    output reg         o_jump_en,       // 物理引擎使能

    );

    



endmodule
