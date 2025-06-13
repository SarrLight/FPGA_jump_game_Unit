`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/13 21:16:47
// Design Name: 
// Module Name: Buzzer_tb
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


module Buzzer_tb();
    /*
    module Buzzer(
        input clk,
        input rst_n,        //同步复位信号(低电平有效)
        input [5:0] music_scale,
        output reg beep,
        input i_load_done,   //小人正确落到箱子上的标志
        input i_perfect,
        input i_gameover
    );
    */
    reg clk;
    reg rst_n;
    reg [5:0] music_scale;
    wire beep;
    reg i_load_done;
    reg i_perfect;
    reg i_gameover;
    
    
    Buzzer buzzer_inst(
        .clk(clk),
        .rst_n(rst_n),
        .music_scale(music_scale),
        .beep(beep),
        .i_load_done(i_load_done),
        .i_perfect(i_perfect),
        .i_gameover(i_gameover)
    );

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        i_load_done = 0;
        i_gameover = 0;
        i_perfect = 0;
        #5 rst_n = 1;
        music_scale = 1;

        #10000000
        music_scale = 3;
        #10000000
        music_scale = 5;
        #10000000
        music_scale = 7;
        #10000000
        music_scale = 0;
        i_load_done = 1;
        i_perfect = 0;
        #10
        i_load_done = 0;
        #10000000
        i_load_done = 1;
        i_perfect =1 ;
        #10
        i_load_done = 0;
    end
    
endmodule
