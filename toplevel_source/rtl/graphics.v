module graphics(
    input       clk,                    //时钟信号

    //来自于machine的输入
    input       [10:0]i_x_block1,        //箱子1的x坐标
    input       i_en_block1,            //箱子1是否显示
    input       [10:0]i_x_block2,        //箱子2的x坐标
    input       i_en_block2,            //箱子2是否显示
    input       [10:0]i_x_man,           //人物的x坐标
    input       [10:0]i_y_man,           //人物的y坐标
    input       [3:0]i_squeeze_man,     //人物的压缩程度 0~14 对应压缩0~100%
    input       [3:0]i_type_block1,     //箱子1的图像种类 0~5
    input       [3:0]i_type_block2,     //箱子2的图像种类 0~5
    input       i_gameover,             //是否游戏结束
    input       i_title,                //是否显示游戏标题

    //来自于vga的输入
    input       [10:0]i_x_read,          //正在读取的x坐标
    input       [10:0]i_y_read,          //正在读取的y坐标
    
    //传递给vga的输出，分别输出当前读取的像素点的rgb值
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

    //解释我为什么是大于0而不是大于等于零，因为0的时候输出的图形由上一个clk的dout决定，所以把他舍弃了
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

    //将读到的坐标转换到ani_jump_0_14的地址
    //man的屏幕坐标对应到img_jump的地址是（25，91）
    assign addr_x_img_jump = {6'd0,i_x_read-screen_x_man+11'd25};
    assign addr_y_img_jump = {6'd0,i_y_read-screen_y_man+11'd91};
    assign addr_img_jump =  addr_y_img_jump*17'd50
        + addr_x_img_jump;
    //ani_jump_0_14每一帧的数据量是5000个像素点（50*100）
    //i_squeeze_man=0和14 分别代表第0帧和第14帧，从不压缩到完全压缩
    assign addr_ani_jump_0_14 = i_squeeze_man*17'd5000 + addr_img_jump;
    
    //将读到的坐标转换到img_block上的地址
    //block1的屏幕坐标对应到img_block1的地址是（108，71）
    
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

    //将man，block1，block2的坐标转换到屏幕坐标
    assign screen_x_man = 11'd237+i_x_man;
    assign screen_y_man = (i_x_man[9]==1'b1) ? (11'd337-i_y_man+(~i_x_man +11'd1)*11'd4/11'd7) : (11'd337-i_y_man-i_x_man*11'd4/11'd7);

    assign screen_x_block1 = 11'd237+i_x_block1;
    assign screen_y_block1 = 11'd337-i_x_block1*4/7;

    assign screen_x_block2 = 11'd237+i_x_block2;
    assign screen_y_block2 = 11'd337-i_x_block2*4/7;


    ani_jump_0_14 ani_jump_0_14_inst(
        .clka(clk),
        //.ena(en_man),               //不使用使能信号来避免延迟
        .addra(addr_ani_jump_0_14),
        .douta(dout_ani_jump_0_14)
    );

    ani_jump_mark_0_14 ani_jump_mark_0_14_inst(
        //.ena(en_man),               //不使用使能信号来避免延迟
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
        
        //依次绘制不同的图层，更高的图层会把低层的图层覆盖掉


        //第一层：白色的背景
        {o_r, o_g, o_b} <= 12'hfff;
        

        //第二层：箱子2（远处的箱子）
        if(en_block2 && dout_img_block2_mark[3:0]>4'h5) begin
            {o_r, o_g, o_b}<=dout_img_block2;
        end

        //第三层：箱子1（近处的箱子）
        if(en_block1 && dout_img_block1_mark[3:0]>4'h5) begin
            {o_r, o_g, o_b}<=dout_img_block1;
        end

        //第四层：人物
        if(en_man && dout_ani_jump_mark_0_14[3:0]>4'h5) begin 
            {o_r, o_g, o_b}<=dout_ani_jump_0_14;
        end

        //第五层： “跳一跳”标题
        if(en_title) begin
            {o_r, o_g, o_b}<=dout_img_title;
        end else if(en_gameover && dout_img_gameover_mark[3:0]>4'h5) begin       //第六层：“游戏结束”标题
            {o_r, o_g, o_b}<=dout_img_gameover;
        end
        

    end


endmodule