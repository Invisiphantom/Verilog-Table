module PC #(
    parameter Width = 32 // 指令地址总线宽度
) (
    input                    clk, // 时钟输入
    input                    PCrst, // PC复位输入
    input      [Width - 1:0] PCnext, // 下一条指令地址输入
    output reg [Width - 1:0] PCaddress // 当前指令地址输出
);

    always @(posedge clk) begin
        if (PCrst == 1'b1) PCaddress <= {Width{1'b0}}; // 复位时将当前指令地址清零
    end
    always @(posedge clk) begin
        PCaddress <= PCnext; // 根据下一条指令地址更新当前指令地址
    end
endmodule