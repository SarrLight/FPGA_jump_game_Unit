module statement_tb();
reg clk_machine;    // 主时钟 (25MHz)
reg rst_machine;    // 异步复位 (高有效)
reg i_btn;          // 玩家按键输入
reg i_jump_done;    // 物理引擎跳跃完成信号
reg [31:0] o_x_man;       // 小人水平坐标
reg [31:0] o_x_block1;    // 箱子1的X坐标
reg [31:0] o_x_block2;    // 箱子2的X坐标
wire [2:0]  state;          // 当前状态码
wire reload_done;       // 复位信号
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