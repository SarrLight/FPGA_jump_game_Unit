`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/28 20:09:10
// Design Name: 
// Module Name: Box_color
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


module Box_color(
    input  wire        clk_machine,    // 主时钟 (25MHz)
    input  wire        rst_machine,    // 异步复位 (高有效)
    input  wire        state,          // 状态信号
    output reg  [4:0]  o_color_index1, // 箱子1颜色索引
    output reg  [4:0]  o_color_index2 // 箱子2颜色索引
);

localparam INIT = 3'd0;  // 初始化状态 (箱子位置交换)

always @(posedge clk_machine) begin
    if (rst_machine) begin
        o_color_index1 <= 17;      // 箱子1颜色索引
        o_color_index2 <= 0;       // 箱子2颜色索引
    end else begin    
        case (state)
            INIT: begin
                o_color_index1 <= o_color_index2;   // 交换箱子颜色
                if (o_color_index2 == 17) begin
                    o_color_index2 <= 0;
                end else begin
                    o_color_index2 <= o_color_index2 + 1;
                end
            end
            default: begin
                o_color_index1 <= o_color_index1;      // 箱子1颜色索引
                o_color_index2 <= o_color_index2;       // 箱子2颜色索引
            end
        endcase
    end
end 

endmodule
