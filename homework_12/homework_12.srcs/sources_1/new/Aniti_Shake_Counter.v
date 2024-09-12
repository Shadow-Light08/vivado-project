`timescale 1ns / 1ps

module Aniti_Shake_Counter(
//计数器
input LD_,
input CT_,
input UD,
input CLK,//时钟
input CP,//按键时钟
input [3:0]D,

output [3:0]Q,
output M,
output R,

//按键消抖
input reset,//分频器清零键
input CLR//复位
    );
    
wire out;
//wire inkey;//按键开关

//消抖
Anti_Shake T1(
.CLK(CLK),//时钟
.inkey(CP),//按键开关
.reset(reset),
.CLR(CLR),//复位
.outkey(out)//消抖后按键开关
    );
    
//计数
Counter T2(
.LD_(LD_),
.CT_(CT_),
.UD(UD),
.CP(out),
.D(D),
.Q(Q),
.M(M),
.R(R)
    );

endmodule
