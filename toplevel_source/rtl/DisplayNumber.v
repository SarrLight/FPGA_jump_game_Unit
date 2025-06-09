`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/28 14:07:35
// Design Name: 
// Module Name: DisplayNumber
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


module DisplayNumber(clk,RST,Hexs,Points,LES,Segment,AN);
    input clk;
    input RST;
    input [15:0] Hexs;  //要显示的4位16进制数
    input [3:0] Points; //决定每个位置是否显示小数点，1表示显示，0表示不显示
    input [3:0] LES;    //决定每个位置的亮灭，0表示亮，1表示灭（相当于低电平有效）
    output [7:0] Segment;   //7段数码管输出，需要最终输出给硬件接口
    output [3:0] AN;        //7段数码管的选择引脚输出，需要最终输出给硬件接口
    
    //内部变量
    wire a,b,c,d,e,f,g,p;
    wire [31:0] div_res;
    wire [3:0] HEX;
    wire Point,LE;
    
    clkdiv C1(.clk(clk),.rst(RST),.div_res(div_res) );
    DisplaySync D1(.Scan(div_res[18:17]),.Hexs(Hexs),.Points(Points),.LES(LES),.HEX(HEX),.P(Point),.LE(LE),.AN(AN));
    MyMC14495 M1(.D0(HEX[0]),.D1(HEX[1]),.D2(HEX[2]),.D3(HEX[3]),.point(Point),.LE(LE),.a(a),.b(b),.c(c),.d(d),.e(e),.f(f),.g(g),.p(p));
    assign Segment={p,g,f,e,d,c,b,a};
    
endmodule
