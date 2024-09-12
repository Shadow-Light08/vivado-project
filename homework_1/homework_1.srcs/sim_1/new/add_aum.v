`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 11:16:05 PM
// Design Name: 
// Module Name: add_aum
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


module add_aum;
reg A,B,CI;
wire F,CO;
Full_Adder Test(F,CO,A,B,CI);
initial
begin
A=0;B=0;CI=0;
#100;
A=0;B=0;CI=1;
#100;
A=0;B=1;CI=0;
#100;
A=0;B=1;CI=1;
#100;
A=1;B=0;CI=0;
#100;
A=1;B=0;CI=1;
#100;
A=1;B=1;CI=0;
#100;
A=1;B=1;CI=1;
#100;
end
endmodule
