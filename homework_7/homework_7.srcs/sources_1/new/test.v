`timescale 1ns / 1ps
module test(input cp,output Q3,Q2,Q1,Q0 );
reg d3,d2,d1,d0;
reg q3,q2,q1,q0;
wire q0_,q1_,q2_,q3_;
D D0(cp,d0,Q0,q0_);
D D1(cp,d1,Q1,q1_);
D D2(cp,d2,Q2,q2_);
D D3(cp,d3,Q3,q3_);
always@(posedge cp)
begin
    d3<=q0_+q1_&q2;
    d0<=q1;
    d1<=q2;
    d2<=q3;
    q0<=Q0;
    q1<=Q1;
    q2<=Q2;
    q3<=Q3;
end
assign q3_=~q3;
assign q2_=~q2;
assign q1_=~q1;
assign q0_=~q0;
endmodule