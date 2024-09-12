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
module Regs(rst_n,Reg_Write,clk_WB,W_Addr,W_Data,R_Addr_A,R_Addr_B,R_Data_A,R_Data_B);
	input rst_n,clk_WB;
    input Reg_Write;
    input [4:0]R_Addr_A;
    input [4:0]R_Addr_B;
    input [4:0]W_Addr;
    input [31:0]W_Data;
	output [31:0]R_Data_A;
    output [31:0]R_Data_B;
    reg [31:0] REG_Files[0:31]; 
    integer i;
    always@(posedge clk_WB or negedge rst_n)
   	 begin
        if(!rst_n)
            begin
                for(i = 1; i <32; i = i + 1) begin
	            REG_Files[i] <= 32'h0000_0001;
	            end
                REG_Files[0]<=32'h0000_0000;
            end
        else
                if(Reg_Write) 
                begin
                if(W_Addr!=5'b00000)
                    REG_Files[W_Addr]<=W_Data;
                end
  	  end
    assign R_Data_A=REG_Files[R_Addr_A];
    assign R_Data_B=REG_Files[R_Addr_B];
endmodule
