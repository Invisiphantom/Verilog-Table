module ALUControl (
    input      [1:0] ALUOp,       // ALU操作类型输入
    input            funct7,      // 操作码的funct7字段输入
    input      [2:0] funct3,      // 操作码的funct3字段输入
    output reg [3:0] ALU_control  // ALU控制信号输出
);
    always @(*) begin
        case (ALUOp)
            2'b00: ALU_control <= 4'b0010;  // R-type: add, sub
            2'b01: ALU_control <= 4'b0110;  // I-type: addi, slti, sltiu
            2'b10:
            case ({
                funct7, funct3
            })
                4'b0000: ALU_control <= 4'b0010;  // R-type: add
                4'b1000: ALU_control <= 4'b0110;  // R-type: sub
                4'b0100: ALU_control <= 4'b0111;  // R-type: xor
                4'b0110: ALU_control <= 4'b0001;  // R-type: or
                4'b0111: ALU_control <= 4'b0000;  // R-type: and
                4'b0001: ALU_control <= 4'b0011;  // R-type: sll
                4'b0101: ALU_control <= 4'b1000;  // R-type: srl
                4'b1101: ALU_control <= 4'b1010;  // R-type: sra
                4'b0010: ALU_control <= 4'b0100;  // I-type: slti
                4'b0011: ALU_control <= 4'b0101;  // I-type: sltiu
                default: ALU_control <= 4'bxxxx;  // 未知操作码时不输出控制信号
            endcase
            2'b11:
            casez ({
                funct7, funct3
            })
                4'bz000: ALU_control <= 4'b0010;  // I-type: addi
                4'bz100: ALU_control <= 4'b0111;  // I-type: xori
                4'bz110: ALU_control <= 4'b0001;  // I-type: ori
                4'bz111: ALU_control <= 4'b0000;  // I-type: andi
                4'b0001: ALU_control <= 4'b0011;  // I-type: slli
                4'b0101: ALU_control <= 4'b1000;  // I-type: srli
                4'b1101: ALU_control <= 4'b1010;  // I-type: srai
                4'bz010: ALU_control <= 4'b0100;  // I-type: slti
                4'bz011: ALU_control <= 4'b0101;  // I-type: sltiu
                default: ALU_control <= 4'bxxxx;  // 未知操作码时不输出控制信号
            endcase
        endcase
    end
endmodule
