module vga(
    //�����vgaģ���ʱ��Ƶ����25MHz
	input		clk_vga,
    //����ĸ�λ�źţ�����Ч
	input 		rst_vga,
	//�����RGB����ֵ
	input 		[3:0]	i_r,
	input 		[3:0]	i_g,
	input 		[3:0] 	i_b,
	//�����ǰ��ȡ�����ص����Ļ���꣬ģ���ⲿ�����������������RGBֵ, x����ˮƽ����y����ֱ����
	output reg	[10:0]	o_x,
	output reg	[10:0] 	o_y,
	//����Ĵ�ֱͬ���źţ�topģ�齫���������vga�ӿ�
	output		o_vga_vs,
	output 		o_vga_hs,
	//�����RGB����ֵ��topģ���н���Щֵ�����vga�ӿ�
	output 	reg	[3:0]	o_vga_r,
	output 	reg	[3:0]	o_vga_g,
	output 	reg	[3:0]	o_vga_b
    );

    //��ʵ�����Ļ�ֱ�����640*480�� ��Ӧ��ˮƽɨ������Ϊ800����ֱɨ������Ϊ525��
    //���ź�ʱ�����أ��� ͬ��96 LEFT_PORCH:48 ��Чͼ��640  RIGHT_PORCH:16 ��ɨ������800
    //���ź�ʱ���������� ͬ��2 TOP_PORCH:33  ��Чͼ��480  BUTTON_PORCH:10 ��ɨ������525
    //��ͬ������ͬ���ź�Ϊ�͵�ƽ������Ϊ�ߵ�ƽ
    
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
    
    //�����м������м���
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

        //�����RGBֵ
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

    //����Ĵ�ֱͬ���źź�ˮƽͬ���ź�
    assign o_vga_hs = hcnt >= H_SYNC_PW;
    assign o_vga_vs = vcnt >= V_SYNC_PW;

    

 
    
endmodule