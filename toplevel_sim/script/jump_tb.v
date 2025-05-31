`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/31 23:10:02
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
    
    // 实例化被测模块
    jump jump_inst (
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
        forever #10 clk_jump = ~clk_jump; 
    end
    
    // 测试流程
    initial begin
        // 初始化信号
        en = 0;
        i_v_init = 0;
        
        // 测试
        #10 en = 1;
        i_v_init = 11'd127; // 初速度设置
        wait(o_done == 1);
        #100 en = 0;
        #100;
    end
endmodule
