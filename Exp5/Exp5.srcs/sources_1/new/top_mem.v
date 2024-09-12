`timescale 1ns / 1ps

module top_mem(
    input [31:0] SW,
    input rst,
    input clk_dm,
    input clk_20M,
    output [2:0] which,          //片选编码（驱动哪一位数码管点亮）
    output [7:0] seg,            // 段选信号（点亮哪些段，以显示字形）
    output enable                //数码管显示使能，=1，某个（which指定）数码管点亮，=0，全灭
    );
    wire Mem_Write;             //读写操作，0：读；1：写
    wire [7:0] DM_Addr;         //地址输入
    wire [1:0] MW_Data_s;         //数据输入选择
    wire [1:0] Size_s;           //访问尺寸
    wire SE_s;                  //扩展方式    
    
    assign Mem_Write = SW[31];
    assign MW_Data_s = SW[30:29];
    assign Size_s = SW[28:27];
    assign SE_s = SW[26];
    assign DM_Addr = SW[7:0];
    
    reg [31:0] M_W_Data;   //数据输入
    wire [31:0] M_R_Data;  //数据输出
    
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
    
    //初始化
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
