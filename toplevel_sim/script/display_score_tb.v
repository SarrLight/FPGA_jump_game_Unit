`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/08 12:02:58
// Design Name: 
// Module Name: display_score_tb
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


module display_score_tb();
    reg [9:0] i_score;
    reg clk, rst;
    wire [7:0] o_segment;

    /*
    module display_socre(
    input  clk,
    input  rst,
    input  [9:0] i_score,
    output [7:0] o_segment, // 7段数码管输出，需要最终输出给硬件接口
    output [3:0] o_segment_an   // 4个七段数码管的选通控制信号，需要最终输出给硬件接口
    );
    */

    display_socre display_socre_inst(
        .clk(clk),
        .rst(rst),
        .i_score(i_score),
        .o_segment(o_segment)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        i_score = 0;
        #10 rst = 0;
        #40 i_score = 2;
        #40 i_score = 12;
        #40 i_score = 1023;
    end

endmodule
