`timescale 1ns / 1ps

module J_K(S,R,J,K,CP,Q,Qn);
    input S,R;
    input J;
    input K;
    input CP;
    output Q;
    output Qn;
	reg Q=0;
	assign Qn=~Q;
	always@(negedge CP)
	if(!S&!R)//同时处于低电平时
	begin
	    case({J,K})//J-K触发器
		    2'b00:Q<=Q;
			2'b01:Q<=0;
			2'b10:Q<=1;
			2'b11:Q<=~Q;
	   endcase
	end
	else if(S&!R)//异步置位
	   Q<=1;
	else if(!S&R)//异步清零
	   Q<=0;
	else if(S&R) //此时为禁用状态，自定义为保持
	   Q<=Q;
endmodule
