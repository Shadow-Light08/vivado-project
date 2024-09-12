`timescale 1ns / 1ps

module memory_sim();
    reg Mem_Write;             //读写操作，0：读；1：写
    reg clk_dm;
    reg [7:0] DM_Addr;         //地址输入
    reg [31:0] M_W_Data;       //数据输入
    reg [1:0]Size_s;           //访问尺寸
    reg SE_s;                  //扩展方式
    wire [31:0] M_R_Data;      //数据输出
  
    
    memory mem(    
        .Mem_Write(Mem_Write),         //读写操作，0：读；1：写
        .clk_dm(clk_dm),
        .DM_Addr(DM_Addr),            //地址输入，忽略最低两位
        .M_W_Data(M_W_Data),
        .Size_s(Size_s),              //访问尺寸
        .SE_s(SE_s),                  //扩展方式
        .M_R_Data(M_R_Data)           //数据输出
    );
    always #20 clk_dm = ~clk_dm;
    initial begin
        DM_Addr = 0;
		M_W_Data = 32'h66778899;
		Mem_Write = 1;   //初始化写入
		clk_dm = 0;
		//按字节访问,读操作
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
		
		//按字节访问，写操作
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
		
		//按半字访问
		#50;
		M_W_Data = 32'h66778899;
		Mem_Write = 1;   //初始化写入
		//读操作
        #50;
		Size_s = 2'b01;
		Mem_Write = 0;
		
        DM_Addr = 8'b0000_0000;
		SE_s = 0;#50;SE_s = 1;
		#50;
		DM_Addr = 8'b0000_0010;
		SE_s = 0;#50;SE_s = 1;
		
		//写操作
		#50;
		M_W_Data = 32'h11223344;
		Size_s = 2'b00;
	    Mem_Write = 1;
	    #50;
		DM_Addr = 8'b0000_0000;
		#50;
		DM_Addr = 8'b0000_0010;
		
		//按字访问
		#50;
		M_W_Data = 32'h66778899;
		Mem_Write = 1;   //初始化写入
		//读操作
        #50;
		Size_s = 2'b01;
		Mem_Write = 0;
		
        DM_Addr = 8'b0000_0000;
		SE_s = 0;#50;SE_s = 1;
		#50;
		DM_Addr = 8'b0000_0010;
		SE_s = 0;#50;SE_s = 1;
		
		//写操作
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
