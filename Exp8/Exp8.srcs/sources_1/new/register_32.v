`timescale 1ns / 1ps

module register_32(
    input clk,
    input rst_n,
    input [31:0] in,
    output [31:0] out
    );
    
    reg [31:0] temp;
    always@(negedge clk or posedge rst_n)
    begin
        if(rst_n) temp = 0;
        else  temp = in;
    end
    assign out = temp;
endmodule

