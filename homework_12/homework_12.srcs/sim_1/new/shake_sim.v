`timescale 1ns / 1ps

module shake_sim();
reg CLK;
reg inkey;
reg reset;
reg CLR;
wire outkey;

// ʵ����Anti_Shakeģ��
Anti_Shake Test (
    .CLK(CLK), 
    .inkey(inkey), 
    .reset(reset), 
    .CLR(CLR), 
    .outkey(outkey)
);

// ʱ���ź�����
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK; // ����100MHz��ʱ���ź�
end

initial begin
    // ��ʼ��
    inkey = 0;
    reset = 1;
    CLR = 0;

    // ����ϵͳ
    #10 reset = 0;

    // ģ�ⰴ������
    #100_000 inkey = 1; // ģ�ⰴ������
    #20_000 inkey = 0;  // ģ�ⰴ���ͷ�
    #100_000 inkey = 1; // �ٴ�ģ�ⰴ������
    #100_000 inkey = 0; // �ٴ�ģ�ⰴ���ͷ�

    // ��ɲ���
    #200000 $finish;
end

endmodule

