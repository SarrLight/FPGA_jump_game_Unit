`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/02 13:32:28
// Design Name: 
// Module Name: wechat_jump_fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module wechat_jump_fsm (
    // ���������ź�
    input  wire        clk_machine,    // ��ʱ�� (25.175MHz)
    input  wire        rst_machine,    // �첽��λ (����Ч)
    input  wire        i_btn,          // ��Ұ�������

    //��jumpģ�������
    input  wire        i_jump_done,    // ����������Ծ����ź�
    input  wire [31:0] i_jump_dist,
    input  wire [31:0] i_jump_height,
    output wire  [7:0]  o_jump_v_init,  // ��Ծ���ٶ�
    output reg         o_jump_en,       // ��������ʹ��
    
    
    // ״̬���
    output reg  [2:0]  state,          // ��ǰ״̬��
    
    // ������ݸ�graphicsģ����ź�
    output reg  [31:0] o_x_man,
    output reg  [31:0] o_y_man,
    output reg  [31:0] o_x_block1,     // ����1��X����
    output reg  [31:0] o_x_block2,     // ����2��X����
    output reg         o_en_block2,     // ����2��ʾʹ��
    output reg  [4:0]  o_type_index1, // ����1����
    output reg  [4:0]  o_type_index2, // ����2����
    /*�޸Ľ��ͣ��Ұ�ԭ����color�ĳ���type����Ϊgraphics��block�в�ͬ�����࣬ÿһ�������Ӧһ��ͼƬ*/
    //ע�������������Ч��Χ��0~5
    output wire  [2:0]  o_squeeze_man,  // С��ѹ��� (0-7)

    /*������ͣ������graphicsģ�飬��ʾ�Ƿ���ʾ�������Ϸ��������*/
    output reg o_title,
    output reg o_gameover
    
    );

    // ================= ״̬���� ================= //
    localparam INIT = 3'd0;  // ��ʼ��״̬ (����λ�ý���)
    localparam RELD = 3'd1;  // ���Ӹ�λ����
    localparam WAIT = 3'd2;  // �ȴ�����״̬
    localparam ACCU = 3'd3;  // ����״̬
    localparam JUMP = 3'd4;  // ��Ծ��״̬
    localparam LAND = 3'd5;  // ��½�ж�״̬
    localparam OVER = 3'd6;  // ��Ϸ����״̬

    // ================= �������� ================= //
    localparam ORIGIN         = 32'd0;   // ��׼ԭ������
    localparam ORIGIN_STARTUP = 32'd100;     // INIT״̬ʱ������1�ĳ�ʼ���꣬���޸�
    localparam BLOCK_WIDTH    = 32'd30;   // ��ʵ�����ӿ�ȵ�һ�룬С�������������ֵС�ڴ���˵��С����������
    localparam BLOCK2_OFFSET  = 32'd65;    // ����2����ƫ����
    localparam MAX_SQUEEZE    = 4'd14;     // ���ѹ�������ֵ����ѹ��Χ��0-14

    // ================= �ڲ��ź� ================= //
    reg  [16:0] cnt_clk_reload;       // ��λ����������
    reg  [23:0] cnt_v_init;           // ���ٶȼ�����������cnt_v_init����¼����������clk������
    //��ΪС����Ծ���ٶȺ�С�˵ļ�ѹ�̶��ж��ȹ�ϵ������ԭ���ġ�ѹ��ʱ��ʱ�Ӻͼ�������û�д��ڵı�Ҫ
    reg         reload_done;          // ��λ��ɱ�־
    wire [6:0]  random;               // ���ڽ���randomģ������������
    reg new_game;                     // �����ж��Ƿ�Ϊ����Ϸ����Ϊ����Ϸ������ʾ���⻭��


    // �����ֵ
    assign o_jump_v_init = cnt_v_init[23:17];  // ������0-255
    assign o_squeeze_man = cnt_v_init[23:20];   // ѹ���0-7

    
    //����λʱ�ı�����ʼ��
    always@(posedge rst_machine) begin
        state          <= RELD;
        o_x_block1     <= ORIGIN_STARTUP;
        o_x_block2     <= ORIGIN_STARTUP;
        o_en_block2    <= 1'b0;
        o_type_index1 <= 5'd5;
        o_type_index2 <= 5'd0;
        cnt_v_init     <= 24'd0;
        cnt_clk_reload <= 17'd0;
        o_jump_en      <= 1'b0;
        o_x_man        <= ORIGIN_STARTUP;
        o_y_man        <= 32'd0;
        new_game       <= 1'b1;
        o_title        <= 1'b1;
        o_gameover     <= 1'b0;
    end

    // ================= ״̬������ ================= //
    //����ͬ״̬֮����л�
    always @(posedge clk_machine ) begin
        if (rst_machine) begin           // ��λ�ź���Чʱ
            state <= RELD;               // ���븴λ����״̬
        end else begin                 // ��λ�ź���ʧʱ
            case (state)
                INIT: begin              
                    state <= RELD;           // INIT״̬Ĭ�Ͻ���RELD״̬
                end
                RELD: begin             // RELD״̬�£�����1���Ƶ�ָ��λ��
                    if(new_game) begin  // ��Ϊ����Ϸ�����ڴ˹�����ʾ���⻭��
                        o_title <= 1'b1;
                        new_game <= 1'b0;
                    end
                    if (reload_done || o_x_block1==ORIGIN) begin // ��λ��������ʱ������λ����ȷʱ
                        state <= WAIT;      // ����ȴ�����״̬
                    end else begin
                        state <= RELD;      // ����δ��λ��������λ����
                    end
                end
                WAIT: begin             // �ȴ�����״̬
                    if(new_game) begin
                        new_game <= 1'b0;   //��λ����������˵����������Ϸ
                        o_title <= 1'b0;   // ���ر��⻭��
                    end
                    
                    if (i_btn) begin       // ��Ұ��°���ʱ����������״̬
                        state <= ACCU;  
                    end
                end
                ACCU: begin             // ����״̬
                    if (i_btn) begin    //���°�ťʱ����һֱ����������״̬
                        state <= ACCU;
                    end begin
                        state <= JUMP;  //�ɿ���ťʱ������Ծ��״̬
                    end
                end
                JUMP: begin             // ��Ծ��״̬
                    if (i_jump_done) begin // ����������Ծ���ʱ��������½�ж�״̬
                        state <= LAND;
                    end else begin
                        state <= JUMP;      // ��Ծû�����ʱ��������Ծ��״̬
                    end
                end
                LAND: begin             // ��½�ж�״̬
                    if (o_x_man <= BLOCK_WIDTH) begin // С��δ��������ʱ
                        state <= WAIT;      // ���½��а�����Ծ
                    end else if((o_x_man < o_x_block2)?
                        (o_x_block2-o_x_man <= BLOCK_WIDTH)
                        :(o_x_man-o_x_block2 <= BLOCK_WIDTH)) begin
                        state <= INIT;      // ����λ�ý���
                    end else begin
                        state <= OVER;      // ��Ϸ����״̬
                    end
                end
                OVER: begin             // ��Ϸ����״̬
                    state <= OVER;          // ���ֵ�ǰ״̬
                    o_gameover <= 1'b1;    // ��ʾ��Ϸ��������
                end
                default: begin           // ����״̬
                    state <= RELD;          // �����ʼ��״̬
                end
            endcase
        end
    end

    /*�Ѳ�ͬ����д����ͬ��always����У���ǿ�ɶ���*/
    
    //�����������ʵ����
    random #(7) random_inst (
        .clk_random(clk_machine),
        .rst_random(rst_machine),
        .i_roll(i_btn),
        .o_random_binary(random)
    );

    //���������ӽ��п���
    always @(posedge clk_machine) begin
        if (rst_machine) begin
            o_x_block1 <= ORIGIN_STARTUP;     // ������1������2������ORIGIN_STARTUP��λ��
            o_x_block2 <= ORIGIN_STARTUP;     
            o_en_block2 <= 1'b0;              // ��������2
            reload_done <= 1'b0;             
            cnt_clk_reload <= 17'd0;          // ��λ����������
        end else begin
            case (state)
                INIT: begin
                    cnt_clk_reload <= 17'd0;
                    o_x_block1 <= o_x_block2;    // ����λ�ý���
                    o_x_block2 <= o_x_block2;    // ����λ�ò���
                    o_en_block2 <= 1'b0;
                    reload_done <= 1'b0;
                end
                RELD: begin
                    if(o_x_block1 > ORIGIN) begin       // ������1��û���ƶ���ORIGINλ��
                        if (cnt_clk_reload == 17'h1ffff) begin // �൱�ڶ�clk_machine����13�η�Ƶ
                            cnt_clk_reload <= 17'd0; // ��λ������
                            o_x_block1 <= o_x_block1 - 1; // ��������1
                        end else begin
                            cnt_clk_reload <= cnt_clk_reload + 1; // ��������1
                            o_x_block1 <= o_x_block1; // ����1λ�ò���
                        end
                        o_x_block2 <= o_x_block2;
                        o_en_block2 <= 1'b0;
                        reload_done <= 1'b0;
                    end else begin                    // ������1�Ѿ��ƶ���ORIGINλ��
                        cnt_clk_reload <= 17'd0;
                        o_x_block1 <= ORIGIN; // ��λ����1
                        o_x_block2 <= ORIGIN + random + 65; // ���ڳ�ʼƫ�������������������2��λ������
                        o_en_block2 <= 1'b1; // ��ʾ����2
                        reload_done <= 1'b1; // ��λ����ź�
                    end
                end
                default: begin
                    cnt_clk_reload <= 17'd0;
                    o_x_block1 <= o_x_block1;     // ��ʼ����
                    o_x_block2 <= o_x_block2;     // ��ʼ����
                    o_en_block2 <= o_en_block2;      // ��ʼʹ���ź�
                    reload_done <= 1'b0;             // ��λ����ź�
                end
            endcase
        end
    end
    
    // ������������п���
    always@(posedge clk_machine) begin
        case(state) 
            INIT:begin
                o_type_index1 <= o_type_index2;
                if(o_type_index2 == 5) begin        //��������ķ�Χ��0~5
                    o_type_index2 <= 0;
                end else begin
                    o_type_index2 <= o_type_index2 + 1;
                end 
            end 
            
            default:begin
                o_type_index1 <= o_type_index1;
                o_type_index2 <= o_type_index2;
            end 
        endcase
    end
    
    //���ݰ����źŸı�С����Ծ���ٶ�
    always @(posedge clk_machine) begin
        if (rst_machine) begin
            cnt_v_init <= 0;
        end else begin
            case(state)
                ACCU: begin
                    if (i_btn && cnt_v_init < 24'hffffff) begin //����cnt_v_init����¼����������clk������
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

    // ��ɫλ�ÿ���
    always@(posedge clk_machine) begin
        case (state)
            INIT: begin
                o_x_man <= o_x_block2;
                o_y_man <= 0;
            end
            
            ACCU: begin
                o_x_man <= o_x_block1;
                o_y_man <= 0;
            end
            
            JUMP: begin
                o_x_man <= i_jump_dist;
                o_y_man <= i_jump_height;
            end
            
            LAND, OVER: begin
                // ���ֵ�ǰλ��
            end
            
            default: begin
                o_x_man <= o_x_block1;
                o_y_man <= 0;
            end
        endcase
    end
            
    


endmodule