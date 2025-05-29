`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/02 13:16:35
// Design Name: 
// Module Name: clk_divider
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


module clk_divider (
    input wire clk_vga,    // 输入时钟（如100MHz）
    input wire rst,        // 异步复位信号（高电平有效）
    output wire clk_jump   // 分频输出时钟
);

reg [17:0] clk_cnt;       // 18位计数器

// 计数器逻辑
always @(posedge clk_vga or posedge rst) begin
    if (rst) begin
        clk_cnt <= 18'd0;  // 复位时清零
    end else begin
        clk_cnt <= clk_cnt + 18'd1; // 每个时钟上升沿加1
    end
end

// 分频输出：取计数器最高位
assign clk_jump = clk_cnt[17]; 

endmodule