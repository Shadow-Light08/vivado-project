`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 21:47:48
// Design Name: 
// Module Name: ImmU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module ImmU(
    input [31:0]inst,
    input [2:0] inst_Type,
    output reg[31:0]imm32
    );
    always@(*)
    begin
         case(inst_Type)
            //3'b000:imm32 <= { 27'b0 , inst[24:20]};
            3'b001:begin
                if((inst[14:12] == 3'b001) | (inst[14:12] == 3'b101))
                //移位 无符号
                    imm32 <= { 27'b0 , inst[24:20]};
                else//其他 SE32
                    imm32 <= {{20{inst[31]}} , inst[31:20]};
                
            end
            3'b010:imm32 <= {inst[31:12], 12'b0};
            
            3'b011:imm32 <= {{20{inst[31]}} , inst[31:20]};
            3'b100:imm32 <= {{20{inst[31]}}, inst[31:25], inst[11:7]};
            
            3'b101:imm32 <= {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
            3'b110:imm32 <= {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
            3'b111:imm32 <= {{20{inst[31]}} , inst[31:20]};
        endcase       
    end

endmodule
