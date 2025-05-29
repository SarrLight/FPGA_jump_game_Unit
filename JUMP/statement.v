`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/27 20:40:16
// Design Name: 
// Module Name: statement
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
module statement (
    input  wire        clk_machine,    // 主时钟 (25MHz)
    input  wire        rst_machine,    // 异步复位 (高有效)
    input  wire        i_btn,          // 玩家按键输入
    input  wire        i_jump_done,    // 物理引擎跳跃完成信号
    input  wire  [31:0] o_x_man,       // 小人水平坐标
    input  wire  [31:0] o_x_block1,    // 箱子1的X坐标
    input  wire  [31:0] o_x_block2,    // 箱子2的X坐标
    output reg   [2:0]  state,          // 当前状态码
    input  wire        reload_done       // 复位信号
);

// ================= 状态定义 ================= //
localparam INIT = 3'd0;  // 初始化状态 (箱子位置交换)
localparam RELD = 3'd1;  // 箱子复位动画
localparam WAIT = 3'd2;  // 等待按键状态
localparam ACCU = 3'd3;  // 蓄力状态
localparam JUMP = 3'd4;  // 跳跃中状态
localparam LAND = 3'd5;  // 着陆判定状态
localparam OVER = 3'd6;  // 游戏结束状态

// ================= 常量定义 ================= //
localparam ORIGIN         = 32'd0;   // 基准原点坐标
localparam BLOCK_WIDTH    = 32'd30;   // 箱子宽度
// ================= 状态机 ================= //
always @(posedge clk_machine ) begin
    if (rst_machine) begin           // 复位信号有效时
        state <= RELD;               // 进入复位动画状态
        end else begin                 // 复位信号消失时
        case (state)
            INIT: begin              // 初始化状态
            state <= RELD;           // 进入复位动画状态
            end
            RELD: begin             // 复位动画状态
                if (reload_done||o_x_block1==ORIGIN) begin // 复位动画结束时或箱子位置正确时
                    state <= WAIT;      // 进入等待按键状态
                end else begin
                    state <= RELD;      // 箱子未回位，继续复位动画
                end
            end
            WAIT: begin             // 等待按键状态
                if (i_btn) begin       // 玩家按下按键时
                    state <= ACCU;      // 进入蓄力状态
                end
            end
            ACCU: begin             // 蓄力状态
                if (i_jump_done) begin // 物理引擎跳跃完成时
                    state <= JUMP;      // 进入跳跃中状态
                end
            end
            JUMP: begin             // 跳跃中状态
                if (i_jump_done) begin // 物理引擎跳跃完成时
                    state <= LAND;      // 进入着陆判定状态
                end else begin
                    state <= JUMP;      // 物理引擎未跳跃完成，继续跳跃中状态
                end
            end
            LAND: begin             // 着陆判定状态
                if (o_x_man <= BLOCK_WIDTH) begin // 小人未跳出箱子时
                    state <= WAIT;      // 重新进行按键跳跃
                end else if((o_x_man < o_x_block2)?(o_x_block2-o_x_man <= BLOCK_WIDTH):(o_x_man-o_x_block2 <= BLOCK_WIDTH)) begin
                    state <= INIT;      // 箱子位置交换
                end else begin
                    state <= OVER;      // 游戏结束状态
                end
            end
            OVER: begin             // 游戏结束状态
                state <= OVER;          // 保持当前状态
            end
            default: begin           // 其他状态
                state <= RELD;          // 进入初始化状态
            end
            endcase
        end
    end
endmodule


            
