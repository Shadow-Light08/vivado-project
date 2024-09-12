`timescale 1ns / 1ps

module register(
    input[31:0] in,
    input clk,
    input rst_n,
    output [31:0] out
    );
    reg [31:0] tout;
    always@(negedge rst_n or posedge clk)
    begin
        if(!rst_n)
            tout <= 32'b0;
        else
            tout <= in;
    end
    assign out = tout;
endmodule