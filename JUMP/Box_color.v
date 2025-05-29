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
    input  wire        clk_machine,    // ��ʱ�� (25MHz)
    input  wire        rst_machine,    // �첽��λ (����Ч)
    input  wire        state,          // ״̬�ź�
    output reg  [4:0]  o_color_index1, // ����1��ɫ����
    output reg  [4:0]  o_color_index2 // ����2��ɫ����
);

localparam INIT = 3'd0;  // ��ʼ��״̬ (����λ�ý���)

always @(posedge clk_machine) begin
    if (rst_machine) begin
        o_color_index1 <= 17;      // ����1��ɫ����
        o_color_index2 <= 0;       // ����2��ɫ����
    end else begin    
        case (state)
            INIT: begin
                o_color_index1 <= o_color_index2;   // ����������ɫ
                if (o_color_index2 == 17) begin
                    o_color_index2 <= 0;
                end else begin
                    o_color_index2 <= o_color_index2 + 1;
                end
            end
            default: begin
                o_color_index1 <= o_color_index1;      // ����1��ɫ����
                o_color_index2 <= o_color_index2;       // ����2��ɫ����
            end
        endcase
    end
end 

endmodule
