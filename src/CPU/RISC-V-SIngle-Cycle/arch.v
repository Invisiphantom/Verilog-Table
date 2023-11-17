module arch #(
    parameter Width = 32 // 指令地址宽度、寄存器宽度、立即数宽度、数据总线宽度、
) (
    input clk, // 时钟输入
    input PCrst // PC复位输入
);
    reg  [Width - 1:0] PCnext; // 下一条指令地址
    wire [Width - 1:0] PCaddress; // 当前指令地址
    PC u_PC ( // PC模块实例化
        .clk      (clk),
        .PCrst    (PCrst),
        .PCnext   (PCnext),
        .PCaddress(PCaddress)
    );


    wire [Width - 1:0] Instruction; // 指令输出
    InstructionMemory u_InstructionMemory ( // 指令存储器模块实例化
        .pc_address (PCaddress),
        .instruction(Instruction)
    );


    wire [Width - 1:0] PCPlus4; // PC+4
    PC4Add u_PC4Add ( // PC+4模块实例化
        .PC     (PCaddress),
        .PCPlus4(PCPlus4)
    );


    wire [Width - 1:0] ShiftImm; // 移位后的立即数
    wire [Width - 1:0] PCSum; // 分支跳转后的地址
    wire [Width - 1:0] ExImm; // 扩展后的立即数
    ShiftLeft1 u_ShiftLeft1 ( // 移位模块实例化
        .In (ExImm),
        .out(ShiftImm)
    );


    PCAdd u_PCAdd ( // PC加法模块实例化
        .PCaddress(PCaddress),
        .ShiftImm (ShiftImm),
        .PCSum    (PCSum)
    );

    wire Zero; // ALU结果是否为0
    wire s_Less; // 有符号数比较结果
    wire u_Less; // 无符号数比较结果
    wire Jump; // 是否为跳转指令
    wire Branch; // 是否为分支指令
    wire Branch_jump; // 是否为分支跳转指令
    BranchJudge u_BranchJudge ( // 分支判断模块实例化
        .zero       (Zero),
        .s_less     (s_Less),
        .u_less     (u_Less),
        .Branch     (Branch),
        .funct3     (Instruction[14:12]),
        .Branch_jump(Branch_jump)
    );
    always @(*) begin
        PCnext = (Branch_jump == 1'b0 && Jump == 1'b0) ? PCPlus4 : PCSum; // 根据分支跳转和跳转指令更新下一条指令地址
    end



    wire       ALUSrc; // ALU第二个操作数来源
    wire       MemtoReg; // 写回寄存器的数据来源
    wire       RegWrite; // 是否写回寄存器
    wire       MemRead; // 是否从数据存储器读取数据
    wire       MemWrite; // 是否向数据存储器写入数据
    wire [1:0] ALUOp; // ALU操作类型
    Control u_Control ( // 控制单元模块实例化
        .Opcode  (Instruction[6:0]),
        .ALUSrc  (ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead (MemRead),
        .MemWrite(MemWrite),
        .Branch  (Branch),
        .Jump    (Jump),
        .ALUOp   (ALUOp)
    );


    wire [Width - 1:0] ReadData1; // 读取的第一个操作数
    wire [Width - 1:0] ReadData2; // 读取的第二个操作数
    wire [Width - 1:0] WriteData; // 写入寄存器的数据
    Registers u_Registers ( // 寄存器模块实例化
        .clk      (clk),
        .RegWrite (RegWrite),
        .ReadReg1 (Instruction[19:15]),
        .ReadReg2 (Instruction[24:20]),
        .WriteReg (Instruction[11:7]),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );


    ImmGen u_ImmGen ( // 立即数扩展模块实例化
        .Instruction (Instruction[Width - 1:0]),
        .Out(ExImm)
    );


    wire [3:0] ALU_control; // ALU控制信号
    ALUControl u_ALUControl ( // ALU控制单元模块实例化
        .ALUOp      (ALUOp),
        .funct7     (Instruction[30]),
        .funct3     (Instruction[14:12]),
        .ALU_control(ALU_control)
    );


    wire [Width - 1:0] ALU1; // ALU第一个操作数
    wire [Width - 1:0] ALU2; // ALU第二个操作数
    assign ALU1 = ReadData1; // ALU第一个操作数为读取的第一个操作数
    assign ALU2 = (ALUSrc == 0) ? ReadData2 : ExImm; // ALU第二个操作数为读取的第二个操作数或扩展后的立即数



    wire [Width - 1:0] ALU_result; // ALU计算结果
    ALU u_ALU ( // ALU模块实例化
        .ALU_control(ALU_control),
        .A1         (ALU1),
        .A2         (ALU2),
        .Y          (ALU_result),
        .zero       (Zero),
        .s_less     (s_Less),
        .u_less     (u_Less)
    );


    wire [Width - 1:0] MemData; // 从数据存储器读取的数据
    DataMemory u_DataMemory ( // 数据存储器模块实例化
        .clk      (clk),
        .MemWrite (MemWrite),
        .MemRead  (MemRead),
        .address  (ALU_result),
        .WriteData(ReadData2),
        .ReadData (MemData)
    );
    assign WriteData = (MemtoReg == 0) ? ALU_result : MemData; // 写回寄存器的数据为ALU计算结果或从数据存储器读取的数据
endmodule