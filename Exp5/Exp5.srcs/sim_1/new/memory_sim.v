`timescale 1ns / 1ps

module memory_sim();
    reg Mem_Write;             //��д������0������1��д
    reg clk_dm;
    reg [7:0] DM_Addr;         //��ַ����
    reg [31:0] M_W_Data;       //��������
    reg [1:0]Size_s;           //���ʳߴ�
    reg SE_s;                  //��չ��ʽ
    wire [31:0] M_R_Data;      //�������
  
    
    memory mem(    
        .Mem_Write(Mem_Write),         //��д������0������1��д
        .clk_dm(clk_dm),
        .DM_Addr(DM_Addr),            //��ַ���룬���������λ
        .M_W_Data(M_W_Data),
        .Size_s(Size_s),              //���ʳߴ�
        .SE_s(SE_s),                  //��չ��ʽ
        .M_R_Data(M_R_Data)           //�������
    );
    always #20 clk_dm = ~clk_dm;
    initial begin
        DM_Addr = 0;
		M_W_Data = 32'h66778899;
		Mem_Write = 1;   //��ʼ��д��
		clk_dm = 0;
		//���ֽڷ���,������
		#50;
		Size_s = 2'b00;
		Mem_Write = 0;
		
		DM_Addr = 8'b0000_0000;
		SE_s = 0;#50;SE_s = 1;
		#50;
		DM_Addr = 8'b0000_0001;
		SE_s = 0;#50;SE_s = 1;
		#50;
		DM_Addr = 8'b0000_0010;
		SE_s = 0;#50;SE_s = 1;
		#50;
		DM_Addr = 8'b0000_0011;
		SE_s = 0;#50;SE_s = 1;
		
		//���ֽڷ��ʣ�д����
		#50;
		M_W_Data = 32'h11223344;
		Size_s = 2'b00;
	    Mem_Write = 1;
	    #50;
		DM_Addr = 8'b0000_0000;
		#50;
		DM_Addr = 8'b0000_0001;
		#50;
		DM_Addr = 8'b0000_0010;
		#50;
		DM_Addr = 8'b0000_0011;
		
		//�����ַ���
		#50;
		M_W_Data = 32'h66778899;
		Mem_Write = 1;   //��ʼ��д��
		//������
        #50;
		Size_s = 2'b01;
		Mem_Write = 0;
		
        DM_Addr = 8'b0000_0000;
		SE_s = 0;#50;SE_s = 1;
		#50;
		DM_Addr = 8'b0000_0010;
		SE_s = 0;#50;SE_s = 1;
		
		//д����
		#50;
		M_W_Data = 32'h11223344;
		Size_s = 2'b00;
	    Mem_Write = 1;
	    #50;
		DM_Addr = 8'b0000_0000;
		#50;
		DM_Addr = 8'b0000_0010;
		
		//���ַ���
		#50;
		M_W_Data = 32'h66778899;
		Mem_Write = 1;   //��ʼ��д��
		//������
        #50;
		Size_s = 2'b01;
		Mem_Write = 0;
		
        DM_Addr = 8'b0000_0000;
		SE_s = 0;#50;SE_s = 1;
		#50;
		DM_Addr = 8'b0000_0010;
		SE_s = 0;#50;SE_s = 1;
		
		//д����
		#50;
		M_W_Data = 32'h11223344;
		Size_s = 2'b00;
	    Mem_Write = 1;
	    #50;
		DM_Addr = 8'b0000_0000;
		#50;
		DM_Addr = 8'b0000_0010;
        
    end
endmodule
