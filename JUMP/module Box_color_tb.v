module Box_color_tb();
reg clk_machine;    // 主时钟 (25MHz)
reg rst_machine;    // 异步复位 (高有效)
reg state;        // 状态信号
wire [4:0] o_color_index1; // 箱子1颜色索引
wire [4:0] o_color_index2; // 箱子2颜色索引
Box_color uut(
    .clk_machine(clk_machine),
   .rst_machine(rst_machine),
   .state(state),
   .o_color_index1(o_color_index1),
   .o_color_index2(o_color_index2)
);
initial begin
    clk_machine = 0;
    forever #5 clk_machine = ~clk_machine;
end
initial begin
    rst_machine = 1;
    state = 0;
    #1000 rst_machine = 0;
end
endmodule