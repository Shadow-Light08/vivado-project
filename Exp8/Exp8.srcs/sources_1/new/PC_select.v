`timescale 1ns / 1ps

module PC_select(
    input [1:0] PC_s,
    input [31:0] origin_pc,
    input [31:0] jal_pc,
    input [31:0] jalr_pc,
    output [31:0] new_pc
    );
    
    reg [31:0] temp;
    always@(*)
    begin
        if(PC_s == 2'b00)//×ÔÔö
            temp = origin_pc;
        else if(PC_s == 2'b01)//jar
            temp = jal_pc;
        else if(PC_s == 2'b10)//jalr
            temp = jalr_pc;    
    end
    assign new_pc = temp;
    
endmodule