`timescale 1ns / 1ps

module Counter(
input LD_,
input CT_,
input UD,
input CP,
input [3:0]D,
output reg [3:0]Q,
output reg M,
output R
    );
// 定义最大值和最小值
parameter MAX = 4'b1111;
parameter MIN = 4'b0000;
    always@(posedge CP or negedge LD_)
    begin
        if(!LD_)
            Q<=D;
        else if(!CT_)
        begin
        if(UD)//-
            begin
            if(Q==MIN)
                begin
                Q<=Q-1;
                M<=1;
                end
            else if(Q<MIN)
                begin
                Q<=MAX;
                M<=0;
                end
            else 
                begin
                Q<=Q-1;
                M<=0;
                end
             end
        else//+
            begin
            if(Q==MAX)
                begin
               Q<=Q+1;
                M<=1;
                end
            else if(Q>MAX)
                begin
                Q<=MIN;
                M<=0;
                end
            else
               begin
                M<=0;
                Q<=Q+1;
                end
            end
        end
    end
    assign R=CP|CT_|~M;
endmodule
