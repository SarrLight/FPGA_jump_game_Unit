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

    //与jump模块的连接
    input  wire        i_jump_done,    // 物理引擎跳跃完成信号
    input  wire [10:0] i_jump_dist,
    input  wire [8:0] i_jump_height,
    output wire  [10:0]  o_jump_v_init,  // 跳跃初速度
    output reg         o_jump_en,       // 物理引擎使能
    
    
    // 状态输出
    output reg  [2:0]  state,          // 当前状态码
    
    // 输出传递给graphics模块的信号
    output reg  [10:0] o_x_man,
    output reg  [10:0] o_y_man,
    output reg  [10:0] o_x_block1,     // 箱子1的X坐标
    output reg  [10:0] o_x_block2,     // 箱子2的X坐标
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

    // ================= 状态定义 ================= //
    localparam INIT = 3'd0;  // 初始化状态 (箱子位置交换)
    localparam RELD = 3'd1;  // 箱子复位动画
    localparam WAIT = 3'd2;  // 等待按键状态
    localparam ACCU = 3'd3;  // 蓄力状态
    localparam JUMP = 3'd4;  // 跳跃中状态
    localparam LAND = 3'd5;  // 着陆判定状态
    localparam OVER = 3'd6;  // 游戏结束状态

    // ================= 常量定义 ================= //
    //坐标单位是像素
    localparam ORIGIN         = 32'd0;   // 基准原点坐标
    localparam ORIGIN_STARTUP = 32'd100;     // INIT状态时，箱子1的初始坐标，待修改
    localparam BLOCK_WIDTH    = 32'd30;   // 其实是箱子宽度的一半，小人与箱子坐标差值小于此数说明小人在箱子上
    localparam BLOCK2_OFFSET  = 32'd180;    // 箱子2基础偏移量
    localparam MAX_SQUEEZE    = 4'd14;     // 最大压扁计数器值，挤压范围是0-14

    // ================= 内部信号 ================= //
    reg  [16:0] cnt_clk_reload;       // 复位动画计数器
    reg  [23:0] cnt_v_init;           // 初速度计数器，利用cnt_v_init来记录按键持续的clk周期数
    /*解释：因为小人跳跃初速度和小人的挤压程度有定比关系，所以原本的“压扁时钟时钟和计数器”没有存在的必要*/
    reg         reload_done;          // 复位完成标志
    wire [6:0]  random;               // 用于接受random模块产生的随机数
    reg new_game;                     // 用于判断是否为新游戏，若为新游戏，则显示标题画面


    // 输出赋值
    assign o_jump_v_init = cnt_v_init[23:17];  // 取cnt_v_init的最高7位作为初速度，范围是0-127，jump模块中初速度为127时，跳跃高度为256，距离为260
    assign o_squeeze_man = state==JUMP? 0 : cnt_v_init[23:17]*14/127%15;   // 取cnt_v_init的最高4位作为压扁度，范围是0-14，对应共计15帧的小人压扁图片



    // ================= 状态机核心 ================= //
    //处理不同状态之间的切换
    always @(posedge clk_machine or posedge rst_machine) begin
        if (rst_machine) begin           // 复位信号有效时
            state <= RELD;               // 进入复位动画状态
            new_game       <= 1'b1;     //rst_machine说明游戏重启进入新游戏
            o_title        <= 1'b1; 
            o_gameover     <= 1'b0;
            o_jump_en      <= 1'b0;
        end else begin                 // 复位信号消失时
            case (state)
                INIT: begin              
                    state <= RELD;           // INIT状态默认进入RELD状态
                end
                RELD: begin             // RELD状态下，箱子1左移到指定位置
                    if(new_game) begin  // 若为新游戏，则在此过程显示标题画面
                        o_title <= 1'b1;
                    end
                    if (reload_done || o_x_block1==ORIGIN) begin // 复位动画结束时或箱子位置正确时
                        state <= WAIT;      // 进入等待按键状态
                    end else begin
                        state <= RELD;      // 箱子未回位，继续复位动画
                    end
                end
                WAIT: begin             // 等待按键状态
                    if(new_game) begin
                        new_game <= 1'b0;   //复位动画结束，说明不是新游戏
                        o_title <= 1'b0;   // 隐藏标题画面
                    end
                    
                    if (i_btn) begin       // 玩家按下按键时，进入蓄力状态
                        state <= ACCU;  
                    end
                end
                ACCU: begin             // 蓄力状态
                    if (i_btn) begin    //按下按钮时进入一直处于蓄力中状态
                        state <= ACCU;
                    end else begin
                        o_jump_en=1'b1;
                        state <= JUMP;  //松开按钮时进入跳跃中状态
                    end
                end
                JUMP: begin             // 跳跃中状态
                    if (i_jump_done) begin // 物理引擎跳跃完成时，进入着陆判定状态
                        o_jump_en=1'b0;
                        state <= LAND;
                    end else begin
                        state <= JUMP;      // 跳跃没有完成时，继续跳跃中状态
                    end
                end
                LAND: begin             // 着陆判定状态
                wire x_on_block1 = (o_x_man >= o_x_block1 - BLOCK_WIDTH) && (o_x_man <= o_x_block1 + BLOCK_WIDTH);
                wire x_on_block2 = (o_x_block2 != o_x_block1) && (o_x_man >= o_x_block2 - BLOCK_WIDTH) && (o_x_man <= o_x_block2 + BLOCK_WIDTH);
                if (o_x_man < o_x_block1 - BLOCK_WIDTH) begin // 完全未跳出第一个箱子
                    state <= WAIT;
                end else if (x_on_block1 || x_on_block2) begin // 落在任意箱子的有效范围内（包含边缘）
                    state <= INIT; 
                end
                else begin  // 坠落
                    state <= OVER;
                     end
                end
                OVER: begin             // 游戏结束状态
                    state <= OVER;          // 保持当前状态
                    o_gameover <= 1'b1;    // 显示游戏结束画面
                end
                default: begin           // 其他状态
                    state <= RELD;          // 进入初始化状态
                end
            endcase
        end
    end

    /*把不同部分写到不同的always语句中，增强可读性*/
    
    //随机数生成器实例化
    random #(7) random_inst (
        .clk_random(clk_machine),
        .rst_random(rst_machine),
        .i_roll(i_btn),
        .o_random_binary(random)
    );

    //对两个箱子进行控制
    always @(posedge clk_machine or posedge rst_machine) begin
        if (rst_machine) begin
            o_x_block1 <= ORIGIN_STARTUP;     // 把箱子1和箱子2都放在ORIGIN_STARTUP的位置
            o_x_block2 <= ORIGIN_STARTUP;     
            o_en_block2 <= 1'b0;              // 隐藏箱子2
            reload_done <= 1'b0;             
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
                    if(o_x_block1 > ORIGIN) begin       // 若箱子1还没有移动到ORIGIN位置
                        if (cnt_clk_reload == 17'h1ffff) begin // 相当于对clk_machine进行13次分频
                            cnt_clk_reload <= 17'd0; // 复位计数器
                            o_x_block1 <= o_x_block1 - 1; // 左移箱子1
                        end else begin
                            cnt_clk_reload <= cnt_clk_reload + 1; // 计数器加1
                            o_x_block1 <= o_x_block1; // 箱子1位置不变
                        end
                        o_x_block2 <= o_x_block2;
                        o_en_block2 <= 1'b0;
                        reload_done <= 1'b0;
                    end else begin                    // 若箱子1已经移动到ORIGIN位置
                        cnt_clk_reload <= 17'd0;
                        o_x_block1 <= ORIGIN; // 复位箱子1
                        o_x_block2 <= ORIGIN + random + BLOCK2_OFFSET; // 基于初始偏移量和随机数产生箱子2的位置坐标
                        o_en_block2 <= 1'b1; // 显示箱子2
                        reload_done <= 1'b1; // 复位完成信号
                    end
                end
                default: begin
                    cnt_clk_reload <= 17'd0;
                    o_x_block1 <= o_x_block1;     // 初始坐标
                    o_x_block2 <= o_x_block2;     // 初始坐标
                    o_en_block2 <= o_en_block2;      // 初始使能信号
                    reload_done <= 1'b0;             // 复位完成信号
                end
            endcase
        end
    end
    
    // 对箱子种类进行控制
    always@(posedge clk_machine or posedge rst_machine) begin
        if(rst_machine) begin
            o_type_block1 <= 5'd5;
            o_type_block2 <= 5'd0;
        end else begin
            case(state) 
                INIT:begin
                    o_type_block1 <= o_type_block2;
                    if(o_type_block2 == 5) begin        //箱子种类的范围是0~5
                        o_type_block2 <= 0;
                    end else begin
                        o_type_block2 <= o_type_block2 + 1;
                    end 
                end 
                
                default:begin
                    o_type_block1 <= o_type_block1;
                    o_type_block2 <= o_type_block2;
                end 
            endcase
        end
    end
    
    //根据按键信号改变小人跳跃初速度
    always @(posedge clk_machine or posedge rst_machine) begin
        if (rst_machine) begin
            cnt_v_init <= 0;
        end else begin
            case(state)
                ACCU: begin
                    if (i_btn && cnt_v_init < 24'hffffff && cnt_v_init %2 == 0) begin //利用cnt_v_init来记录按键持续的clk周期数
                        cnt_v_init <= cnt_v_init + 1;
                    end else begin
                        cnt_v_init <= cnt_v_init;
                    end
                end
                JUMP: begin
                    if (i_jump_done) begin
                        cnt_v_init <= 0;
                    end else begin
                        cnt_v_init <= cnt_v_init;
                    end
                end
            endcase
        end
    end

    // 角色位置控制
    always@(posedge clk_machine or posedge rst_machine) begin
        if(rst_machine) begin
            o_x_man <= ORIGIN_STARTUP;
            o_y_man <= 0;
        end else begin
            case (state)
                INIT: begin
                    o_x_man <= o_x_man;
                    o_y_man <= 0;
                end
                
                ACCU: begin
                    o_x_man <= o_x_man-(o_x_block2-o_x_block1);
                    o_y_man <= 0;
                end
                
                JUMP: begin
                    o_x_man <= i_jump_dist*400/260; //将最远距离调整为400     
                    o_y_man <= i_jump_height;       
                end
                
                LAND, OVER: begin
                    // 保持当前位置
                end
                
                default: begin
                    o_x_man <= o_x_block1;
                    o_y_man <= 0;
                end
            endcase
        end
    end
            
    


endmodule