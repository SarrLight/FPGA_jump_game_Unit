`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/28 17:08:09
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input rst,

    //�û�����İ�ť��ǰ�ڿ����ÿ��ش��棬���÷���֮���ٻ��ɰ�ť
    input i_bt,

    //vga�ӿ�
    output wire o_vs,
    output wire o_hs,
    output wire [3:0] o_r,
    output wire [3:0] o_g,
    output wire [3:0] o_b

    );


    //��Ƶ���ķ�Ƶ���
    wire [31:0] div_res;
    //С�˵�x��y����
    wire [9:0] x_man;
    wire [9:0] y_man;
    //block1��block2��x����
    wire [9:0] x_block1;
    wire [9:0] x_block2;
    //block1��block2�����ͣ���Ч��Χ��0-5
    wire [3:0] type_block1;
    wire [3:0] type_block2;

    wire en_block2;

    //С�˵�ѹ���̶ȣ���Ч��Χ��0-14 ��Ӧѹ��0~100%
    wire [3:0] squeeze_man;

    //��ǰ��ȡ��x��y���꣬��vgaģ������������graphicsģ��
    wire [9:0] x_read;
    wire [9:0] y_read;

    //graphicsģ�������ĵ�ǰ��ȡ���ص���ɫ�������vgaģ��
    wire [3:0] R;
    wire [3:0] G;
    wire [3:0] B;

    //���ݵ�ǰ״̬ȷ���Ƿ���ʾ�������Ϸ��������
    wire title;
    wire gameover;


    //��Ծ�������ź�
    wire jump_done;
    //С����Ծ�ĸ߶ȣ���Ч��Χ�ݲ�ȷ��
    wire [8:0] jump_height;
    //С����Ծ�ľ��룬��Ч��Χ�ݲ�ȷ��
    wire [10:0] jump_dist;
    //С����Ծ�ĳ�ʼ�ٶȣ���Ч��Χ�ݲ�ȷ��
    wire [7:0] jump_v_init; 

    //32λ�ļ���������Ϊ��Ƶ��
    clkdiv clkdiv_inst(
        .clk(clk),
        .rst(rst),
        .div_res(div_res)
    );


    jump jump_inst(
        .en(jump_en),
        .clk_jump(div_res[18]),      //�˴���Ƶ���������ʵ���������
        .i_v_init(jump_v_init),
        .o_height(jump_height),
        .o_dist(jump_dist),
        .o_done(jump_done)
    );

    wechat_jump_fsm wechat_jump_fsm_inst(  
        //��������top���ź�
        .clk_machine(div_res[1]),
        .rst_machine(rst),  //�첽��λ������Ч
        .i_btn(i_bt),

        //������ݸ�graphicsģ����ź�
        .o_x_man(x_man),
        .o_y_man(y_man),
        .o_x_block1(x_block1),
        .o_x_block2(x_block2),
        .o_type_block1(type_block1),
        .o_type_block2(type_block2),
        .o_en_block2(en_block2),
        .o_squeeze_man(squeeze_man),
        .o_title(title),
        .o_gameover(gameover),

        //��jumpģ�������
        .o_jump_en(jump_en),
        .o_jump_v_init(jump_v_init),
        .i_jump_dist(jump_dist),
        .i_jump_height(jump_height),
        .i_jump_done(jump_done)

    );

    graphics graphics_inst(

       .clk(div_res[1]),

       //��������wechat_jump_fsm���ź�
       .i_x_block1(x_block1),
       .i_en_block1(1'b1),
       .i_x_block2(x_block2),
       .i_en_block2(en_block2),
       .i_x_man(x_man),
       .i_y_man(y_man),
       .i_squeeze_man(squeeze_man),
       .i_type_block1(type_block1),
       .i_type_block2(type_block2),
       .i_title(title),
       .i_gameover(gameover),

       //��vgaģ�������
       .i_x_read(x_read),
       .i_y_read(y_read),
       .o_r(R),
       .o_g(G),
       .o_b(B)
    );

    vga vga_inst(
        //��������topģ����ź�
        .clk_vga(div_res[1]),
        .rst_vga(rst),  //ͬ����λ������Ч
        
        //��graphicsģ�������
        .i_r(R),
        .i_g(G),
        .i_b(B),
        .o_x(x_read),
        .o_y(y_read),

        //��top��vga�ӿ��ź�
        .o_vga_vs(o_vs),
        .o_vga_hs(o_hs),
        .o_vga_r(o_r),
        .o_vga_g(o_g),
        .o_vga_b(o_b)
    );



endmodule
