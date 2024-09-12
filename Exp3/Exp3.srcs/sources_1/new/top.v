`timescale 1ns / 1ps

module top(
    input clk,                  //时钟源20MHz
    input rst,                  //复位信号
    input clk_A,
    input clk_B,
    input clk_F,
    input [31:0]in,
    input rst_n,
    output [3:0] Flags,
    output [2:0] which,     //片选编码（驱动哪一位数码管点亮）
    output [7:0] seg,        // 段选信号（点亮哪些段，以显示字形）
    output enable              //数码管显示使能，=1，某个（which指定）数码管点亮，=0，全灭
    );
    wire [31:0] A;
    wire [31:0] B;
    wire [31:0] F;
    //调用寄存器
    register regA(.clk(clk_A),.in(in),.rst_n(rst_n),.out(A));
    register regB(.clk(clk_B),.in(in),.rst_n(rst_n),.out(B));
    register regF(.clk(clk_F),.in(F),.rst_n(rst_n),.out(F));
    //调用多功能ALU模块,包括A与B的运算和标志位的生成
    ALU alu(A,B,in[3:0],F,Flags[0],Flags[1],Flags[2],Flags[3]);
    Display D(.clk(clk),.rst(rst),.data(F),.enable(enable),.which(which),.seg(seg));
endmodule