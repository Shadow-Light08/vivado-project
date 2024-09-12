`timescale 1ns / 1ps

module FourBitFA(A,B,CI,CO,F);
input [3:0]A,B;
output [3:0]F;
input CI;
output CO;
wire [3:1]C;

Full_Adder FA0(F[0],C[1],A[0],B[0],CI),
            FA1(F[1],C[2],A[1],B[1],C[1]),
            FA2(F[2],C[3],A[2],B[2],C[2]),
            FA3(F[3],CO,A[3],B[3],C[3]); 
endmodule

