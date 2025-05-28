`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/02 13:32:28
// Design Name: 
// Module Name: wechat_jump_fsm
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
module wechat_jump_fsm (
    // 基础控制信号
    input  wire        clk_machine,    // 主时钟 (25.175MHz)
    input  wire        rst_machine,    // 异步复位 (高有效)
    input  wire        i_btn,          // 玩家按键输入
    input  wire        i_jump_done,    // 物理引擎跳跃完成信号
    
    // 位置输入信号
    input  wire [31:0] i_x_man,        // 当前小人X坐标
    input  wire [31:0] i_x_block2,     // 当前箱子2的X坐标
    input  wire [31:0] i_jump_dist,
    input  wire [31:0] i_jump_height,
    // 状态输出
    output reg  [2:0]  state,          // 当前状态码
    
    // 箱子控制输出
    output reg  [31:0] o_x_block1,     // 箱子1的X坐标
    output reg  [31:0] o_x_block2,     // 箱子2的X坐标
    output reg         o_en_block2,     // 箱子2显示使能
    
    // 外观控制
    output reg  [4:0]  o_color_index1, // 箱子1颜色索引
    output reg  [4:0]  o_color_index2, // 箱子2颜色索引
    
    // 物理参数
    output reg  [7:0]  o_jump_v_init,  // 跳跃初速度
    output reg  [2:0]  o_squeeze_man,  // 小人压扁度 (0-7)
    output reg         o_jump_en,       // 物理引擎使能
    output reg  [31:0] o_x_man,
    output reg  [31:0] o_y_man
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
localparam ORIGIN         = 32'd100;   // 基准原点坐标
localparam ORIGIN_STARTUP = 32'd0;     // 初始坐标
localparam JUMP_THRESHOLD = 32'd30;    // 跳跃判定阈值
localparam BLOCK2_OFFSET  = 32'd65;    // 箱子2基础偏移量
localparam MAX_SQUEEZE    = 4'd15;     // 最大压扁计数器值

// ================= 内部信号 ================= //
reg  [16:0] cnt_clk_reload;       // 复位动画计数器
reg  [23:0] cnt_v_init;           // 初速度计数器
reg  [19:0] cnt_clk_squeeze;      // 压扁时钟分频
reg  [3:0]  cnt_squeeze;          // 压扁度计数器
wire        clk_squeeze;          // 压扁控制时钟 (低频)
wire        reload_done;          // 复位完成标志
wire [6:0]  random;               // 随机数输入

// ================= 时钟分频 ================= //
assign clk_squeeze = cnt_clk_squeeze[19];  // 约192Hz分频
assign reload_done = (o_x_block1 <= ORIGIN); // 复位完成判断
random #(7) random_inst (
    .clk_random(clk_machine),
    .rst_random(rst_machine),
    .i_roll(i_btn),
    .o_random_binary(random)
);      
// ================= 状态机核心 ================= //
always @(posedge clk_machine or posedge rst_machine) begin
    if (rst_machine) begin
        // 异步复位初始化
        state          <= RELD;
        o_x_block1     <= ORIGIN_STARTUP;
        o_x_block2     <= ORIGIN_STARTUP;
        o_en_block2    <= 1'b0;
        o_color_index1 <= 5'd17;
        o_color_index2 <= 5'd0;
        cnt_v_init     <= 24'd0;
        cnt_squeeze    <= 4'd0;
        cnt_clk_squeeze<= 20'd0;
        cnt_clk_reload <= 17'd0;
        o_jump_en      <= 1'b0;
        o_x_man        <= ORIGIN_STARTUP;
        o_y_man        <= 32'd0;
    end else begin
        // 压扁时钟计数器
        cnt_clk_squeeze <= cnt_clk_squeeze + 1;
        
        // 默认输出
        o_jump_en <= 1'b0;
        
        // 状态转换逻辑
        case (state)
            INIT: begin
                state <= RELD;  // 初始化后立即开始复位动画
            end
            
            RELD: begin
                if (reload_done || o_x_block1 == ORIGIN) begin
                    state <= WAIT;
                end else begin
                    state <= RELD;
                end    
            end
                                 
            WAIT: begin
                if (i_btn) begin
                    state <= ACCU;
                end else begin
                    state <= WAIT;
                end 
            end
                    
            ACCU: begin
                if (!i_btn) begin
                    state <= JUMP;
                end else begin
                    state <= ACCU;
                end    
            end
            
            JUMP: begin
                if (i_jump_done) begin
                    state <= LAND;
                end else begin
                    state <= JUMP;
                end    
            end
            
            LAND: begin
                if (o_x_man <= JUMP_THRESHOLD) begin
                    state <= WAIT;  // 未跳出当前箱子
                end else if ((o_x_block2 > o_x_man) ? 
                          (o_x_block2 - o_x_man <= JUMP_THRESHOLD) : 
                          (o_x_man - o_x_block2 <= JUMP_THRESHOLD)) begin
                    state <= INIT;  // 成功跳上下一个箱子
                end else begin
                    state <= OVER;   // 跳跃失败
                end
            end
            
            OVER: begin
                state <= OVER;  // 保持结束状态
            end
            default: begin
                state <= RELD;  // 异常状态恢复
            end
        endcase

 // ================= 随机数生成器实例化 ================= //

        // 箱子位置控制
        case (state)
            INIT: begin
                o_x_block1  <= o_x_block2;  // 箱子2变为箱子1
                o_en_block2 <= 1'b0;        // 隐藏箱子2
                cnt_clk_reload <= 0;
            end
            
            RELD: begin
                if (o_x_block1 > ORIGIN) begin
                    // 箱子1复位动画
                    if (cnt_clk_reload == 17'h1ffff) begin
                        o_x_block1  <= o_x_block1 - 1;
                        cnt_clk_reload <= 0;
                    end else begin
                        cnt_clk_reload <= cnt_clk_reload + 1;
                    end
                    o_en_block2 <= 1'b0;
                end else begin
                    // 复位完成，生成新箱子2
                    o_x_block1  <= ORIGIN;
                    o_x_block2  <= ORIGIN + random + BLOCK2_OFFSET;
                    o_en_block2 <= 1'b1;
                end
            end
            
            default: begin
                // 其他状态保持位置不变
            end
        endcase
        
        // 箱子颜色控制
case(state) 
       INIT:begin
       o_color_index1 <= o_color_index2;
       if(o_color_index2 == 17) begin
       o_color_index2 <= 0;
       end else begin
       o_color_index2 <= o_color_index2 + 1;
                end 
            end 
            default:begin
            end 
          endcase
 // 初速度控制
       case (state)
            ACCU: begin
                if (i_btn && cnt_v_init < 24'hffffff) begin
                    cnt_v_init <= cnt_v_init + 1;
                end
            end
            
            JUMP: begin
                if (i_jump_done) begin
                    cnt_v_init <= 0;
                end
            end
            
            default: begin
                if (i_jump_done) begin
                    cnt_v_init <= 0;
                end
            end    
        endcase
        
        // 压扁度控制
        if (state == ACCU) begin
            if (cnt_squeeze < MAX_SQUEEZE) begin
                cnt_squeeze <= cnt_squeeze + 1;
            end
        end else begin
            cnt_squeeze <= 0;
        end
        
        // 角色位置控制
        case (state)
            INIT: begin
                o_x_man <= o_x_block2;
                o_y_man <= 0;
            end
            
            ACCU: begin
                o_x_man <= o_x_block1;
                o_y_man <= 0;
            end
            
            JUMP: begin
                o_x_man <= i_jump_dist;
                o_y_man <= i_jump_height << 2;
            end
            
            LAND, OVER: begin
                // 保持当前位置
            end
            
            default: begin
                o_x_man <= o_x_block1;
                o_y_man <= 0;
            end
        endcase
        
// 输出赋值
assign o_jump_v_init = cnt_v_init[23:17];  // 量化到0-255
assign o_squeeze_man = cnt_squeeze[3:1];   // 压扁度0-7
end
end
endmodule