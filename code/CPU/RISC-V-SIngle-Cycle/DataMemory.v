module DataMemory #(
    parameter Width  = 32,   // 数据总线宽度
    parameter MemNum = 512   // 内存单元数量
) (
    input                    clk,        // 时钟输入
    input                    MemWrite,   // 是否写内存
    input                    MemRead,    // 是否读内存
    input      [Width - 1:0] address,    // 内存地址
    input      [Width - 1:0] WriteData,  // 写入内存的数据
    output reg [Width - 1:0] ReadData    // 读出内存的数据
);
    reg [Width - 1:0] mem[MemNum - 1:0]; // MemNum个Width位内存单元
    always @(*) begin
        if (MemRead == 1'b1) ReadData <= mem[address]; // 读内存
        else if (MemWrite == 1'b1) mem[address] = WriteData; // 写内存
    end
endmodule