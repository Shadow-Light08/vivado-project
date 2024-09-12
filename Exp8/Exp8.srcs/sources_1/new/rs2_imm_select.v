`timescale 1ns / 1ps

module rs2_Imm_Select(
    input rs2_imm_s,
    input [31:0] B,
    input [31:0] imm32,
    output [31:0] result
    );
    
    reg [31:0] temp_result;
    always@(*)begin
        if(rs2_imm_s)begin
            temp_result <= imm32;
        end else begin
            temp_result <= B;
        end
    end
    assign result = temp_result;
endmodule



