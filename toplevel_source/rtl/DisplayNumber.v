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
    input [15:0] Hexs;  //Ҫ��ʾ��4λ16������
    input [3:0] Points; //����ÿ��λ���Ƿ���ʾС���㣬1��ʾ��ʾ��0��ʾ����ʾ
    input [3:0] LES;    //����ÿ��λ�õ�����0��ʾ����1��ʾ���൱�ڵ͵�ƽ��Ч��
    output [7:0] Segment;   //7��������������Ҫ���������Ӳ���ӿ�
    output [3:0] AN;        //7������ܵ�ѡ�������������Ҫ���������Ӳ���ӿ�
    
    //�ڲ�����
    wire a,b,c,d,e,f,g,p;
    wire [31:0] div_res;
    wire [3:0] HEX;
    wire Point,LE;
    
    clkdiv C1(.clk(clk),.rst(RST),.div_res(div_res) );
    DisplaySync D1(.Scan(div_res[18:17]),.Hexs(Hexs),.Points(Points),.LES(LES),.HEX(HEX),.P(Point),.LE(LE),.AN(AN));
    MyMC14495 M1(.D0(HEX[0]),.D1(HEX[1]),.D2(HEX[2]),.D3(HEX[3]),.point(Point),.LE(LE),.a(a),.b(b),.c(c),.d(d),.e(e),.f(f),.g(g),.p(p));
    assign Segment={p,g,f,e,d,c,b,a};
    
endmodule
