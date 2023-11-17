module MuxLut #(
    parameter KEY_LEN = 1,  //键的bit长度
    parameter DATA_LEN = 1,  //值的bit长度
    parameter ITEM_NUM = 2,  //查找表的条项数
    parameter HAS_DEFAULT = 1  //是否使用默认输出
) (
    input [KEY_LEN-1:0] key,  //输入的待匹配键
    input [DATA_LEN-1:0] default_out,  //默认输出
    input [ITEM_NUM*(KEY_LEN + DATA_LEN)-1:0] lut,  //查找表
    output reg [DATA_LEN-1:0] out  //输出
);

    localparam PAIR_LEN = KEY_LEN + DATA_LEN;  //键值对的长度
    wire [PAIR_LEN-1:0] pair_list[ITEM_NUM-1:0];  //键值对数组
    wire [ KEY_LEN-1:0] key_list [ITEM_NUM-1:0];  //键数组
    wire [DATA_LEN-1:0] data_list[ITEM_NUM-1:0];  //值数组

    generate
        for (genvar n = 0; n < ITEM_NUM; n = n + 1) begin
            assign pair_list[n] = lut[PAIR_LEN*(n+1)-1 : PAIR_LEN*n];//将查找表中的条项剥离到键值对数组中
            assign key_list[n]  = pair_list[n][PAIR_LEN-1:DATA_LEN];//将键值对数组中的键剥离到键数组
            assign data_list[n] = pair_list[n][DATA_LEN-1:0];//将键值对数组中的值剥离到值数组
        end
    endgenerate

    integer i;
    reg hit;  //是否命中
    reg [DATA_LEN-1 : 0] lut_out;
    always @(*) begin
        lut_out = 0;
        hit = 0;
        for (i = 0; i < ITEM_NUM; i++) begin
            lut_out = lut_out | ({DATA_LEN{key == key_list[i]}} & data_list[i]);//查找表的匹配输出
            hit = hit | (key == key_list[i]);  //记录是否成功命中
        end
        if (!HAS_DEFAULT)
            out = lut_out;  //如果没有启用默认值，就直接采用查找表的输出
        else
            out = (hit ? lut_out : default_out);//如果启用了默认值并且没有命中，那就采用默认值
    end

endmodule


module MuxLut_tb;
    parameter KEY_LEN = 2;  //键的bit长度
    parameter DATA_LEN = 4;  //值的bit长度
    parameter ITEM_NUM = 3;  //查找表的条项数
    parameter HAS_DEFAULT = 1;  //是否使用默认输出

    reg [KEY_LEN-1:0] key;  //输入的待匹配键
    reg [DATA_LEN-1:0] default_out;  //默认输出
    reg [ITEM_NUM*(KEY_LEN + DATA_LEN)-1:0] lut;  //查找表
    wire [DATA_LEN-1:0] out;  //输出

    initial begin
        key = 2'b00;
        default_out = 2'bxx;
        lut = {{2'b00, 4'hF}, {2'b01, 4'hD}, {2'b10, 4'hB}};

        #10 begin
            key = 2'b01;
        end

        #10 begin
            key = 2'b10;
        end

        #10 begin
            key = 2'b11;
        end

        #10 begin
            
        end
    end



    MuxLut #(
        .KEY_LEN    (KEY_LEN),
        .DATA_LEN   (DATA_LEN),
        .ITEM_NUM   (ITEM_NUM),
        .HAS_DEFAULT(HAS_DEFAULT)
    ) u_MuxLut (
        .key        (key),
        .default_out(default_out),
        .lut        (lut),
        .out        (out)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars;
    end
endmodule
