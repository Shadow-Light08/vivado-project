`timescale 1ns / 1ps

module Divider(

input clk,
input [31:0]div_factor,
output reg out,
input reset
);

 reg [31:0] count=0;  // 32��???????????

always @(posedge clk) 
begin
    if(reset == 0)//����������Ϊ0������Ϊreset=0ʱ����
    begin
        out<=0; 
        count<=0;
    end
    else if (count >= div_factor) 
    begin
        out <= ~out;
        count <= 0;
    end 
    else
     begin
        count <= count + 1;
    end
end
endmodule
