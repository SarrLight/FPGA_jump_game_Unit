module vga(
    //输入给vga模块的时钟频率是25MHz
	input		clk_vga,
    //输入的复位信号，高有效
	input 		rst_vga,
	//输入的RGB三个值
	input 		[3:0]	i_r,
	input 		[3:0]	i_g,
	input 		[3:0] 	i_b,
	//输出当前读取的像素点的屏幕坐标，模块外部根据这个坐标来传递RGB值, x代表水平方向，y代表垂直方向
	output reg	[10:0]	o_x,
	output reg	[10:0] 	o_y,
	//输出的垂直同步信号，top模块将它们输出给vga接口
	output		o_vga_vs,
	output 		o_vga_hs,
	//输出的RGB三个值，top模块中将这些值输出到vga接口
	output 	reg	[3:0]	o_vga_r,
	output 	reg	[3:0]	o_vga_g,
	output 	reg	[3:0]	o_vga_b
    );

    //本实验的屏幕分辨率是640*480， 对应的水平扫描周期为800，垂直扫描周期为525，
    //行信号时序（像素）： 同步96 LEFT_PORCH:48 有效图像640  RIGHT_PORCH:16 行扫描周期800
    //列信号时序（行数）： 同步2 TOP_PORCH:33  有效图像480  BUTTON_PORCH:10 列扫描周期525
    //在同步区域，同步信号为低电平，否则为高电平
    
    localparam H_SYNC_PW = 96;
    localparam H_L_PORCH = 48;
    localparam H_VISIBLE = 640;
    localparam H_R_PORCH = 16;
    localparam H_TOTAL_WIDTH = 800;

    localparam V_SYNC_PW = 2;
    localparam V_T_PORCH = 33;
    localparam V_VISIBLE = 480;
    localparam V_B_PORCH = 10;
    localparam V_TOTAL_HEIGHT = 525;

    
    reg rgb_en;
    reg [9:0] hcnt;
    reg [9:0] vcnt;
    
    //进行行计数和列计数
    always @(posedge clk_vga) begin
    	if(rst_vga) begin
            vcnt <= 10'b0;
    		hcnt <= 10'b0;
        end else if(hcnt == H_TOTAL_WIDTH-1 && vcnt == V_TOTAL_HEIGHT-1) begin
            hcnt <= 10'b0;
            vcnt <= 10'b0;
        end else if(hcnt == H_TOTAL_WIDTH-1) begin
            hcnt <= 10'b0;
            vcnt <= vcnt + 10'b1;
        end else begin
            vcnt <= vcnt;
            hcnt <= hcnt + 10'b1;
        end

        //输出的RGB值
        o_vga_r <= rgb_en ? i_r : 4'b0;
        o_vga_g <= rgb_en ? i_g : 4'b0;
        o_vga_b <= rgb_en ? i_b : 4'b0;
        
    end

    always @(*) begin
        if(rst_vga) begin
            o_x <= 11'b0;
            o_y <= 11'b0;
            rgb_en <= 1'b0;
        end else if(hcnt >= H_SYNC_PW+H_L_PORCH && hcnt < H_SYNC_PW+H_L_PORCH+H_VISIBLE 
        && vcnt >= V_SYNC_PW+V_T_PORCH && vcnt < V_SYNC_PW+V_T_PORCH+V_VISIBLE) begin
            o_x <= hcnt - (H_SYNC_PW+H_L_PORCH);
            o_y <= vcnt - (V_SYNC_PW+V_T_PORCH);
            rgb_en <= 1'b1;
        end else begin
            rgb_en <= 1'b0;
        end
    end

    //输出的垂直同步信号和水平同步信号
    assign o_vga_hs = hcnt >= H_SYNC_PW;
    assign o_vga_vs = vcnt >= V_SYNC_PW;

    

 
    
endmodule