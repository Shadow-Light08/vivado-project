`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 17:50:46
// Design Name: 
// Module Name: ID2
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


module ID2(opcode,funct3,funct7,IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,IS_BEQ,IS_JAL,IS_JALR,ALU_OP);
    input [6:0]opcode;
    input [5:0]funct3;
    input [5:0]funct7;
    output reg IS_R,IS_IMM,IS_LUI;
    output reg IS_LW,IS_SW;
    output reg IS_BEQ,IS_JAL,IS_JALR;
    output reg [3:0] ALU_OP;
    always@(*)
    begin
        IS_R <= (opcode==7'b0110011)?1'b1:1'b0;
        IS_IMM <= (opcode==7'b0010011)?1'b1:1'b0;
        IS_LUI <= (opcode==7'b0110111)?1'b1:1'b0;
        
        IS_LW <= (opcode==7'b0000011)?1'b1:1'b0;
        IS_SW <= (opcode==7'b0100011)?1'b1:1'b0;
        
        IS_BEQ <= (opcode==7'b1100011)?1'b1:1'b0;
        IS_JAL <= (opcode==7'b1101111)?1'b1:1'b0;
        IS_JALR <= (opcode==7'b1100111)?1'b1:1'b0;
        
        if(opcode==7'b0110011)//IS_R=1
            ALU_OP = {funct7[5],funct3};
        if(opcode==7'b0010011)//IS_IMM=1
            ALU_OP = (funct3==3'b101) ? {funct7[5],funct3}:{1'b0,funct3};
    end
        
 
endmodule
