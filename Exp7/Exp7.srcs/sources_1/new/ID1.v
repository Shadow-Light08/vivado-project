`timescale 1ns / 1ps

module ID1 (
  input  [31:0] instr,      

  output  [4:0] rs1,   
  output  [4:0] rs2,   
  output  [4:0] rd,   
  output  [6:0] opcode,
  output  [2:0] funct3,      
  output  [6:0] funct7,      
  
  output reg [31:0] imm
);

    assign rs1 = instr[19:15]; 
    assign rs2 = instr[24:20];
    assign rd = instr[11:7]; 
    assign funct7 = instr[31:25]; 
    assign funct3 = instr[14:12]; 
    assign opcode = instr[6:0];
    
    //不同指令格式生成立即数的方法
    wire [31:0] I1imm = {27'b0,instr[24:20]};
    wire [31:0] I2imm = {{20{instr[31]}}, instr[31:20]};
    wire [31:0] Simm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    wire [31:0] Bimm = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    wire [31:0] Uimm = {instr[31:12], 12'b0};
    wire [31:0] Jimm = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};   
    reg flag;
    initial flag = 0;
    always @(*)
    begin
        case(opcode)
            7'b0110011: imm = 0;
            7'b0010011: flag = 1;
            7'b0000011: imm = I2imm;
            7'b1100111: imm = I2imm;
            7'b0100011: imm = Simm;
            7'b1100011: imm = Bimm;
            7'b1101111: imm = Jimm;
            7'b0110111: imm = Uimm;
        endcase
        if(flag)begin
            case(funct3)
                3'b001: imm = I1imm;
                3'b101: imm = I1imm;
                default: imm = I2imm;
            endcase
            flag = 0;
        end
    end
   
endmodule
