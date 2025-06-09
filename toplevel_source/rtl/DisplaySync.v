`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/28 13:43:48
// Design Name: 
// Module Name: DisplaySync
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


module DisplaySync(Hexs,Scan,Points,LES,HEX,AN,P,LE);   
 input [15:0] Hexs;
 input [1:0] Scan;
 input [3:0] Points;
 input [3:0] LES;
 output reg [3:0] HEX;
 output reg [3:0] AN;
 output reg P;
 output reg LE;
 
 always@(*) begin
  case(Scan)
  2'b00:begin HEX<=Hexs[3:0]; AN<=4'b1110; P<=Points[0]; LE<=LES[0]; end
  2'b01:begin HEX<=Hexs[7:4]; AN<=4'b1101; P<=Points[1]; LE<=LES[1]; end
  2'b10:begin HEX<=Hexs[11:8]; AN<=4'b1011; P<=Points[2]; LE<=LES[2]; end
  2'b11:begin HEX<=Hexs[15:12]; AN<=4'b0111; P<=Points[3]; LE<=LES[3]; end
  endcase
 end
endmodule
