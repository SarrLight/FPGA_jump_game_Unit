`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/19 12:58:07
// Design Name: 
// Module Name: top1
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


module top1(
    input clk,
    input rst_n,
    input [5:0] i_music_scale,
    output o_buzzer
    );

    Buzzer Buzzer_inst(
       .clk(clk),
       .rst_n(rst_n),
       .music_scale(i_music_scale),
       .beep(o_buzzer)
    );

endmodule
