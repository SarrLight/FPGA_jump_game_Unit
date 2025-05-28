`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/19 16:38:16
// Design Name: 
// Module Name: top1_sim
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


module top1_sim();

    reg clk;
    reg rst_n;
    reg [5:0] i_music_scale;
    wire o_buzzer;

    
    top1 top1_inst (
       .clk(clk),
       .rst_n(rst_n),
       .o_buzzer(o_buzzer),
       .i_music_scale(i_music_scale)
    );
    initial begin
        clk = 0;    
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        i_music_scale =1;
        #1000 rst_n = 1;
    end

endmodule
