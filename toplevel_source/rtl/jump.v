`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/02 13:53:45
// Design Name: 
// Module Name: jump
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


module jump(
    input en,
    input clk_jump,
    input [10:0] i_v_init,  // 初始速度，当初速度为127时，跳跃高度为256，距离为260
    output [8:0] o_height,
    output reg [10:0] o_dist,
    output reg o_done
);

reg [12:0] v_vertical;
reg [12:0] actual_height;

// 纵向速度更新
always @(posedge clk_jump, negedge en) begin
    if (!en) begin
        v_vertical <= 0;
    end else if (o_done) begin
        v_vertical <= v_vertical;
    end else if (v_vertical == 0) begin
        v_vertical <= {2'b00, i_v_init[10:2], 2'b10}; // 初速度设置
    end else begin
        v_vertical <= v_vertical - 4; // 重力加速度
    end
end

// 高度更新
always @(posedge clk_jump, negedge en) begin
    if (!en) begin
        actual_height <= 0;
    end else if (o_done) begin
        actual_height <= actual_height;
    end else begin
        actual_height <= actual_height + v_vertical;
    end
end

// 距离更新
always @(posedge clk_jump, negedge en) begin
    if (!en) begin
        o_dist <= 0;
    end else if (o_done) begin
        o_dist <= o_dist;
    end else begin
        o_dist <= o_dist + 4; // 水平速度
    end
end

// 跳跃完成判定
always @(posedge clk_jump, negedge en) begin
    if (!en) begin
        o_done <= 1'b0;
    end else if (v_vertical + {i_v_init[10:2], 2'b10} == 11'd0) begin
        o_done <= 1'b1;
    end
end

assign o_height = actual_height[11:3]; // 输出高度

endmodule