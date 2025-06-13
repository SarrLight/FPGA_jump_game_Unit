`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/08 11:41:08
// Design Name: 
// Module Name: display_score
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


module display_score(
    input  clk,
    input  rst,
    input  [9:0] i_score,
    output [7:0] o_segment, // 7段数码管输出，需要最终输出给硬件接口
    output [3:0] o_segment_an   // 4个七段数码管的选通控制信号，需要最终输出给硬件接口
    );

    wire [3:0] digit0, digit1, digit2, digit3; // 4个七段数码管的输出

    assign digit3= i_score/1000%10; //最高位
    assign digit2= i_score/100%10;
    assign digit1= i_score/10%10;
    assign digit0= i_score%10;  //最低位

    //module DisplayNumber(clk,RST,Hexs,Points,LES,Segment,AN);
    DisplayNumber DisplayNumber_inst(
       .clk(clk),
       .RST(rst),
       .Hexs({digit3,digit2,digit1,digit0}),
       .Points(4'b0000),
       .LES(4'b0000),
       .Segment(o_segment),
       .AN(o_segment_an)
    );

endmodule
