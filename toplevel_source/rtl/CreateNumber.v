`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/28 15:35:22
// Design Name: 
// Module Name: CreateNumber
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


module CreateNumber(
    input  [3:0] btn,
    output reg [15:0] num
    );
    wire [3:0] A,B,C,D;
    
    initial num<= 16'b0101_0011_0110_0000;
    
    assign A = num[3:0] + 4'b1;
    assign B = num[7:4] + 4'b1;
    assign C = num[11:8] + 4'b1;
    assign D = num[15:12] + 4'b1;
    
    always@(posedge btn[0]) num[3:0]<=A;
    always@(posedge btn[1]) num[7:4]<=B;
    always@(posedge btn[2]) num[11:8]<=C;
    always@(posedge btn[3]) num[15:12]<=D;
    
endmodule
