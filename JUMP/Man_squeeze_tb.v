module Man_squeeze_tb();
reg clk_machine;   // 主时钟 (25MHz)
reg rst_machine;    // 异步复位 (高有效)
reg [2:0]state;          // 当前状态码
wire o_squeeze_man;    // 压缩度计数器输出

Man_squeeze uut (
    .clk_machine(clk_machine),
    .rst_machine(rst_machine),
    .state(state),
    .o_squeeze_man(o_squeeze_man)
);

initial begin
    clk_machine = 0;
    forever #5 clk_machine = ~clk_machine;
end

initial begin
    rst_machine = 1;
    #20 rst_machine = 0;
end

initial begin
    state = 3;
end
endmodule
    