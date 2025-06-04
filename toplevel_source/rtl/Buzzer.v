`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/19 12:58:27
// Design Name: 
// Module Name: Buzzer
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


module Buzzer(
    input clk,
    input rst_n,        //同步复位信号(低电平有效)
    input [5:0] music_scale,
    output reg beep,
    input i_load_done   //小人正确落到箱子上的标志
);
    

    parameter SPEED = 4;    //控制演奏的速度，如果是4，频率是4Hz
    //原始的clk频率是50Mhz
    parameter COUNTER_6M = 50_000_000 / 6_000_000 /2 - 1;
    parameter COUNTER_SPEED = 50_000_000 / SPEED /2 - 1;
    parameter LENGTH = 22;

    parameter REST = 16383; //也即2^14-1 用表达式表示是(1<<14)-1 注意运算符优先级 单目>算数>移位>关系>按位>逻辑

    parameter C_LOW = 16383 - (6_000_000/262/2-1);
    parameter D_LOW = 16383 - (6_000_000/294/2-1);
    parameter E_LOW = 16383 - (6_000_000/330/2-1);
    parameter F_LOW = 16383 - (6_000_000/349/2-1);
    parameter G_LOW = 16383 - (6_000_000/392/2-1);
    parameter A_LOW = 16383 - (6_000_000/440/2-1);
    parameter B_LOW = 16383 - (6_000_000/494/2-1);
    
    parameter C_MID = 16383 - (6_000_000/523/2-1);
    parameter D_MID = 16383 - (6_000_000/587/2-1);
    parameter E_MID = 16383 - (6_000_000/659/2-1);
    parameter F_MID = 16383 - (6_000_000/699/2-1);
    parameter G_MID = 16383 - (6_000_000/784/2-1);
    parameter A_MID = 16383 - (6_000_000/880/2-1);
    parameter B_MID = 16383 - (6_000_000/988/2-1);
    
    parameter C_HIGH = 16383 - (6_000_000/1047/2-1);
    parameter D_HIGH = 16383 - (6_000_000/1175/2-1);
    parameter E_HIGH = 16383 - (6_000_000/1319/2-1);
    parameter F_HIGH = 16383 - (6_000_000/1397/2-1);
    parameter G_HIGH = 16383 - (6_000_000/1568/2-1);
    parameter A_HIGH = 16383 - (6_000_000/1760/2-1);
    parameter B_HIGH = 16383 - (6_000_000/1976/2-1);
    
    reg [23:0] cnt_6m;
    reg clk_6m;
    reg playing_load_audio;
    reg [31:0] cnt_load_audio;

    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cnt_6m <= 0;
            clk_6m <= 0;
        end else if(cnt_6m == COUNTER_6M) begin
            cnt_6m <= 0;
            clk_6m <= ~clk_6m;
        end else begin
            cnt_6m <= cnt_6m + 1;
        end
    end

    reg [23:0] cnt_SPEED;
    reg [23:0] cnt_hz;
    reg clk_SPEED;

    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cnt_SPEED <= 0;
            clk_SPEED <= 0;
        end else if(cnt_SPEED == COUNTER_SPEED) begin
            cnt_SPEED <= 0;
            clk_SPEED <= ~clk_SPEED;
        end else begin
            cnt_SPEED <= cnt_SPEED + 1;
        end
    end

    reg [13:0] cnt;

    always@(posedge clk_6m or negedge rst_n) begin
        if(!rst_n || cnt_hz==REST) begin
            cnt <= 0;
            beep <= 0;
        end else if(cnt == REST) begin
            cnt <= cnt_hz;
            beep <= ~beep;
        end else begin
            cnt <= cnt + 1;
        end
    end

    //在clk_SPEED上计时，根据music_scale选择对应的音调， 当SPEED为4时，每个音调都至少持续0.25s
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            cnt_hz <= REST;
        end else begin
            
            case(music_scale)
                0: cnt_hz <= REST;
                1: cnt_hz <= C_LOW;
                2: cnt_hz <= D_LOW;
                3: cnt_hz <= E_LOW;
                4: cnt_hz <= F_LOW;
                5: cnt_hz <= G_LOW;
                6: cnt_hz <= A_LOW;
                7: cnt_hz <= B_LOW;
                8: cnt_hz <= C_MID;
                9: cnt_hz <= D_MID;
                10: cnt_hz <= E_MID;
                11: cnt_hz <= F_MID;
                12: cnt_hz <= G_MID;
                13: cnt_hz <= A_MID;
                14: cnt_hz <= B_MID;
                15: cnt_hz <= C_HIGH;
                16: cnt_hz <= D_HIGH;
                17: cnt_hz <= E_HIGH;
                18: cnt_hz <= F_HIGH;
                19: cnt_hz <= G_HIGH;
                20: cnt_hz <= A_HIGH;
                21: cnt_hz <= B_HIGH;
                default: cnt_hz <= REST;
            endcase

            if(playing_load_audio) begin
                cnt_hz <= C_LOW;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        
        if(!rst_n) begin
            playing_load_audio <= 0;
            cnt_load_audio <= 0;
        end else if(i_load_done) begin
            playing_load_audio <= 1;
            cnt_load_audio <= 0;
        end else if(playing_load_audio) begin
            if(cnt_load_audio[21]) begin
                playing_load_audio <= 0;
            end else begin
                cnt_load_audio <= cnt_load_audio + 1;
            end
        end
    end

endmodule
