`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 11:57:51 PM
// Design Name: 
// Module Name: FA_sum
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


module FA_sum;
reg [3:0]A,B;
reg CI;
wire [3:0]F;
wire CO;
FourBitFA Test2(A,B,CI,CO,F);
initial
begin
A=4'b0000;B=4'b0000;CI=0;//0+0
#100;
A=4'b0001;B=4'b0100;CI=0;//1+8
#100;
A=4'b0110;B=4'b1000;CI=0;//6+8
#100;
A=4'b0010;B=4'b1100;CI=0;//2+12
#100;
A=4'b0010;B=4'b0101;CI=0;//2+5
#100;
A=4'b1110;B=4'b0010;CI=0;//14+2
#100;
end
endmodule
