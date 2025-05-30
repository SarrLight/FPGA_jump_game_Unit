module Man_velocity_tb();
reg clk_machine;    // 主时钟 (25MHz)
reg rst_machine;    // 异步复位 (高有效)
reg i_btn;          // 玩家按键输入
reg i_jump_done;    // 物理引擎跳跃完成信号
reg  [2:0]  state;          // 当前状态码
wire [7:0]  o_jump_v_init;   // 跳跃初速度

Man_velocity uut (
    .clk_machine(clk_machine),
    .rst_machine(rst_machine),
    .i_btn(i_btn),
    .i_jump_done(i_jump_done),
    .state(state),
    .o_jump_v_init(o_jump_v_init)
);

initial begin
    clk_machine = 0;
    forever #5 clk_machine = ~clk_machine;
end

initial begin
    rst_machine = 1;
    #10 rst_machine = 0;
end

initial begin
    i_btn = 0;
    i_jump_done = 0;
    state = 0;
    #10 i_btn = 1;
    #10 i_btn = 0;
    #50 i_btn = 1;
    #50 i_btn = 0;
    #100 i_btn = 1;
    #100 i_btn = 0;
    #200 i_btn = 1;
    #200 i_btn = 0;
    state = 1;
    #100 i_jump_done = 0;
    #100 i_jump_done = 1;
end

endmodule
