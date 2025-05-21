`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/13 22:25:10
// Design Name: 
// Module Name: ip_sim
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


module ip_sim();
    reg clk;
    reg rst;
    wire [31:0] addr;
    wire [11:0] dout_ani_jump_0_14;

    clkdiv clkdiv_inst(
       .clk(clk),
       .rst(rst),
       .div_res(addr)
    );

    ani_jump_0_14 ani_jump_0_14_inst(
        .clka(clk),
        .addra(addr[16:0]),
        .douta(dout_ani_jump_0_14)
    );

    initial begin
      clk = 0;
      forever #1 clk = ~clk;
    end

    initial begin
        rst = 1;
        #10 rst = 0;
    end
        



endmodule
