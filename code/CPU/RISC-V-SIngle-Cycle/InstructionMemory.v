module InstructionMemory #(
    parameter Width = 32,  // 指令地址总线宽度
    parameter InctWidth = 32,  // 存储器数据总线宽度
    parameter InctNum = 1024  // 存储器深度
) (
    input      [    Width - 1:0] pc_address,   // 指令地址输入
    output reg [InctWidth - 1:0] instruction  // 指令输出
);

    reg [InctWidth - 1:0] inst_mem[0:InctNum - 1];  // 存储器
    initial $readmemh("/home/ethan/Verilog-Table/RISC-V-SIngle-Cycle/ROM.txt", inst_mem);  // 从文件中读取存储器初始值
    always @(*) begin
        instruction = inst_mem[pc_address[Width-1:2]]; // 根据地址获取指令，每次读取4字节
    end
endmodule
