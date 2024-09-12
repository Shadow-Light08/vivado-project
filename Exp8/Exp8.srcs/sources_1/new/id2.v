`timescale 1ns / 1ps

module id2(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output IS_R,//指令
    output IS_IMM,
    output IS_LUI,
    output IS_LW,
    output IS_SW,
    output IS_BEQ,
    output IS_JAL,
    output IS_JALR,
    output [3:0] ALU_OP
    );
    
   reg temp_IS_R;
   reg temp_IS_IMM;
   reg temp_IS_LUI;
   reg temp_IS_LW;
   reg temp_IS_SW;
   reg temp_IS_BEQ;
   reg temp_IS_JAL;
   reg temp_IS_JALR;
   reg [3:0] temp_ALU_OP;
   //根据操作码选择指令
   always@(*)begin
      if(opcode == 7'b0110011)begin
        temp_IS_R = 1;
        temp_IS_IMM = 0;
        temp_IS_LUI = 0;
        temp_ALU_OP = {funct7[5],funct3};   
        temp_IS_LW = 0;
        temp_IS_SW = 0;
        temp_IS_BEQ = 0;
        temp_IS_JAL = 0;
        temp_IS_JALR = 0;
      end 
      else if(opcode == 7'b0010011)begin
        temp_IS_R = 0;
        temp_IS_IMM = 1;
        temp_IS_LUI = 0;
        temp_ALU_OP = (funct3==3'b101) ? {funct7[5],funct3}:{1'b0,funct3};
        temp_IS_LW = 0;
        temp_IS_SW = 0;
        temp_IS_BEQ = 0;
        temp_IS_JAL = 0;
        temp_IS_JALR = 0;
      end 
      else if(opcode == 7'b0110111) begin
        temp_IS_R = 0;
        temp_IS_IMM = 0;
        temp_IS_LUI = 1;
        temp_IS_LW = 0;
        temp_IS_SW = 0;
        temp_IS_BEQ = 0;
        temp_IS_JAL = 0;
        temp_IS_JALR = 0;
      end 
      else if(opcode == 7'b0000011)begin
        temp_IS_R = 0;
        temp_IS_IMM = 0;
        temp_IS_LUI = 0;
        temp_IS_LW = 1;
        temp_IS_SW = 0;
        temp_IS_BEQ = 0;
        temp_IS_JAL = 0;
        temp_IS_JALR = 0; 
      end 
      else if(opcode == 7'b0100011)begin
        temp_IS_R = 0;
        temp_IS_IMM = 0;
        temp_IS_LUI = 0;
        temp_IS_LW = 0;
        temp_IS_SW = 1;
        temp_IS_BEQ = 0;
        temp_IS_JAL = 0;
        temp_IS_JALR = 0;
      end
      else if(opcode == 7'b1100011)begin
        temp_IS_R = 0;
        temp_IS_IMM = 0;
        temp_IS_LUI = 0;
        temp_IS_LW = 0;
        temp_IS_SW = 0;
        temp_IS_BEQ = 1;
        temp_IS_JAL = 0;
        temp_IS_JALR = 0;
      end
      else if(opcode == 7'b1101111)begin
        temp_IS_R = 0;
        temp_IS_IMM = 0;
        temp_IS_LUI = 0;
        temp_IS_LW = 0;
        temp_IS_SW = 0;
        temp_IS_BEQ = 0;
        temp_IS_JAL = 1;
        temp_IS_JALR = 0;
      end
      else if(opcode == 7'b1100111)begin
        temp_IS_R = 0;
        temp_IS_IMM = 0;
        temp_IS_LUI = 0;
        temp_IS_LW = 0;
        temp_IS_SW = 0;
        temp_IS_BEQ = 0;
        temp_IS_JAL = 0;
        temp_IS_JALR = 1;
      end
      else begin
        temp_IS_R = 0;
        temp_IS_IMM = 0;
        temp_IS_LUI = 0;
        temp_IS_LW = 0;
        temp_IS_SW = 0;
        temp_IS_BEQ = 0;
        temp_IS_JAL = 0;
        temp_IS_JALR = 0;
      end
   end
    
   assign IS_R = temp_IS_R;
   assign IS_IMM = temp_IS_IMM;
   assign IS_LUI = temp_IS_LUI;
   assign ALU_OP = temp_ALU_OP;
   assign IS_LW = temp_IS_LW;
   assign IS_SW = temp_IS_SW;
   assign IS_BEQ = temp_IS_BEQ;
   assign IS_JAL = temp_IS_JAL;
   assign IS_JALR = temp_IS_JALR;
    
 endmodule


