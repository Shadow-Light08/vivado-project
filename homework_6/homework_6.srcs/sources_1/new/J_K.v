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
	if(!S&!R)//ͬʱ���ڵ͵�ƽʱ
	begin
	    case({J,K})//J-K������
		    2'b00:Q<=Q;
			2'b01:Q<=0;
			2'b10:Q<=1;
			2'b11:Q<=~Q;
	   endcase
	end
	else if(S&!R)//�첽��λ
	   Q<=1;
	else if(!S&R)//�첽����
	   Q<=0;
	else if(S&R) //��ʱΪ����״̬���Զ���Ϊ����
	   Q<=Q;
endmodule
