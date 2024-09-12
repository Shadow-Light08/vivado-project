`timescale 1ns / 1ps

module Divider(
input clk,
output reg out,
input reset
);

 reg [31:0] count;  // 32位计数器初始化

always @(posedge clk or posedge reset) 
begin
    if(reset)
    begin
        out<=0; 
        count<=0;
    end
    else 
    begin
        if (count >= 50) //计50个 10ns（100MHz的周期）翻转一次
        begin
            out <= ~out;
            count <= 0;
        end 
        else
        begin
            count <= count + 1;
        end
    end
end
endmodule
