`timescale 1ns / 1ps

module register_heap_top(
    input clk,
    input Reg_Write,
    input clk_WB,
    input clk_RR,
    input clk_F,
    input rst_n,
    input [4:0] R_Addr_A,
    input [4:0] R_Addr_B,
    input [4:0] W_Addr,
    input [3:0] ALU_OP,
    output [3:0] FR,
    output [2:0] which,     //片选编码（驱动哪一位数码管点亮）
    output [7:0] seg,        // 段选信号（点亮哪些段，以显示字形）
    output enable              //数码管显示使能，=1，某个（which指定）数码管点亮，=0，全灭
    );
    wire [31:0] temp_A;
    wire [31:0] temp_B;
    wire [31:0] temp_F;
    wire [31:0] F;
    reg [31:0] reg_F;
    reg [31:0] A;
    reg [31:0] B;

    register_heap u_reg(
        .Reg_Write(Reg_Write),
        .clk_Regs(clk_WB),
        .rst_n(rst_n),
        .R_Addr_A(R_Addr_A),
        .R_Addr_B(R_Addr_B),
        .W_Addr(W_Addr),
        .W_Data(F),
        .R_Data_A(temp_A),
        .R_Data_B(temp_B)
    );
    
    always@(posedge clk_RR)begin
        A <= temp_A;
        B <= temp_B;
    end
    
    always@(posedge clk_F)begin
        reg_F <= temp_F;
    end
    assign F = reg_F;
    
    ALU u_alu(
    .A(A),
    .B(B),
    .ALU_OP(ALU_OP),
    .F(temp_F),
    .ZF(FR[0]),
    .SF(FR[1]),
    .CF(FR[2]),
    .OF(FR[3])
    );
    Display D(.clk(clk),.rst(rst_n),.data(F),.enable(enable),.which(which),.seg(seg));
endmodule