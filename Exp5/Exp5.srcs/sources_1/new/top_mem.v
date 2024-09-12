`timescale 1ns / 1ps

module top_mem(
    input [31:0] SW,
    input rst,
    input clk_dm,
    input clk_20M,
    output [2:0] which,          //Ƭѡ���루������һλ����ܵ�����
    output [7:0] seg,            // ��ѡ�źţ�������Щ�Σ�����ʾ���Σ�
    output enable                //�������ʾʹ�ܣ�=1��ĳ����whichָ��������ܵ�����=0��ȫ��
    );
    wire Mem_Write;             //��д������0������1��д
    wire [7:0] DM_Addr;         //��ַ����
    wire [1:0] MW_Data_s;         //��������ѡ��
    wire [1:0] Size_s;           //���ʳߴ�
    wire SE_s;                  //��չ��ʽ    
    
    assign Mem_Write = SW[31];
    assign MW_Data_s = SW[30:29];
    assign Size_s = SW[28:27];
    assign SE_s = SW[26];
    assign DM_Addr = SW[7:0];
    
    reg [31:0] M_W_Data;   //��������
    wire [31:0] M_R_Data;  //�������
    
     memory mem(
    .Mem_Write(Mem_Write),
    .clk_dm(clk_dm),
    .DM_Addr(DM_Addr),
    .M_W_Data(M_W_Data),
    .Size_s(Size_s),
    .SE_s(SE_s), 
    .M_R_Data(M_R_Data)
    );
    Display D(.clk(clk_20M),.rst(rst),.data(M_R_Data),.enable(enable),.which(which),.seg(seg));
    
    //��ʼ��
    always@(*)begin
        case(MW_Data_s)
            2'b00: M_W_Data <= 32'h66778899;
            2'b01: M_W_Data <= 32'hFFFFFFFE;
            2'b10: M_W_Data <= 32'h00000003;
            2'b11: M_W_Data <= 32'h11223344;          
            default:M_W_Data <= 32'h66778899;
        endcase
    end



endmodule
