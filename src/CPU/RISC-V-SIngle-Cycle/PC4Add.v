module PC4Add #(
    parameter Width = 32 // 指令地址宽度
) (
    input  [Width - 1:0] PC, // 当前指令地址输入
    output [Width - 1:0] PCPlus4 // PC+4输出
);
    assign PCPlus4 = PC + 4; // 计算PC+4
endmodule