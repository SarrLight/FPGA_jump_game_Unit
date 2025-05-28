`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/19 19:51:57
// Design Name: 
// Module Name: jump_tb
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


module jump_tb();
// 输入信号
    reg en;
    reg clk_jump;
    reg [10:0] i_v_init;
    
    // 输出信号
    wire [8:0] o_height;
    wire [10:0] o_dist;
    wire o_done;
    
    // 实例化物理引擎
    jump uut (
        .en(en),
        .clk_jump(clk_jump),
        .i_v_init(i_v_init),
        .o_height(o_height),
        .o_dist(o_dist),
        .o_done(o_done)
    );
    
    // 生成192Hz时钟 (约5.2ms周期)
    initial begin
        clk_jump = 0;
        forever #2604167 clk_jump = ~clk_jump; // 1/(192Hz)/2 ≈ 2.604167ms
    end
    
    // 测试流程
    initial begin
        // 初始化
        en = 0;
        i_v_init = 0;
        
        // 复位
        #10 en = 0;
        
        // 测试1: 中等初速度跳跃
        #20 en = 1;
        i_v_init = 11'd128; // 中等初速度
        wait(o_done == 1);
        
        // 测试2: 最大初速度跳跃
        #20 en = 0;
        #20 en = 1;
        i_v_init = 11'd255; // 最大初速度
        wait(o_done == 1);
        
        // 测试3: 最小初速度跳跃
        #20 en = 0;
        #20 en = 1;
        i_v_init = 11'd1; // 最小初速度
        wait(o_done == 1);
        
        #20 $finish;
    end
endmodule
