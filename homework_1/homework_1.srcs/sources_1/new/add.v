`timescale 1ns / 1ps

module Full_Adder(F,CO,A,B,CI);
input A,B,CI;
output F,CO;
wire S1,T1,T2;
xor XU1(S1,A,B),//S1=A“ÏªÚB
    XU2(F,S1,CI);//F=S1“ÏªÚCI
and AU1(T1,A,B),//T1=A°§B
    AU2(T2,S1,CI);
or OU1(CO,T1,T2);
endmodule
