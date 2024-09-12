`timescale 1ns / 1ps

module J_K_sim();
reg J,K,CP,S,R;
wire Q,Qn;
J_K test(S,R,J,K,CP,Q,Qn);

always
begin
	#10 CP = ~CP;
end

initial
begin
    CP=0;
	J=1'b0;
	K=1'b0;
	S=1'b0;
	R=1'b0;
	#30 J = 1'b0; K = 1'b1;    //这30ns内，由于q处于保持状态，且q没有初始值，所以此时间段内q值应该处于不确定状态，
	                           //当过了这30ns后，时钟上升沿到来，q值被置0；
	#20 J = 1'b1; K = 1'b0;    //q值被置1;
	#20 J = 1'b1; K = 1'b1;    //q值翻转为0；
	#20 J = 1'b1; K = 1'b0;    //q值被置1；
	
	#20 S=1'b1;R=1'b0;//异步置位
	#20 J = 1'b1; K = 1'b0;    //q值被置1;
	#20 J = 1'b1; K = 1'b1;    //q值翻转为0；
	#20 J = 1'b1; K = 1'b0;    //q值被置1；
	
	#20 S=1'b0;R=1'b1;//异步清零
	#20 J = 1'b1; K = 1'b0;    //q值被置1;
	#20 J = 1'b1; K = 1'b1;    //q值翻转为0；
	#20 J = 1'b1; K = 1'b0;    //q值被置1；
end
endmodule
