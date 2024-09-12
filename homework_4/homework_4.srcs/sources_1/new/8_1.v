`timescale 1ns / 1ps

module S8_1(A,B,C,D,E,F,G,H,S,Y);
input [3:0]A,B,C,D,E,F,G,H;
input [2:0]S;
output [3:0]Y;
wire [3:0]T,U;
MUX U1(S[2],S[1:0],A,B,C,D,T);
MUX U2(!S[2],S[1:0],E,F,G,H,U);
assign Y=T|U;
endmodule
