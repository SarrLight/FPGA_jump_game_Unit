`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/27 20:45:18
// Design Name: 
// Module Name: statement_tb
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


module statement_tb();
reg clk_machine;    // ��ʱ�� (25MHz)
reg rst_machine;    // �첽��λ (����Ч)
reg i_btn;          // ��Ұ�������
reg i_jump_done;    // ����������Ծ����ź�
reg [31:0] o_x_man;       // С��ˮƽ����
reg [31:0] o_x_block1;    // ����1��X����
reg [31:0] o_x_block2;    // ����2��X����
wire [2:0]  state;          // ��ǰ״̬��
reg reload_done;       // ��λ�ź�

statement uut(
    .clk_machine(clk_machine),
    .rst_machine(rst_machine),
    .i_btn(i_btn),
    .i_jump_done(i_jump_done),
    .o_x_man(o_x_man),
    .o_x_block1(o_x_block1),
    .o_x_block2(o_x_block2),
    .state(state),
    .reload_done(reload_done)
);
initial begin
    clk_machine = 0;
    forever #5 clk_machine = ~clk_machine;  
end
initial begin
    rst_machine = 1;
    #150 rst_machine = 0;
end
initial begin
    reload_done = 0;
    #10 reload_done = 1;
    i_btn = 0;
    i_jump_done = 0;
    #10 i_btn = 1;
    o_x_block1 = 0;
    o_x_block2 = 100;
    o_x_man = 0;
    #20 o_x_man = 10;
    #20 o_x_man = 30;
    #20 o_x_man = 50;
    #20 o_x_man = 70;
    #20 o_x_man = 90;
    #20 o_x_man = 110;
    #10 i_jump_done = 1;
end
endmodule
