`timescale 1ns / 1ps

module T_sim();
reg LD_,CT_,UD,CP;
reg [3:0]D;
wire [3:0]Q;
wire M,R;
Timers test(LD_,CT_,UD,CP,D,Q,M,R);
initial
begin 
LD_=0;CT_=0;UD=0;CP=0;
end
always#10 CP=~CP;
initial
begin 
    D=4'b0000;
    #10;
    //置数
    LD_=0;
    #10;
    //+
    LD_=1;
    CT_=0;
    UD=0;
    #100;
    
    //保持
    LD_=1;
    CT_=1;
    #20;
    
    D=4'b1110;
    LD_=0;
    #10;
    //++
    LD_=1;
    CT_=0;
    #50;
    
    //保持
    LD_=1;
    CT_=1;
    #20;
    
    //-
    LD_=1;
    CT_=0;
    UD=1;
    #100;
    
    //保持
    LD_=1;
    CT_=1;
    #20;
    
    D=4'b0001;
    LD_=0;
    #10;
    //--
    LD_=1;
    CT_=0;
    #50;
    
    //保持
    LD_=1;
    CT_=1;
    #20;
end
endmodule
