module BranchJudge (
    input      zero, // ALU计算结果是否为0
    input      s_less, // 有符号数比较结果
    input      u_less, // 无符号数比较结果
    input      Branch, // 是否为分支指令
    input [2:0] funct3, // 分支指令的funct3字段
    output reg Branch_jump // 是否为分支跳转指令
);
    always @(*) begin
        if(Branch == 1'b0) Branch_jump = 1'b0; // 非分支指令时不跳转
        else case(funct3[2:1])
            2'b00   : Branch_jump = ((funct3[0] ^ zero) == 1'b1) ? 1'b1 : 1'b0; // beq: funct3==000 && zero==1    bne: funct3==001 && zero==0
            2'b10   : Branch_jump = ((funct3[0] ^ s_less) == 1'b1) ? 1'b1 : 1'b0; // blt: funct3==100 && s_less==1    bge: funct3==101 && s_less==0
            2'b11   : Branch_jump = ((funct3[0] ^ u_less) == 1'b1) ? 1'b1 : 1'b0; // bltu: funct3==110 && u_less==1    bgeu: funct3==111 && u_less==0
            default : Branch_jump = 0; // 不是分支指令时不跳转
        endcase
    end
endmodule