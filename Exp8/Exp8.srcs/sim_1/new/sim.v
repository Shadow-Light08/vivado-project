`timescale 1ns / 1ps

module sim();
    reg rst_n;
    wire [3:0] FR;
    wire [31:0] PC;
    wire [31:0] inst;
    wire [31:0] W_Data;
    wire [31:0] A;
    wire [31:0] B;
    wire [31:0] F;
    wire [31:0] debug;
    wire [4:0] Next_ST;
    wire [31:0] pc;
    reg PC_Write;
    reg IR_Write;
    reg clk_im;
    
    Top u1(
    clk_im,
    rst_n,
    FR,
    FR,
    PC,
    inst,
    W_Data,

    Next_ST,
    );
    
     initial begin
        PC_Write = 1;
        IR_Write = 1;
        clk_im = 0;
    end
    
    always #40 begin
        clk_im = ~clk_im;
    end
endmodule
