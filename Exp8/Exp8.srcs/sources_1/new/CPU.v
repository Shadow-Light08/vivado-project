`timescale 1ns / 1ps

module CPU(
    input clk,
    input rst_n,
    output [3:0] FR,
    output [31:0] PC,
    output [31:0] inst,
    output [31:0] W_Data,
    output [31:0] A,
    output [31:0] B,
    output [31:0] F,
    output [31:0] MDR
    );
    
    wire PC_Write;
    wire IR_Write;
    wire [1:0]PC_s;
    wire PC0_Write;
    
    wire [31:0] imm32;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    
    IF_DE decoder(
        .PC_Write(PC_Write),
        .IR_Write(IR_Write),
        .clk_im(clk),
        .imm32(imm32),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .PC(PC),
        .inst(inst)
    );
    
    wire [3:0] ALU_OP;
    wire IS_R;
    wire IS_IMM;
    wire IS_LUI;
    wire IS_LW;
    wire IS_SW;
    wire IS_BEQ;
    wire IS_JAL;
    wire IS_JALR;

    id2 id2_1(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .IS_R(IS_R),
        .IS_IMM(IS_IMM),
        .IS_LUI(IS_LUI),
        .IS_LW(IS_LW),
        .IS_SW(IS_SW),
        .IS_BEQ(IS_BEQ),
        .IS_JAL(IS_JAL),
        .IS_JALR(IS_JALR),
        .ALU_OP(ALU_OP)
    );
    
    wire Reg_Write;
    wire [31:0] pre_A;
    wire [31:0] pre_B;
    
    //¶ÑÕ»¼Ä´æÆ÷
    register_heap register_heap(
        .Reg_Write(Reg_Write),
        .clk_Regs(clk),
        .rst_n(rst_n),
        .R_Addr_A(rs1),
        .R_Addr_B(rs2),
        .W_Addr(rd),
        .W_Data(W_Data),
        .R_Data_A(pre_A),
        .R_Data_B(pre_B)
    );
   //A¼Ä´æÆ÷ 
    register_32 register_A(
        .clk(clk),
        .rst_n(rst_n),
        .in(pre_A),
        .out(A)
    );
    //B¼Ä´æÆ÷
    register_32 register_B(
        .clk(clk),
        .rst_n(rst_n),
        .in(pre_B),
        .out(B)
    );
    
    //Á¬½ÓA¡¢B
    wire [31:0] calculate_A;
    wire [31:0] calculate_B;
    
    assign calculate_A = A;
    wire rs2_imm_s;
    
    //¶þÑ¡Ò»Ñ¡ÔñÆ÷rs2_Imm_Select
    rs2_Imm_Select rs2_imm_select(
         .rs2_imm_s(rs2_imm_s),
        .B(B),
        .imm32(imm32),
        .result(calculate_B)
    );
    
    //Á¬½Ó  
    wire [3:0] ALU_OP_o;
    wire [31:0] pre_F;
    
    ALU alu(
        .A(calculate_A),
        .B(calculate_B),
        .ALU_OP(ALU_OP_o),
        .F(pre_F),
        .ZF(FR[0]),
        .CF(FR[1]),
        .OF(FR[2]),
        .SF(FR[3])
    );
    
    register_32 register_F(
        .clk(clk),
        .rst_n(rst_n),
        .in(pre_F),
        .out(F)
    );
    
    wire Mem_Write;
    wire [31:0] M_W_Data;
    wire [31:0] M_R_Data;
    assign M_W_Data = B;
    
    RAM_Data RAM_Data (
      .clka(clk),    // input wire clka
      .wea(Mem_Write),      // input wire [0 : 0] wea
      .addra(F[7:2]),  // input wire [5 : 0] addra
      .dina(M_W_Data),    // input wire [31 : 0] dina
      .douta(M_R_Data)  // output wire [31 : 0] douta
    );
    
    wire [31:0] MDR_out; 
    assign MDR = MDR_out;
    register_32 register_MDR(
        .clk(clk),
        .rst_n(rst_n),
        .in(M_R_Data),
        .out(MDR_out)
    );
    
    wire [1:0] w_data_s;
    wire [31:0] result_F;
    assign W_Data =  result_F;
    
    W_Data_Select w_data_select(
        .F(F),
        .imm32(imm32),
        .MDR(MDR_out),
        .pc(PC),
        .w_data_s(w_data_s),
        .result(result_F)
    );
    
    CU cu(
       .clk(clk),
       .rst_n(rst_n),
       .IS_R(IS_R),
       .IS_IMM(IS_IMM),
       .IS_LUI(IS_LUI),
       .IS_LW(IS_LW),
       .IS_SW(IS_SW),
       .IS_BEQ(IS_BEQ),
       .IS_JAL(IS_JAL),
       .IS_JALR(IS_JALR),
       .ZF(FR[0]),
       .ALU_OP(ALU_OP),
       .Reg_Write(Reg_Write),
       .PC_Write(PC_Write),
       .IR_Write(IR_Write),
       .rs2_imm_s(rs2_imm_s),
       .w_data_s(w_data_s),
       .ALU_OP_o(ALU_OP_o),
       .Mem_Write(Mem_Write),
       .PC_s(PC_s),
       .PC0_Write(PC0_Write)
        );
      
endmodule
