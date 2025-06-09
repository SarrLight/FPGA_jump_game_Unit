`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/28 15:45:06
// Design Name: 
// Module Name: Anti_jitter
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


module Anti_jitter(
    input wire clk,
    input wire BTN,
    output reg BTN_OK
    );
    
    reg [7:0] pbshift=8'b0000_0000;
    
    always@(posedge clk)begin
        pbshift=pbshift<<1;
        pbshift[0]=BTN;
        if(pbshift==8'b0)
            BTN_OK=0;
        if(pbshift==8'hFF)
            BTN_OK=1;
    end
    
endmodule
