module Box_position_tb();
reg clk_machine;    // 主时钟 (25MHz)
reg rst_machine;    // 异步复位 (高有效)
reg i_btn;          // 玩家按键输入
reg state;      // 当前状态
wire [31:0] o_x_block1;    // 箱子1的X坐标
wire [31:0] o_x_block2;    // 箱子2的X坐标
wire [31:0] o_en_block2;   // 箱子2的使能信号
wire reload_done;      // 复位完成信号
wire [16:0] cnt_clk_reload;       // 复位动画计数器 
Box_position uut(
    .clk_machine(clk_machine),
   .rst_machine(rst_machine),
   .i_btn(i_btn),
   .random(random),
   .state(state),
   .o_x_block1(o_x_block1),
   .o_x_block2(o_x_block2),
   .o_en_block2(o_en_block2),
   .reload_done(reload_done),
   .cnt_clk_reload(cnt_clk_reload)
);
initial begin
    clk_machine = 0;
    forever #5 clk_machine = ~clk_machine;
end
initial begin
    rst_machine = 1;
    #1000 rst_machine = 0;
end
initial begin
    i_btn = 0;
    #100 i_btn = 1;
    state = 0;
    #100 state = 1;
    #100 state = 0;
    #100 state = 1;
end
endmodule
   