module ImmGen #(
    parameter Width = 32  // 指令宽度、立即数宽度
) (
    input      [Width - 1:0] Instruction, // 指令输入
    output reg [Width - 1:0] Out // 立即数输出
);
    always @(*) begin
        case (Instruction[6:0])
            7'b0010011: Out <= {{(Width - 12) {Instruction[31]}}, Instruction[31:20]};  // I-type addi
            7'b0000011: Out <= {{(Width - 12) {Instruction[31]}}, Instruction[31:20]};  // I-type load
            7'b1100111: Out <= {{(Width - 12) {Instruction[31]}}, Instruction[31:20]};  // I-type jalr
            7'b0100011: Out <= {{(Width - 12) {Instruction[31]}}, Instruction[31:25], Instruction[11:7]};  // S-type
            7'b1100011: Out <= {{(Width - 12) {Instruction[31]}}, Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8]};  // B-type
            7'b1101111: Out <= {{(Width - 20) {Instruction[31]}}, Instruction[31], Instruction[19:12], Instruction[20], Instruction[30:21]};  // J-type
            default: Out <= {Width{1'h0}};
        endcase
    end
endmodule
