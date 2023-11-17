module ShiftLeft1 #(
    parameter Width = 32 // 立即数宽度
) (
    input  [Width -1:0] In, // 输入
    output [Width -1:0] out // 输出
);

    assign out = In << 1; // 将输入左移1位并输出
endmodule