`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/19 19:51:57
// Design Name: 
// Module Name: jump_tb
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


module jump_tb();
// �����ź�
    reg en;
    reg clk_jump;
    reg [10:0] i_v_init;
    
    // ����ź�
    wire [8:0] o_height;
    wire [10:0] o_dist;
    wire o_done;
    
    // ʵ������������
    jump uut (
        .en(en),
        .clk_jump(clk_jump),
        .i_v_init(i_v_init),
        .o_height(o_height),
        .o_dist(o_dist),
        .o_done(o_done)
    );
    
    // ����192Hzʱ�� (Լ5.2ms����)
    initial begin
        clk_jump = 0;
        forever #2604167 clk_jump = ~clk_jump; // 1/(192Hz)/2 �� 2.604167ms
    end
    
    // ��������
    initial begin
        // ��ʼ��
        en = 0;
        i_v_init = 0;
        
        // ��λ
        #10 en = 0;
        
        // ����1: �еȳ��ٶ���Ծ
        #20 en = 1;
        i_v_init = 11'd128; // �еȳ��ٶ�
        wait(o_done == 1);
        
        // ����2: �����ٶ���Ծ
        #20 en = 0;
        #20 en = 1;
        i_v_init = 11'd255; // �����ٶ�
        wait(o_done == 1);
        
        // ����3: ��С���ٶ���Ծ
        #20 en = 0;
        #20 en = 1;
        i_v_init = 11'd1; // ��С���ٶ�
        wait(o_done == 1);
        
        #20 $finish;
    end
endmodule
