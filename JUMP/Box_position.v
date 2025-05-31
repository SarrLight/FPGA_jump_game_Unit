`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/27 21:34:06
// Design Name: 
// Module Name: Box_position
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


module Box_position(
    input  wire        clk_machine,    // 主时钟 (25MHz)
    input  wire        rst_machine,    // 异步复位 (高有效)
    input  wire        i_btn,          // 玩家按键输入
    input  wire        state,        // 当前状态
    output reg [31:0] o_x_block1,    // 箱子1的X坐标
    output reg [31:0] o_x_block2,    // 箱子2的X坐标
    output reg [31:0] o_en_block2,   // 箱子2的使能信号
    output reg  reload_done,      // 复位完成信号
    output reg [16:0] cnt_clk_reload       // 复位动画计数器 
);
wire [6:0] random;       // 随机数输出
    // 定义常量
localparam ORIGIN         = 32'd0;   // 基准原点坐标
localparam ORIGIN_STARTUP = 32'd0;     // 初始坐标
// ================= 状态定义 ================= //
localparam INIT = 3'd0;  // 初始化状态 (箱子位置交换)
localparam RELD = 3'd1;  // 箱子复位动画

random #(7) random_inst (
    .clk_random(clk_machine),
    .rst_random(rst_machine),
    .i_roll(i_btn),
    .o_random_binary(random)
);        // 随机数生成器实例

always @(posedge clk_machine) begin
    if (rst_machine) begin
        o_x_block1 <= ORIGIN_STARTUP;     // 初始坐标
        o_x_block2 <= ORIGIN_STARTUP;     // 初始坐标
        o_en_block2 <= 1'b0;              // 初始使能信号
        reload_done <= 1'b0;             // 复位完成信号
        cnt_clk_reload <= 17'd0;          // 复位动画计数器
    end else begin
        case (state)
            INIT: begin
                cnt_clk_reload <= 17'd0;
                o_x_block1 <= o_x_block2;    // 箱子位置交换
                o_x_block2 <= o_x_block2;    // 箱子位置不变
                o_en_block2 <= 1'b0;
                reload_done <= 1'b0;
            end
            RELD: begin
                if(o_x_block1 >= ORIGIN + 1) begin       // 箱子1移动到基准位置
                    if (cnt_clk_reload == 17'h1ffff) begin // 复位动画结束
                        cnt_clk_reload <= 17'd0; // 复位计数器
                        o_x_block1 <= o_x_block1 - 1; // 复位箱子1
                    end else begin
                        cnt_clk_reload <= cnt_clk_reload + 1; // 计数器加1
                        o_x_block1 <= o_x_block1; // 箱子1位置不变
                    end
                    o_x_block2 <= o_x_block2;
                    o_en_block2 <= 1'b0;
                    reload_done <= 1'b0;
                end else begin
                    cnt_clk_reload <= 17'd0;
                    o_x_block1 <= ORIGIN; // 复位箱子1
                    o_x_block2 <= ORIGIN + random + 65; // 随机生成的坐标
                    o_en_block2 <= 1'b1; // 使能箱子2
                    reload_done <= 1'b1; // 复位完成信号
                end
            end
            default: begin
                cnt_clk_reload <= 17'd0;
                o_x_block1 <= o_x_block1;     // 初始坐标
                o_x_block2 <= o_x_block2;     // 初始坐标
                o_en_block2 <= o_en_block2;              // 初始使能信号
                reload_done <= 1'b0;             // 复位完成信号
            end
        endcase
    end
end

endmodule
