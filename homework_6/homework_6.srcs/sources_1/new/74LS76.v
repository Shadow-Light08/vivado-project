`timescale 1ns / 1ps

module J_K_74LS76(S1,R1,J1,K1,CP1,CP2,Q1,Qn1,S2,R2,J2,K2,Q2,Qn2,reset1,reset2);
input J1,K1,CP1,CP2,J2,K2,S1,R1,S2,R2,reset1,reset2;
output  Q1,Qn1,Q2,Qn2;

//wire CP1,CP2;
////ÏÈ½«CP·ÖÆµ
//Divider D1(CP,50000000,CP1,reset1);
//Divider D2(CP,25000000,CP2,reset2);

J_K U1(S1,R1,J1,K1,CP1,Q1,Qn1);
J_K U2(S2,R2,J2,K2,CP2,Q2,Qn2);

endmodule
