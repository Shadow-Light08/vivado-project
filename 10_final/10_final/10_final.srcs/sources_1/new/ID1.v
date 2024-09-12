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

module ID1(inst,rs1,rs2,rd,opcode,funct3,funct7,imm32);
    input [31:0]inst;
    output [5:0]rs1,rs2,rd;
    output reg [6:0]opcode;
    output [5:0]funct3,funct7;
    output [31:0]imm32;
    reg [2:0] inst_Type;

    always @(*)
    begin
        opcode = inst[6:0];
        case(opcode)
            7'b0110011:inst_Type = 3'b000; // R型指令格式编码
            7'b0010011:inst_Type = 3'b001; // I型指令格式编码                       
            7'b0110111:inst_Type = 3'b010; // U型指令格式编码
            
            7'b0000011:inst_Type = 3'b011; // LW型指令格式编码
            7'b0100011:inst_Type = 3'b100; // SW型指令格式编码
            
            7'b1100011:inst_Type = 3'b101; // B型指令格式编码
            7'b1101111:inst_Type = 3'b110; // JAL型指令格式编码
            7'b1100111:inst_Type = 3'b111; // JALR型指令格式编码
            
        endcase       
    end
    
    ImmU uut(inst,inst_Type,imm32);
    assign rs1=inst[19:15];
    assign rs2=inst[24:20];
    assign rd=inst[11:7];
    assign funct3=inst[14:12];
    assign funct7=inst[31:25];
endmodule
