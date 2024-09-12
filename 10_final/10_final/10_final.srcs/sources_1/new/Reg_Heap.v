`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 21:46:06
// Design Name: 
// Module Name: Reg_Heap
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module Reg_Heap(
    input rst_n,
    input Reg_Write,
    input clk_Regs,
    input [4:0]W_Addr,
    input [31:0]W_Data,
    input [4:0]R_Addr_A,R_Addr_B,
    output [31:0]R_Data_A,R_Data_B
    );
    reg [31:0] REG_Files[0:31];
    integer i;
    always @(posedge clk_Regs or negedge rst_n)
    begin
        if(!rst_n) //低电平有效，=0则初始化
            //初始化32个寄存器
            begin
            for(i = 0; i <32; i = i + 1) begin
	           REG_Files[i] <= 32'h0000_0001;
            end
            REG_Files[1]<=32'h0000_0003;
            REG_Files[2]<=32'h0000_0607;
            end
        else
        begin //clk上跳沿
         if(Reg_Write) //电平信号
           REG_Files[W_Addr] <= W_Data;
           //写入寄存器;
        end
    end
    
    assign R_Data_A = (R_Addr_A==5'd0)?32'd0:REG_Files[R_Addr_A];
    assign R_Data_B = (R_Addr_B==5'd0)?32'd0:REG_Files[R_Addr_B];
endmodule
