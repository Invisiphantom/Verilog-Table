module Registers #(
    parameter Width = 32,  // 指令地址总线宽度
	parameter RegNum = 32 // 寄存器数量
) (
    input                    clk,        // 时钟输入
    input                    RegWrite,   // 是否写寄存器
    input      [        4:0] ReadReg1,   // 读寄存器1编号
    input      [        4:0] ReadReg2,   // 读寄存器2编号
    input      [        4:0] WriteReg,   // 写寄存器编号
    input      [Width - 1:0] WriteData,  // 写入寄存器的数据
    output reg [Width - 1:0] ReadData1,  // 读寄存器1的数据输出
    output reg [Width - 1:0] ReadData2,  // 读寄存器2的数据输出
    output     [Width - 1:0] x0,         // x0输出
    output     [Width - 1:0] x1,         // x1输出
    output     [Width - 1:0] x2,         // x2输出
    output     [Width - 1:0] x3,         // x3输出
    output     [Width - 1:0] x4,         // x4输出
    output     [Width - 1:0] x5,         // x5输出
    output     [Width - 1:0] x6,          // x6输出
    output     [Width - 1:0] x7,          // x7输出
    output     [Width - 1:0] x8,          // x8输出
    output     [Width - 1:0] x9,          // x9输出
    output     [Width - 1:0] x10,         // x10输出
    output     [Width - 1:0] x11,         // x11输出
    output     [Width - 1:0] x12,         // x12输出
    output     [Width - 1:0] x13,         // x13输出
    output     [Width - 1:0] x14,         // x14输出
    output     [Width - 1:0] x15         // x15输出
);
    reg [Width - 1:0] Register[RegNum - 1:0];  // 32个32位寄存器
    initial begin
        Register[0] = 32'h0000_0000;  // 初始化x0
    end
    always @(posedge clk) begin
        if (RegWrite && (WriteReg != 5'b00000)) Register[WriteReg] <= WriteData;  // 写寄存器
    end
    always @(ReadReg1, ReadReg2) begin
        ReadData1 <= Register[ReadReg1];  // 读寄存器1
        ReadData2 <= Register[ReadReg2];  // 读寄存器2
    end
    
    assign x0 = Register[0];  // 输出x0
    assign x1 = Register[1];  // 输出x1
    assign x2 = Register[2];  // 输出x2
    assign x3 = Register[3];  // 输出x3
    assign x4 = Register[4];  // 输出x4
    assign x5 = Register[5];  // 输出x5
    assign x6 = Register[6];  // 输出x6
    assign x7 = Register[7];  // 输出x7
    assign x8 = Register[8];  // 输出x8
    assign x9 = Register[9];  // 输出x9
    assign x10 = Register[10];  // 输出x10
    assign x11 = Register[11];  // 输出x11
    assign x12 = Register[12];  // 输出x12
    assign x13 = Register[13];  // 输出x13
    assign x14 = Register[14];  // 输出x14
    assign x15 = Register[15];  // 输出x15
endmodule
