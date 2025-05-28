`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/11 16:37:49
// Design Name: 
// Module Name: clkdiv
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


module clkdiv(clk,rst,div_res);
    input   clk;
    input   rst;
    output reg [31:0] div_res;
    
    always@(posedge clk) begin
        if(rst==1'b1)begin
            div_res<=32'b0;
        end  else begin
            div_res <= div_res+ 32'b1;
        end
    end
    
endmodule

