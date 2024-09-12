`timescale 1ns / 1ps

module D_sim();
reg clk;
reg [7:0]D;
reg OE_,CLR;
wire [7:0]Q;
eight_D test(OE_,CLR,clk,D,Q);
    initial 
    begin
        clk=0;OE_=0;CLR=0;D=8'b10101010;
    end
    always#50 clk=~clk;
    initial 
    begin
    //����
        OE_=0;
        CLR=1;
        #100;
    //���ֺ�����
        OE_=0;
        CLR=0;
        #150;
        D=8'b00011110;
        #150;
    //����״̬
        D=8'b10101010;
        OE_=1;
        #100;
    //�ٴ�����
        OE_=0;
        CLR=1;
        #100;
    //�ٴα��ֺ�����
        D=8'b00011110;
        OE_=0;
        CLR=0;
        #150;
        D=8'b00011110;
        #150;
    end
endmodule
