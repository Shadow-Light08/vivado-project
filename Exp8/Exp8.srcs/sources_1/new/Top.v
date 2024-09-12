`timescale 1ns / 1ps

module Top(
    input clk,//时钟源
    input clk_20M,//数码管时钟
    input rst_n,//reset
    input[2:0]SW,//数码管显示
    output [3:0] FR,//标志位显示
    output enable,              //数码管显示使能，=1，某个（which指定）数码管点亮，=0，全灭
    output [2:0] which,         //片选编码（驱动哪一位数码管点亮）
    output [7:0] seg  
    );
    wire [31:0] PC;
    wire [31:0] inst;
    wire [31:0] W_Data;
    wire [31:0] A;
    wire [31:0] B;
    wire [31:0] F;
    wire [31:0] MDR;
    //调用CPU
    CPU cpu(
    .clk(clk),
    .rst_n(rst_n),
    .FR(FR),
    .PC(PC),
    .inst(inst),
    .W_Data(W_Data),
    .A(A),
    .B(B),
    .F(F),
    .MDR(MDR)
    );
    //数码管选择
    reg [31:0]data;             
    always@(*) begin
        case(SW)
        3'b000: data = PC;
        3'b001: data = inst;      //IR
        3'b010: data = W_Data;
        3'b011: data = A;
        3'b100: data = B;
        3'b101: data = F;
        3'b110: data = MDR;
        default: data = PC;
        endcase
    end
    //显示模块
   Display display(
    .clk(clk_20M),       //时钟源20MHz
    .rst(rst_n),         //复位信号
    .data(data),         //32位待显示数据
    .enable(enable),     //数码管显示使能，=1，某个（which指定）数码管点亮，=0，全灭
    .which(which),       //片选编码（驱动哪一位数码管点亮）
    .seg(seg)            // 段选信号（点亮哪些段，以显示字形）
    );
    
endmodule
 
 


