`timescale 1ns / 1ps

module Divider(

input clk,
input [31:0]div_factor,
output reg out,
input reset
);

 reg [31:0] count=0;  // 32λ???????????

always @(posedge clk) 
begin
    if(reset == 0)//按键，按下为0，故设为reset=0时重置
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
