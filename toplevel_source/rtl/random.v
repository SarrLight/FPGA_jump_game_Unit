`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/02 13:52:45
// Design Name: 
// Module Name: random
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


module random #(
    parameter WIDTH = 7
)(
    input clk_random,
    input rst_random,
    input i_roll,
    output [WIDTH-1:0] o_random_binary
);

reg [WIDTH-1:0] cnt_random;

always @(posedge clk_random) begin
    if (rst_random) begin
        cnt_random <= 0;
    end else if (i_roll) begin
        cnt_random <= cnt_random + 1; //merge的结果
    end
end

// 逆序输出增加随机性
genvar i;
generate
    for (i = 0; i < WIDTH; i = i + 1) begin
        assign o_random_binary[i] = cnt_random[WIDTH-1-i];    // 逆序输出
    end
endgenerate

endmodule
