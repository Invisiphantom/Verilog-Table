module PCAdd #(
    parameter Width = 32  // 数据总线宽度
) (
    input [Width - 1:0] PCaddress,  // 当前指令地址输入
    input [Width - 1:0] ShiftImm,  // 移位后的立即数输入
    output [Width - 1:0] PCSum  // 分支跳转后的地址输出
);
    assign PCSum = PCaddress + ShiftImm;  // 计算分支跳转后的地址并输出
endmodule
