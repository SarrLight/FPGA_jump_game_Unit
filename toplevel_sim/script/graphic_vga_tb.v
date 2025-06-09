`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/02 16:30:17
// Design Name: 
// Module Name: graphic_vga_tb
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


module graphic_vga_tb();

    reg clk;
    reg rst;

    //�û�����İ�ť��ǰ�ڿ����ÿ��ش��棬���÷���֮���ٻ��ɰ�ť
    reg i_bt;

    //vga�ӿ�
    wire o_vs;
    wire o_hs;
    wire [3:0] o_r;
    wire [3:0] o_g;
    wire [3:0] o_b;

    //graphicsģ�������ĵ�ǰ��ȡ���ص���ɫ�������vgaģ��
    wire [3:0] R;
    wire [3:0] G;
    wire [3:0] B;

    //��ǰ��ȡ��x��y���꣬��vgaģ������������graphicsģ��
    wire [10:0] x_read;
    wire [10:0] y_read;

    //���ݵ�ǰ״̬ȷ���Ƿ���ʾ�������Ϸ��������
    wire title;
    wire gameover;

    graphics graphics_inst(

       .clk(clk),

       //��������wechat_jump_fsm���ź�
       .i_x_block1(0),
       .i_en_block1(1'b1),
       .i_x_block2(0),
       .i_en_block2(0),
       .i_x_man(11'd0-11'd1),
       //.i_x_man(300),
       .i_y_man(0),
       .i_squeeze_man(0),
       .i_type_block1(0),
       .i_type_block2(0),
       .i_title(0),
       .i_gameover(0),

       //��vgaģ�������
       .i_x_read(x_read),
       .i_y_read(y_read),
       .o_r(R),
       .o_g(G),
       .o_b(B)
    );

    vga vga_inst(
        //��������topģ����ź�
        .clk_vga(clk),
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

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #10 rst = 0;
    end

endmodule
