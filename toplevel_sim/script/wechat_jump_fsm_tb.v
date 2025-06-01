`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/31 23:36:46
// Design Name: 
// Module Name: wechat_jump_fsm_tb
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


module wechat_jump_fsm_tb( );
    
    /*
    module wechat_jump_fsm (
    // ���������ź�
    input  wire        clk_machine,    // ��ʱ�� (25.175MHz)
    input  wire        rst_machine,    // �첽��λ (����Ч)
    input  wire        i_btn,          // ��Ұ�������

    //��jumpģ�������
    input  wire        i_jump_done,    // ����������Ծ����ź�
    input  wire [10:0] i_jump_dist,
    input  wire [8:0] i_jump_height,
    output wire  [10:0]  o_jump_v_init,  // ��Ծ���ٶ�
    output reg         o_jump_en,       // ��������ʹ��
    
    
    // ״̬���
    output reg  [2:0]  state,          // ��ǰ״̬��
    
    // ������ݸ�graphicsģ����ź�
    output reg  [9:0] o_x_man,
    output reg  [9:0] o_y_man,
    output reg  [9:0] o_x_block1,     // ����1��X����
    output reg  [9:0] o_x_block2,     // ����2��X����
    output reg         o_en_block2,     // ����2��ʾʹ��
    output reg  [3:0]  o_type_block1, // ����1����
    output reg  [3:0]  o_type_block2, // ����2����
    //�޸Ľ��ͣ��Ұ�ԭ����color�ĳ���type����Ϊgraphics��block�в�ͬ�����࣬ÿһ�������Ӧһ��ͼƬ
    //ע�������������Ч��Χ��0~5
    output wire  [3:0]  o_squeeze_man,  // С��ѹ��� (0-14)

    //������ͣ������graphicsģ�飬��ʾ�Ƿ���ʾ�������Ϸ��������
    output reg o_title,
    output reg o_gameover
    
    );
    */
    
    reg clk_machine;
    reg rst_machine;
    reg i_btn;
    wire i_jump_done;
    wire [10:0] i_jump_dist;
    wire [8:0] i_jump_height;
    wire [10:0] o_jump_v_init;
    wire o_jump_en;
    wire [2:0] state;
    wire [9:0] o_x_man;
    wire [9:0] o_y_man;
    wire [9:0] o_x_block1;
    wire [9:0] o_x_block2;
    wire o_en_block2;
    wire [3:0] o_type_block1;
    wire [3:0] o_type_block2;
    wire [3:0] o_squeeze_man;
    wire o_title;
    wire o_gameover;

    wire [31:0] div_res;

    /*
    module clkdiv(clk,rst,div_res);
    input   clk;
    input   rst;
    output reg [31:0] div_res;
    */

    clkdiv clkdiv_inst(
        .clk(clk_machine),
        .rst(rst_machine),
        .div_res(div_res)
    );




    wechat_jump_fsm wechat_jump_fsm_inst(
        .clk_machine(clk_machine),
        .rst_machine(rst_machine),
        .i_btn(i_btn),
        .i_jump_done(i_jump_done),
        .i_jump_dist(i_jump_dist),
        .i_jump_height(i_jump_height),
        .o_jump_v_init(o_jump_v_init),
        .o_jump_en(o_jump_en),
        .state(state),
        .o_x_man(o_x_man),
        .o_y_man(o_y_man),
        .o_x_block1(o_x_block1),
        .o_x_block2(o_x_block2),
        .o_en_block2(o_en_block2),
        .o_type_block1(o_type_block1),
        .o_type_block2(o_type_block2),
        .o_squeeze_man(o_squeeze_man),
        .o_title(o_title),
        .o_gameover(o_gameover)

    );
    /*
    module jump(
        input en,
        input clk_jump,
        input [10:0] i_v_init,  // ��ʼ�ٶȣ������ٶ�Ϊ127ʱ����Ծ�߶�Ϊ256������Ϊ260
        output [8:0] o_height,
        output reg [10:0] o_dist,
        output reg o_done
    );
    */

    jump jump_inst(
        .en(o_jump_en),
        .clk_jump(div_res[17]),
        .i_v_init(o_jump_v_init),
        .o_height(i_jump_height),
        .o_dist(i_jump_dist),
        .o_done(i_jump_done)
    );

    // �źų�ʼ��
    initial begin
        clk_machine = 0;
        forever #5 clk_machine = ~clk_machine;
    end

    initial begin
        rst_machine = 1;
        #10 rst_machine = 0;
        i_btn = 1;

    end
endmodule
