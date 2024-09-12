`timescale 1ns / 1ps

module IR(
    input IR_Write,
    input clk_im,
    input [31:0] Inst_Code,
    output [31:0] instr
    );
    
    reg [31:0] ir;
    always@(negedge clk_im)
    begin
        if(IR_Write)ir = Inst_Code;
    end
    assign instr = ir;
endmodule
