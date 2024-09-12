`timescale 1ns / 1ps

module IF_DE(
    input PC_Write,//使能信号
    input IR_Write,
    input PC0_Write,
    
    input clk_im,
    input [1:0] PC_s,//PC三选一选择信号      
    input [31:0] F,
    
    output [31:0] imm32,
    output [4:0] rs1,
    output [4:0] rs2,
    output [4:0] rd,
    output [6:0] opcode,
    output [2:0] funct3,
    output [6:0] funct7, 
    output [31:0] PC,
    output [31:0] inst
    );
    
    wire [31:0] inst_Code;//从IM中取指令
    wire [31:0] instr;//从指令寄存器IR中取指令
    wire [31:0] pc;
    wire [31:0] new_pc;
    wire [5:0] addr;
    
    assign PC = pc;

    assign inst = instr;
    
    wire [31:0] origin_pc;
    wire [31:0] PC0_out;
    //1.
    //自增4加法器
    adder addr_module(
        .pc(pc),
        .new_pc(origin_pc)
    );
    //pc0寄存器：保存+4前地址
    PC0 pc0_module(
        .clk(clk_im),
        .PC0_Write(PC0_Write),
        .pc(pc),
        .PC0_out(PC0_out)
    );
    wire [31:0] jal_pc;
    wire [31:0] jalr_pc;
    //2.
    //beq、jar
    assign jal_pc = PC0_out + imm32;
    //3.
    //jalr
    assign jalr_pc = F;
    //三选一
    //pc三选一选择器
    PC_select PC_select_module(
        .PC_s(PC_s),
        .origin_pc(origin_pc),
        .jal_pc(jal_pc),
        .jalr_pc(jalr_pc),
        .new_pc(new_pc)
        );
    //pc寄存器
    pc_reg pc_module(
        .PC_Write(PC_Write),
        .clk_im(clk_im),
        .now_pc(pc),
        .new_pc(new_pc),
        .addr(addr)
    );
    //只需要读操作，因此写操作和写使能输入0
   IM IM_B (
      .clka(clk_im),    // input wire clka
      .wea(0),      // input wire [0 : 0] wea
      .addra(addr),  // input wire [5 : 0] addra
      .dina(0),    // input wire [31 : 0] dina
      .douta(inst_Code)  // output wire [31 : 0] douta
    );
    //指令寄存器
    IR ir(
        .IR_Write(IR_Write),
        .clk_im(clk_im),
        .Inst_Code(inst_Code),
        .instr(instr)
    );
    //初级译码器
    ID1 id1(
        .instr(instr),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .imm(imm32)
    );
    
endmodule


