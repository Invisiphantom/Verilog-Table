module Control (
    input  [6:0] Opcode  , // 操作码输入
    output       ALUSrc  , // ALU第二个操作数来源
    output       MemtoReg, // 写回寄存器的数据来源
    output       RegWrite, // 是否写回寄存器
    output       MemRead , // 是否从数据存储器读取数据
    output       MemWrite, // 是否向数据存储器写入数据
    output       Branch  , // 是否为分支指令
    output       Jump    , // 是否为跳转指令
    output [1:0] ALUOp   // ALU操作类型
);
    reg [8:0] control; // 控制信号寄存器
    assign {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, ALUOp} = control; // 将控制信号寄存器中的值赋给输出信号
    always @(*) begin
        case (Opcode)
            7'b0110011 : control <= 9'b001000010; // R-type
            7'b0000011 : control <= 9'b111100000; // lw-type
            7'b0100011 : control <= 9'b1x0010000; // S-type
            7'b1100011 : control <= 9'b0x0001001; // sb-type
            7'b0010011 : control <= 9'b101000011; // I-type
            7'b1100111 : control <= 9'b111xx0100; // jalr-type
            7'b1101111 : control <= 9'b111xx0100; // jal-type
            7'b0110111 : control <= 9'bxxxxxxxxx; // lui
            7'b0110111 : control <= 9'bxxxxxxxxx; // auipc
            default    : control <= 9'bxxxxxxxxx; // 未知操作码时不输出控制信号
        endcase
    end
endmodule