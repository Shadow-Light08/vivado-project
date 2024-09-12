`timescale 1ns / 1ps

module FA(F,A,B,CI);
input A,B,CI;
output F;
assign F=A^B^CI; 
endmodule
