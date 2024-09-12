`timescale 1ns / 1ps

module Top(
    input clk,//ʱ��Դ
    input clk_20M,//�����ʱ��
    input rst_n,//reset
    input[2:0]SW,//�������ʾ
    output [3:0] FR,//��־λ��ʾ
    output enable,              //�������ʾʹ�ܣ�=1��ĳ����whichָ��������ܵ�����=0��ȫ��
    output [2:0] which,         //Ƭѡ���루������һλ����ܵ�����
    output [7:0] seg  
    );
    wire [31:0] PC;
    wire [31:0] inst;
    wire [31:0] W_Data;
    wire [31:0] A;
    wire [31:0] B;
    wire [31:0] F;
    wire [31:0] MDR;
    //����CPU
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
    //�����ѡ��
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
    //��ʾģ��
   Display display(
    .clk(clk_20M),       //ʱ��Դ20MHz
    .rst(rst_n),         //��λ�ź�
    .data(data),         //32λ����ʾ����
    .enable(enable),     //�������ʾʹ�ܣ�=1��ĳ����whichָ��������ܵ�����=0��ȫ��
    .which(which),       //Ƭѡ���루������һλ����ܵ�����
    .seg(seg)            // ��ѡ�źţ�������Щ�Σ�����ʾ���Σ�
    );
    
endmodule
 
 


