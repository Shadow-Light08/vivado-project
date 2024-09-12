`timescale 1ns / 1ps

module Antticipated_sum;
reg [3:0]A,B;
reg CI;
wire [3:0]F;
wire CO;
AnticipatedCarry_adder Test3(A,B,CI,CO,F);
initial
begin
//不含低位进位
A=4'b0000;B=4'b0000;CI=0;//0+0
#100;
A=4'b0001;B=4'b0100;CI=0;//1+8
#100;
A=4'b0110;B=4'b1000;CI=0;//6+8
#100;
A=4'b0010;B=4'b0101;CI=0;//2+5
#100;
A=4'b1110;B=4'b0010;CI=0;//14+2
#100;
//含低位进位
A=4'b0000;B=4'b0000;CI=1;//0+0+1
#100;
A=4'b0001;B=4'b0100;CI=1;//1+8+1
#100;
A=4'b0110;B=4'b1000;CI=1;//6+8+1
#100;
A=4'b0010;B=4'b0101;CI=1;//2+5+1
#100;
A=4'b1110;B=4'b0010;CI=1;//14+2+1
end
endmodule