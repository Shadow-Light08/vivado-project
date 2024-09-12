`timescale 1ns / 1ps

module Anti_Shake(
input CLK,//ʱ��
input inkey,//��������
input reset,
input CLR,//��λ
output reg outkey
    );

    // ��������
    parameter RESET_DELAY = 100; // ϵͳ��λ�����ʱ, 1��s��100=100��s
    parameter SHAKE_DELAY = 10_000; // �������˵���ʱ //10ms
    
    //����
    wire  L2H_Sig,H2L_Sig;
    wire clk;
    reg [19:0] reset_counter;      // ϵͳ��λ��ʱ������
    reg [19:0] debounce_counter;   // ����������ʱ������
    reg stable;               // �ȶ��İ���״̬
    reg L2H_F1, L2H_F2;           // L2H�źŵ������Ĵ���
    reg H2L_F1, H2L_F2;           // H2L�źŵ������Ĵ���
    assign L2H_Sig=L2H_F1^L2H_F2;
    assign H2L_Sig=H2L_F1^H2L_F2;
    Divider D(CLK,clk,reset);//��100MHz��ƵΪ1MHz
    
    initial 
    begin
    reset_counter = 0;
    debounce_counter = 0;
    stable = 0;
    L2H_F1 = 0;
    L2H_F2 = 0;
    H2L_F1 = 0;
    H2L_F2 = 0;
    outkey = 0;
    end

    always@(posedge clk or posedge CLR)
    begin
        if(CLR)//��λ
        begin
            reset_counter <= RESET_DELAY;
            L2H_F1 <= 0;
            L2H_F2 <= 0;
            H2L_F1 <= 0;
            H2L_F2 <= 0;
            stable <= 0;
        end
        else if(reset_counter > 0)//��λ��ʱ
        begin
            reset_counter <= reset_counter - 1;
        end
        else//��λ����ʱ��������ʼ����
        begin
            // ���¼Ĵ���
            L2H_F2 <= L2H_F1;
            L2H_F1 <= inkey;
            H2L_F2 <= H2L_F1;
            H2L_F1 <= inkey;
            
             // ��ⶶ��
            if ((L2H_Sig) || (H2L_Sig)) 
            begin
                // �ж�����������ʱ
                debounce_counter <= SHAKE_DELAY;
            end 
            else if (debounce_counter > 0) 
            begin
                // ����������ʱ
                debounce_counter <= debounce_counter - 1;
            end 
            else 
            begin
                // �ȶ�״̬���������
                stable <= L2H_F1;
                outkey <= stable;
            end
        end
    end    
endmodule
