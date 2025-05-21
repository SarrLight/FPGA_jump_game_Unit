`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/14 13:24:56
// Design Name: 
// Module Name: tmp_sim
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


module tmp_sim();
    reg [3:0]in;
    reg [3:0]out;
    wire [11:0]dout_ani_jump_0_14;
    wire [11:0]dout_img_block1;
    wire [11:0]dout_img_block2;
    reg [3:0]o_r;
    reg [3:0]o_g;
    reg [3:0]o_b;

    assign dout_ani_jump_0_14 = 12'h333;
    assign dout_img_block1 = 12'h111;
    assign dout_img_block2 = 12'h222;


    always @(*) begin
        //第一层：白色的背景
        {o_r, o_g, o_b} <= 12'hfff;
        

        //第二层：箱子2（远处的箱子）
        if(in==1) begin
            {o_r, o_g, o_b}=dout_img_block2;
        end

        //第三层：箱子1（近处的箱子）
        if(in==1) begin
            {o_r, o_g, o_b}=dout_img_block1;
        end

        //第四层：人物
        if(in==2) begin 
            {o_r, o_g, o_b}=dout_ani_jump_0_14;
        end

        //第五层： “跳一跳”标题
        if(in==2) begin
            {o_r, o_g, o_b}=12'h888;
        end else if(in==3) begin       //第六层：“游戏结束”标题
            {o_r, o_g, o_b}=12'h000;
        end
    end

    initial begin
        in=1;
        #10 
        in=2;
        #10 
        in=3;
        #10 
        $finish;
    end

endmodule
