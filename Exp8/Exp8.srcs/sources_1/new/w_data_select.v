`timescale 1ns / 1ps

module W_Data_Select(
    input [31:0] F,
    input [31:0] imm32,
    input [31:0] MDR,
    input [31:0] pc,
    input [1:0] w_data_s,
    output [31:0] result
    );
    reg [31:0] temp_result;
    always@(*)
    begin
        if(w_data_s == 2'b00)begin
            temp_result <= F;
        end else if (w_data_s == 2'b01)begin
            temp_result <= imm32;
        end else if(w_data_s == 2'b10)begin
            temp_result <= MDR;
        end else if(w_data_s == 2'b11)begin
            temp_result <= pc;
        end
    end
    assign result = temp_result;
    
endmodule

