`timescale 1ns / 1ps

module D_74_sim();
reg CR_,CP;
reg [1:0]S;
reg Sr,Sl;
reg [7:0]D;
wire [7:0]Q;

D_74LS198 test(CR_,CP,S,Sr,Sl,D,Q);

//初始化
initial 
begin
    CR_=0;CP=0;S=2'b00;Sr=0;Sl=0;#20;
end

always #10 CP=~CP;

initial
begin 
//清零
CR_=1;
#20;
//置数
CR_=0;
D=8'b10010011;
S=2'b11;
#50
//左移
CR_=1;
Sl=1;
S=2'b10;
#25
Sl=0;
#25;
//右移
Sr=1;
S=2'b01;
#25;
Sr=0;
#25;
end
endmodule
