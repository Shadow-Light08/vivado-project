`timescale 1ns / 1ps

module test();
    
    reg clk;
    reg rst_n;
    wire [3:0] FR;
    wire [31:0] PC;
    wire [31:0] inst;
    wire [31:0] W_Data;
    wire [31:0] A;
    wire [31:0] B;
    wire [31:0] F;
    wire [31:0]MDR;
    CPU test(
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
    
    always #3 clk = ~clk;
    
    initial begin
        clk = 0;
        rst_n = 1;
        #1
        rst_n = 0;
        #1
        rst_n = 1;
        #100
        rst_n = 0;
    end
    
    
endmodule