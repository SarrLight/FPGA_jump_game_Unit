module graphics(
    input       clk,                    //ʱ���ź�

    //������machine������
    input       [10:0]i_x_block1,        //����1��x����
    input       i_en_block1,            //����1�Ƿ���ʾ
    input       [10:0]i_x_block2,        //����2��x����
    input       i_en_block2,            //����2�Ƿ���ʾ
    input       [10:0]i_x_man,           //�����x����
    input       [10:0]i_y_man,           //�����y����
    input       [3:0]i_squeeze_man,     //�����ѹ���̶� 0~14 ��Ӧѹ��0~100%
    input       [3:0]i_type_block1,     //����1��ͼ������ 0~5
    input       [3:0]i_type_block2,     //����2��ͼ������ 0~5
    input       i_gameover,             //�Ƿ���Ϸ����
    input       i_title,                //�Ƿ���ʾ��Ϸ����

    //������vga������
    input       [10:0]i_x_read,          //���ڶ�ȡ��x����
    input       [10:0]i_y_read,          //���ڶ�ȡ��y����
    
    //���ݸ�vga��������ֱ������ǰ��ȡ�����ص��rgbֵ
    output   reg   [3:0]o_r,
    output   reg   [3:0]o_g,
    output   reg   [3:0]o_b
    );

    wire [16:0] addr_img_jump; 
    wire [16:0] addr_ani_jump_0_14;
    wire [11:0] dout_ani_jump_0_14;

    wire [16:0] addr_x_img_jump;
    wire [16:0] addr_y_img_jump;

    wire [14:0] addr_x_img_block1;
    wire [14:0] addr_y_img_block1;
    wire [14:0] addr_x_img_block2;
    wire [14:0] addr_y_img_block2;

    wire [17:0] addr_img_block1;
    wire [11:0] dout_img_block1;

    wire [17:0] addr_img_block2;
    wire [11:0] dout_img_block2;

    wire [16:0] addr_img_title;
    wire [11:0] dout_img_title;

    wire [16:0] addr_x_img_title;
    wire [16:0] addr_y_img_title;

    wire [16:0] addr_x_img_gameover;
    wire [16:0] addr_y_img_gameover;

    wire [16:0] addr_img_gameover;
    wire [11:0] dout_img_gameover;

    wire [11:0] dout_img_gameover_mark;

    wire [10:0]  screen_x_man;
    wire [10:0]  screen_y_man;
    wire [10:0]  screen_x_block1;
    wire [10:0]  screen_y_block1;
    wire [10:0]  screen_x_block2;
    wire [10:0]  screen_y_block2;

    wire [14:0] addr_img_block1_mark;
    wire [14:0] addr_img_block2_mark;

    wire [11:0] dout_img_block1_mark;
    wire [11:0] dout_img_block2_mark;

    wire [11:0] dout_ani_jump_mark_0_14;

    wire en_block1;
    wire en_block2;
    wire en_man;
    wire en_title;
    wire en_gameover;

    //������Ϊʲô�Ǵ���0�����Ǵ��ڵ����㣬��Ϊ0��ʱ�������ͼ������һ��clk��dout���������԰���������
    assign en_block1 = i_en_block1 && addr_x_img_block1>15'd0 && addr_x_img_block1<15'd180 
        && addr_y_img_block1>=15'd0 && addr_y_img_block1<15'd180;
    assign en_block2 = i_en_block2 && addr_x_img_block2>15'd0 && addr_x_img_block2<15'd180 
        && addr_y_img_block2>=15'd0 && addr_y_img_block2<15'd180;
    assign en_man = addr_x_img_jump>=17'd0 && addr_x_img_jump<17'd50 
        && addr_y_img_jump>17'd0 && addr_y_img_jump<17'd100;
    assign en_title = i_title && addr_x_img_title>0 && addr_x_img_title<493 
        && addr_y_img_title>0 && addr_y_img_title<144;
    assign en_gameover = i_gameover && addr_x_img_gameover>0 && addr_x_img_gameover<433 
        && addr_y_img_gameover>0 && addr_y_img_gameover<109;

    //������������ת����ani_jump_0_14�ĵ�ַ
    //man����Ļ�����Ӧ��img_jump�ĵ�ַ�ǣ�25��91��
    assign addr_x_img_jump = {6'd0,i_x_read-screen_x_man+11'd25};
    assign addr_y_img_jump = {6'd0,i_y_read-screen_y_man+11'd91};
    assign addr_img_jump =  addr_y_img_jump*17'd50
        + addr_x_img_jump;
    //ani_jump_0_14ÿһ֡����������5000�����ص㣨50*100��
    //i_squeeze_man=0��14 �ֱ�����0֡�͵�14֡���Ӳ�ѹ������ȫѹ��
    assign addr_ani_jump_0_14 = i_squeeze_man*17'd5000 + addr_img_jump;
    
    //������������ת����img_block�ϵĵ�ַ
    //block1����Ļ�����Ӧ��img_block1�ĵ�ַ�ǣ�108��71��
    
    assign addr_x_img_block1 = {4'd0,i_x_read-screen_x_block1+11'd108};
    assign addr_y_img_block1 = {4'd0,i_y_read-screen_y_block1+11'd71};
    assign addr_x_img_block2 = {4'd0,i_x_read-screen_x_block2+11'd108};
    assign addr_y_img_block2 = {4'd0,i_y_read-screen_y_block2+11'd71};


    assign addr_img_block1_mark = addr_y_img_block1*15'd180 
        + addr_x_img_block1;
    assign addr_img_block2_mark = addr_y_img_block2*15'd180 
        + addr_x_img_block2;

    assign addr_img_block1 =  i_type_block1*18'd32400 + {3'd0,addr_img_block1_mark};
    assign addr_img_block2 =  i_type_block2*18'd32400 + {3'd0,addr_img_block2_mark};

    assign addr_x_img_title = {7'd0,i_x_read-10'd72};
    assign addr_y_img_title = {7'd0,i_y_read-10'd43};

    assign addr_x_img_gameover = {7'd0,i_x_read-10'd103};
    assign addr_y_img_gameover = {7'd0,i_y_read-10'd65};

    assign addr_img_title =  addr_y_img_title*17'd493 + addr_x_img_title;
    assign addr_img_gameover =  addr_y_img_gameover*17'd433 + addr_x_img_gameover;

    //��man��block1��block2������ת������Ļ����
    assign screen_x_man = 11'd237+i_x_man;
    assign screen_y_man = (i_x_man[9]==1'b1) ? (11'd337-i_y_man+(~i_x_man +11'd1)*11'd4/11'd7) : (11'd337-i_y_man-i_x_man*11'd4/11'd7);

    assign screen_x_block1 = 11'd237+i_x_block1;
    assign screen_y_block1 = 11'd337-i_x_block1*4/7;

    assign screen_x_block2 = 11'd237+i_x_block2;
    assign screen_y_block2 = 11'd337-i_x_block2*4/7;


    ani_jump_0_14 ani_jump_0_14_inst(
        .clka(clk),
        //.ena(en_man),               //��ʹ��ʹ���ź��������ӳ�
        .addra(addr_ani_jump_0_14),
        .douta(dout_ani_jump_0_14)
    );

    ani_jump_mark_0_14 ani_jump_mark_0_14_inst(
        //.ena(en_man),               //��ʹ��ʹ���ź��������ӳ�
        .clka(clk),
        .addra(addr_ani_jump_0_14),
        .douta(dout_ani_jump_mark_0_14)
    );

    img_block_0_5 img_block_0_5_inst(
        .clka(clk),
        //.ena(en_block1),
        .addra(addr_img_block1),
        .douta(dout_img_block1),
        .clkb(clk),
        //.enb(en_block2),
        .addrb(addr_img_block2),
        .doutb(dout_img_block2)
    );

    img_block_mark img_block_mark_inst(
        .clka(clk),
        //.ena(en_block1),
        .addra(addr_img_block1_mark),
        .douta(dout_img_block1_mark),
        .clkb(clk),
        //.enb(en_block2),
        .addrb(addr_img_block2_mark),
        .doutb(dout_img_block2_mark)
    );

    img_title img_title_inst(
        .clka(clk),
        //.ena(en_title),
        .addra(addr_img_title),
        .douta(dout_img_title)
    );

    img_gameover img_gameover_inst(
        .clka(clk),
        //.ena(en_gameover),
        .addra(addr_img_gameover[15:0]),
        .douta(dout_img_gameover)
    );

    img_gameover_mark img_gameover_mark_inst(
        .clka(clk),
        .addra(addr_img_gameover[15:0]),
        .douta(dout_img_gameover_mark)
    );

    always@(posedge clk) begin
        
        //���λ��Ʋ�ͬ��ͼ�㣬���ߵ�ͼ���ѵͲ��ͼ�㸲�ǵ�


        //��һ�㣺��ɫ�ı���
        {o_r, o_g, o_b} <= 12'hfff;
        

        //�ڶ��㣺����2��Զ�������ӣ�
        if(en_block2 && dout_img_block2_mark[3:0]>4'h5) begin
            {o_r, o_g, o_b}<=dout_img_block2;
        end

        //�����㣺����1�����������ӣ�
        if(en_block1 && dout_img_block1_mark[3:0]>4'h5) begin
            {o_r, o_g, o_b}<=dout_img_block1;
        end

        //���Ĳ㣺����
        if(en_man && dout_ani_jump_mark_0_14[3:0]>4'h5) begin 
            {o_r, o_g, o_b}<=dout_ani_jump_0_14;
        end

        //����㣺 ����һ��������
        if(en_title) begin
            {o_r, o_g, o_b}<=dout_img_title;
        end else if(en_gameover && dout_img_gameover_mark[3:0]>4'h5) begin       //�����㣺����Ϸ����������
            {o_r, o_g, o_b}<=dout_img_gameover;
        end
        

    end


endmodule