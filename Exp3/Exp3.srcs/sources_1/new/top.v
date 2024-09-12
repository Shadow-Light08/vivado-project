`timescale 1ns / 1ps

module top(
    input clk,                  //ʱ��Դ20MHz
    input rst,                  //��λ�ź�
    input clk_A,
    input clk_B,
    input clk_F,
    input [31:0]in,
    input rst_n,
    output [3:0] Flags,
    output [2:0] which,     //Ƭѡ���루������һλ����ܵ�����
    output [7:0] seg,        // ��ѡ�źţ�������Щ�Σ�����ʾ���Σ�
    output enable              //�������ʾʹ�ܣ�=1��ĳ����whichָ��������ܵ�����=0��ȫ��
    );
    wire [31:0] A;
    wire [31:0] B;
    wire [31:0] F;
    //���üĴ���
    register regA(.clk(clk_A),.in(in),.rst_n(rst_n),.out(A));
    register regB(.clk(clk_B),.in(in),.rst_n(rst_n),.out(B));
    register regF(.clk(clk_F),.in(F),.rst_n(rst_n),.out(F));
    //���ö๦��ALUģ��,����A��B������ͱ�־λ������
    ALU alu(A,B,in[3:0],F,Flags[0],Flags[1],Flags[2],Flags[3]);
    Display D(.clk(clk),.rst(rst),.data(F),.enable(enable),.which(which),.seg(seg));
endmodule