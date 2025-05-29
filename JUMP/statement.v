`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/27 20:40:16
// Design Name: 
// Module Name: statement
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
module statement (
    input  wire        clk_machine,    // ��ʱ�� (25MHz)
    input  wire        rst_machine,    // �첽��λ (����Ч)
    input  wire        i_btn,          // ��Ұ�������
    input  wire        i_jump_done,    // ����������Ծ����ź�
    input  wire  [31:0] o_x_man,       // С��ˮƽ����
    input  wire  [31:0] o_x_block1,    // ����1��X����
    input  wire  [31:0] o_x_block2,    // ����2��X����
    output reg   [2:0]  state,          // ��ǰ״̬��
    input  wire        reload_done       // ��λ�ź�
);

// ================= ״̬���� ================= //
localparam INIT = 3'd0;  // ��ʼ��״̬ (����λ�ý���)
localparam RELD = 3'd1;  // ���Ӹ�λ����
localparam WAIT = 3'd2;  // �ȴ�����״̬
localparam ACCU = 3'd3;  // ����״̬
localparam JUMP = 3'd4;  // ��Ծ��״̬
localparam LAND = 3'd5;  // ��½�ж�״̬
localparam OVER = 3'd6;  // ��Ϸ����״̬

// ================= �������� ================= //
localparam ORIGIN         = 32'd0;   // ��׼ԭ������
localparam BLOCK_WIDTH    = 32'd30;   // ���ӿ��
// ================= ״̬�� ================= //
always @(posedge clk_machine ) begin
    if (rst_machine) begin           // ��λ�ź���Чʱ
        state <= RELD;               // ���븴λ����״̬
        end else begin                 // ��λ�ź���ʧʱ
        case (state)
            INIT: begin              // ��ʼ��״̬
            state <= RELD;           // ���븴λ����״̬
            end
            RELD: begin             // ��λ����״̬
                if (reload_done||o_x_block1==ORIGIN) begin // ��λ��������ʱ������λ����ȷʱ
                    state <= WAIT;      // ����ȴ�����״̬
                end else begin
                    state <= RELD;      // ����δ��λ��������λ����
                end
            end
            WAIT: begin             // �ȴ�����״̬
                if (i_btn) begin       // ��Ұ��°���ʱ
                    state <= ACCU;      // ��������״̬
                end
            end
            ACCU: begin             // ����״̬
                if (i_jump_done) begin // ����������Ծ���ʱ
                    state <= JUMP;      // ������Ծ��״̬
                end
            end
            JUMP: begin             // ��Ծ��״̬
                if (i_jump_done) begin // ����������Ծ���ʱ
                    state <= LAND;      // ������½�ж�״̬
                end else begin
                    state <= JUMP;      // ��������δ��Ծ��ɣ�������Ծ��״̬
                end
            end
            LAND: begin             // ��½�ж�״̬
                if (o_x_man <= BLOCK_WIDTH) begin // С��δ��������ʱ
                    state <= WAIT;      // ���½��а�����Ծ
                end else if((o_x_man < o_x_block2)?(o_x_block2-o_x_man <= BLOCK_WIDTH):(o_x_man-o_x_block2 <= BLOCK_WIDTH)) begin
                    state <= INIT;      // ����λ�ý���
                end else begin
                    state <= OVER;      // ��Ϸ����״̬
                end
            end
            OVER: begin             // ��Ϸ����״̬
                state <= OVER;          // ���ֵ�ǰ״̬
            end
            default: begin           // ����״̬
                state <= RELD;          // �����ʼ��״̬
            end
            endcase
        end
    end
endmodule


            
