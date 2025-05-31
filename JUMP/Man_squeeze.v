module Man_squeeze(
    input  wire        clk_machine,    // 主时钟 (25MHz)
    input  wire        rst_machine,    // 异步复位 (高有效)
    input  wire [2:0]  state,          // 当前状态码
    output wire        o_squeeze_man,    // 压缩度计数器输出
);
wire [19:0] cnt_clk_squeeze;  // 时钟计数器
wire [3:0] cnt_squeeze;       // 压缩度计数器
wire clk_squeeze;            // 时钟信号

assign o_squeeze_man = cnt_squeeze[3:1]; 
assign clk_squeeze = cnt_clk_squeeze[19];
always @(posedge clk_machine) begin
    if (rst_machine) begin
        cnt_clk_squeeze <= 0;
    end else begin
        cnt_clk_squeeze <= cnt_clk_squeeze + 1;
    end
end
always @(posedge clk_squeeze) begin 
    if (rst_machine) begin
        cnt_squeeze <= 0;
    end else begin 
        case (state)
            ACCU:
            if (cnt_squeeze < 4'b1111) begin
                cnt_squeeze <= cnt_squeeze + 1;
            end else begin
                cnt_squeeze <= cnt_squeeze;
            end
            default:
                cnt_squeeze <= 0;
        endcase
    end
end
endmodule