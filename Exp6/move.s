main:
         addi            a0,     zero, 0x30           #a0=0000_0030H��Դ����������ַ
         addi            a1,     zero, 0x60           #a1=0000_0060H��Ŀ������������ַ
         addi            a2,     zero, 10               #a2=0000_000AH�����Ƶ����ݸ���
         jal              BankMove                               #�ӳ������
         j end

BankMove:
          add             t0,              a0,     zero                   #t0=Դ����������ַ
          add             t1,              a1,     zero                    #t1=Ŀ������������ַ
          add             t2,              a2,     zero                    #t2=���ݿ鳤��
L1:       lw              t3,              0(t0)                                     #t3=ȡ������
          sw              t3,              0(t1)                                      #������
          addi           t0,              t0,              4                                   #�ƶ�Դ������ָ��
          addi           t1,              t1,              4                                   #�ƶ�Ŀ��������ָ��
          addi           t2,              t2,              -1                                  #����ֵ-1
          bne             t2,    zero, L1                       #����ֵ��0����û�и����꣬תѭ�����ײ�
          jr                          ra                        #������ɣ����ӳ��򷵻�
          ret
end: