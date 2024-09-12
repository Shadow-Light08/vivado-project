`timescale 1ns / 1ps

module Aniti_Shake_Counter(
//������
input LD_,
input CT_,
input UD,
input CLK,//ʱ��
input CP,//����ʱ��
input [3:0]D,

output [3:0]Q,
output M,
output R,

//��������
input reset,//��Ƶ�������
input CLR//��λ
    );
    
wire out;
//wire inkey;//��������

//����
Anti_Shake T1(
.CLK(CLK),//ʱ��
.inkey(CP),//��������
.reset(reset),
.CLR(CLR),//��λ
.outkey(out)//�����󰴼�����
    );
    
//����
Counter T2(
.LD_(LD_),
.CT_(CT_),
.UD(UD),
.CP(out),
.D(D),
.Q(Q),
.M(M),
.R(R)
    );

endmodule
