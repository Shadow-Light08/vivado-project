`timescale 1ns / 1ps

module PC0(
    input clk,
    input PC0_Write,
    input [31:0] pc,
    output [31:0]PC0_out
    );
    
    reg [31:0] temp;
    always@(negedge clk)
    begin
        if(PC0_Write)temp = pc;
    end
    assign PC0_out = temp;
    
endmodule
