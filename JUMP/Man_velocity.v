module Man_velocity(
    input  wire        clk_machine,    // 主时钟 (25MHz)
    input  wire        rst_machine,    // 异步复位 (高有效)
    input  wire        i_btn,          // 玩家按键输入
    input  wire        i_jump_done,    // 物理引擎跳跃完成信号
    input wire  [2:0]  state,          // 当前状态码
    output reg  [7:0]  o_jump_v_init   // 跳跃初速度
);
reg  [23:0] cnt_v_init;           // 初速度计数器
localparam ACCU = 3'd3;  // 蓄力状态
localparam JUMP = 3'd4;  // 跳跃中状态
assign o_jump_v_init = cnt_v_init[23:17];
always @(posedge clk_machine) begin
    if (rst_machine) begin
        cnt_v_init <= 0;
    end else begin
        case(state)
            ACCU: begin
                if (i_btn && cnt_v_init < 24'hffffff) begin
                    cnt_v_init <= cnt_v_init + 1;
                end else begin
                    cnt_v_init <= cnt_v_init;
                end
            end
            JUMP: begin
                if (i_jump_done) begin
                    cnt_v_init <= 0;
                end else begin
                    cnt_v_init <= cnt_v_init;
                end
            end
        endcase
    end
end
endmodule
