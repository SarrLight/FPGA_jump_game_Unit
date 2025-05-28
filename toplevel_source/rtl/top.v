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
    input rst
    );

    wire [31:0] div_res;


    clkdiv clkdiv_inst(
        .clk(clk),
        .rst(),
        .div_res(div_res)
    );

    jump jump_inst(

    );

    landing_judge landing_judge_inst(

    );

    machine machine_inst(  
        
    );

    graphics graphics_inst(
    );

    vga vga_inst(
    );



endmodule
