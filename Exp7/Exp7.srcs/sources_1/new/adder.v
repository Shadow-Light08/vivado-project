`timescale 1ns / 1ps

module adder(
    input [31:0] pc,
    output [31:0] new_pc
    );
    reg [31:0] A = 0;
    always@(*)
    begin
        A = pc + 4;
    end
    assign new_pc = A;
    
endmodule
