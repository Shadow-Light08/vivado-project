`timescale 1ns / 1ps

module Time(
input clk,
input [31:0]T
    );
reg [31:0]count=0;
always@(posedge clk)
begin
    while(count<T)
          begin
               count=count+1;
          end
end
endmodule
