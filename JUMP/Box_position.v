`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/27 21:34:06
// Design Name: 
// Module Name: Box_position
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


module Box_position(
    input  wire        clk_machine,    // ��ʱ�� (25MHz)
    input  wire        rst_machine,    // �첽��λ (����Ч)
    input  wire        i_btn,          // ��Ұ�������
    input  wire        state,        // ��ǰ״̬
    output reg [31:0] o_x_block1,    // ����1��X����
    output reg [31:0] o_x_block2,    // ����2��X����
    output reg [31:0] o_en_block2,   // ����2��ʹ���ź�
    output reg  reload_done,      // ��λ����ź�
    output reg [16:0] cnt_clk_reload       // ��λ���������� 
);
wire [6:0] random;       // ��������
    // ���峣��
localparam ORIGIN         = 32'd0;   // ��׼ԭ������
localparam ORIGIN_STARTUP = 32'd0;     // ��ʼ����
// ================= ״̬���� ================= //
localparam INIT = 3'd0;  // ��ʼ��״̬ (����λ�ý���)
localparam RELD = 3'd1;  // ���Ӹ�λ����

random #(7) random_inst (
    .clk_random(clk_machine),
    .rst_random(rst_machine),
    .i_roll(i_btn),
    .o_random_binary(random)
);        // �����������ʵ��

always @(posedge clk_machine) begin
    if (rst_machine) begin
        o_x_block1 <= ORIGIN_STARTUP;     // ��ʼ����
        o_x_block2 <= ORIGIN_STARTUP;     // ��ʼ����
        o_en_block2 <= 1'b0;              // ��ʼʹ���ź�
        reload_done <= 1'b0;             // ��λ����ź�
        cnt_clk_reload <= 17'd0;          // ��λ����������
    end else begin
        case (state)
            INIT: begin
                cnt_clk_reload <= 17'd0;
                o_x_block1 <= o_x_block2;    // ����λ�ý���
                o_x_block2 <= o_x_block2;    // ����λ�ò���
                o_en_block2 <= 1'b0;
                reload_done <= 1'b0;
            end
            RELD: begin
                if(o_x_block1 >= ORIGIN + 1) begin       // ����1�ƶ�����׼λ��
                    if (cnt_clk_reload == 17'h1ffff) begin // ��λ��������
                        cnt_clk_reload <= 17'd0; // ��λ������
                        o_x_block1 <= o_x_block1 - 1; // ��λ����1
                    end else begin
                        cnt_clk_reload <= cnt_clk_reload + 1; // ��������1
                        o_x_block1 <= o_x_block1; // ����1λ�ò���
                    end
                    o_x_block2 <= o_x_block2;
                    o_en_block2 <= 1'b0;
                    reload_done <= 1'b0;
                end else begin
                    cnt_clk_reload <= 17'd0;
                    o_x_block1 <= ORIGIN; // ��λ����1
                    o_x_block2 <= ORIGIN + random + 65; // ������ɵ�����
                    o_en_block2 <= 1'b1; // ʹ������2
                    reload_done <= 1'b1; // ��λ����ź�
                end
            end
            default: begin
                cnt_clk_reload <= 17'd0;
                o_x_block1 <= o_x_block1;     // ��ʼ����
                o_x_block2 <= o_x_block2;     // ��ʼ����
                o_en_block2 <= o_en_block2;              // ��ʼʹ���ź�
                reload_done <= 1'b0;             // ��λ����ź�
            end
        endcase
    end
end

endmodule
