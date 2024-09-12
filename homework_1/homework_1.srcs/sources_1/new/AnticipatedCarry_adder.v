`timescale 1ns / 1ps

module AnticipatedCarry_adder(A,B,CI,CO,F);
input [3:0]A,B;
input CI;
output [3:0]F;
output CO;

//reg [3:0]G,P;
//reg[3:0] i;
//wire [3:1]C;
//initial
//begin
//    for(i=0;i<=3;i=i+1)
//        G[i]=A[i]&B[i];
//        P[i]=A[i]|B[i];
//end
wire [3:1]C;

Anticipated UI1(A,B,CI,C,CO);//先行进位

//FA计算

Full_Adder XU1(
    .F(F[0]),
    .A(A[0]),
    .B(B[0]),
    .CI(CI));
Full_Adder XU2(
    .F(F[1]),
    .A(A[1]),
    .B(B[1]),
    .CI(C[1]));
Full_Adder XU3(
    .F(F[2]),
    .A(A[2]),
    .B(B[2]),
    .CI(C[2]));
Full_Adder XU4(
    .F(F[3]),
    .A(A[3]),
    .B(B[3]),
    .CI(C[3]));

endmodule


module double_adder (A,B,CI,CO,F);
    input [15:0]A,B;
    input CI;
    output [15:0]F;
    output CO;
    wire CT;
    AnticipatedCarry_adder T1(A[7:0],B[7:0],CI,CT,F[7:0]);
    AnticipatedCarry_adder T2(A[15:8],B[15:8],CT,CO,F[15:8]);
endmodule

module adder_subtracter(A,B,CI,S,CO,F)
    input [3:0]A,B;
    input CI,S;
    output [3:0]F;
    output CO;
    always @(*) 
    begin
        if(S==1)
        begin
            CI=1;
            B=~B;
        end
    end
    AnticipatedCarry_adder T3(A,B,CI,CO,F);
endmodule