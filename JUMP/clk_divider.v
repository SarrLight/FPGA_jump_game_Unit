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
    input wire clk_vga,    // ����ʱ�ӣ���100MHz��
    input wire rst,        // �첽��λ�źţ��ߵ�ƽ��Ч��
    output wire clk_jump   // ��Ƶ���ʱ��
);

reg [17:0] clk_cnt;       // 18λ������

// �������߼�
always @(posedge clk_vga or posedge rst) begin
    if (rst) begin
        clk_cnt <= 18'd0;  // ��λʱ����
    end else begin
        clk_cnt <= clk_cnt + 18'd1; // ÿ��ʱ�������ؼ�1
    end
end

// ��Ƶ�����ȡ���������λ
assign clk_jump = clk_cnt[17]; 

endmodule