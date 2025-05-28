`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/02 13:41:54
// Design Name: 
// Module Name: block_controller
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


module block_controller(
    input wire clk_machine,
    input wire rst_machine,
    input wire [2:0] state,      // 从状态机输入
    input wire [6:0] random,     // 随机数输入
    output reg [31:0] o_x_block1,
    output reg [31:0] o_x_block2,
    output reg o_en_block2,
    output reg reload_done  
    );
endmodule
