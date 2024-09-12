`timescale 1ns / 1ps

module D_D(
input OE_,
input CLR,
input CLK,
input [7:0]D,
input reset,//·ÖÆµÆ÷µÄreset
output [7:0]Q
);
//   wire clk;
//    Divider D1(CLK,50000000,clk,reset);
    eight_D D2(OE_,CLR,CLK,D,Q);
endmodule
