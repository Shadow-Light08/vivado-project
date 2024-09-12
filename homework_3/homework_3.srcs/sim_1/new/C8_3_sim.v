`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2023 09:57:42 AM
// Design Name: 
// Module Name: C8_3_sim
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


module C8_3_sim();
reg [7:0]in;
reg E;
wire [3:0]out;
wire done;
C8_3 Test(in,E,out,done);
initial
begin 
    //不工�?
    //输出 000�?0
    in=8'b01010101;E=1;
    #100;
    in=8'b01000110;E=1;
    #100;
    //工作
    //输出 000�?1
    in=8'b10000000;E=0;
    #100;
    in=8'b10001100;E=0;
    #100;
    in=8'b11001001;E=0;
    #100;
    //输出 010 1
    in=8'b00100000;E=0;
    #100;
    in=8'b00100110;E=0;
    #100;
    //输出 110�?1
    in=8'b00000010;E=0;
    #100;
    in=8'b00000011;E=0;
    #100;
    //输出 111�?1
    in=8'b00000001;E=0;
    #100;
end
endmodule
