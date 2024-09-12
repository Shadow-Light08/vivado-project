`timescale 1ns / 1ps

module CU(
    input clk,
    input rst_n,
    input IS_R,
    input IS_IMM,
    input IS_LUI,
    input IS_LW,
    input IS_SW,
    input IS_BEQ,
    input IS_JAL,
    input IS_JALR,
    input ZF,
    input [3:0] ALU_OP,
    output reg Reg_Write,
    output reg PC_Write,
    output reg IR_Write,
    output reg Mem_Write,
    output reg rs2_imm_s,
    output reg [1:0] w_data_s,
    output reg [1:0] PC_s,
    output reg PC0_Write,
    output reg [3:0] ALU_OP_o
    );
    
    parameter [4:0] Idle = 0;
    parameter [4:0] S1 = 1; 
    parameter [4:0] S2 = 2; 
    parameter [4:0] S3 = 3; 
    parameter [4:0] S4 = 4; 
    parameter [4:0] S5 = 5; 
    parameter [4:0] S6 = 6; 
    parameter [4:0] S7 = 7; 
    parameter [4:0] S8 = 8; 
    parameter [4:0] S9 = 9; 
    parameter [4:0] S10 = 10; 
    parameter [4:0] S11 = 11; 
    parameter [4:0] S12 = 12; 
    parameter [4:0] S13 = 13; 
    parameter [4:0] S14 = 14; 
    
    reg [4:0] ST;
    reg [4:0] Next_ST;
    always @(posedge rst_n or posedge clk) 
    begin
        if (!rst_n) ST <= Idle; // 初始状态
        else ST <= Next_ST; // 每当clk上跳沿，进行状态转移
    end
    //根据指令进行状态转移
    always@(*)
    begin
        Next_ST = Next_ST;
        case(ST)
            Idle: Next_ST = S1;
            S1:begin
                if(IS_LUI)
                    Next_ST = S6;
                else if(IS_R|IS_IMM|IS_LW|IS_SW)
                    Next_ST = S2;
                else if(IS_JAL)
                    Next_ST = S11;
            end
            S2:begin
                if(IS_R)
                    Next_ST = S3;
                else if(IS_IMM) 
                    Next_ST = S5;
                else if(IS_LW | IS_SW | IS_JALR)
                    Next_ST = S7;
                else if(IS_BEQ)
                    Next_ST = S13;
            end
            S3:Next_ST = S4;
            S5:Next_ST = S4;
            S7:begin
                if(IS_LW)Next_ST = S8;
                else if(IS_SW)Next_ST = S10;
                else if(IS_JALR)Next_ST = S12;
            end
            S8:Next_ST = S9;
            S13:Next_ST = S14;
            default:Next_ST = S1;
         endcase   
    end
    
    always@(posedge rst_n or posedge clk)
    begin
        if(rst_n)//reset，全部置0
        begin
            PC_Write <= 0;
            IR_Write <= 0;
            rs2_imm_s <= 0;
            w_data_s <= 0;
            ALU_OP_o = 0;
            Reg_Write <= 0;
            Mem_Write <= 0;
            PC_s <= 0;
            PC0_Write <= 0;
        end
        else begin
            //每个状态发送的信号：
            case(Next_ST)
                S1:begin
                    PC_Write <= 1'b1;
                    PC0_Write <= 1;
                    IR_Write <= 1'b1;
                    Reg_Write <= 1'b0;
                    Mem_Write <= 0;
                    PC_s = 2'b00;
                end
                S2:begin
                    PC_Write <= 1'b0;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b0;
                    Mem_Write <= 0;
                end
                S3:begin
                    PC_Write <= 1'b0;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b0;
                    Mem_Write <= 0;
                    ALU_OP_o = ALU_OP;
                    rs2_imm_s = 1'b0;
                end
                S4:begin
                    PC_Write <= 1'b0;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b1;
                    Mem_Write <= 0;
                    w_data_s = 2'b00;
                end
                S5:begin
                    PC_Write <= 1'b0;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b0;
                    Mem_Write <= 0;
                    ALU_OP_o = ALU_OP;
                    rs2_imm_s = 1'b1;
                end
                S6:begin
                    PC_Write <= 1'b0;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b1;
                    Mem_Write <= 0;
                    w_data_s = 2'b01;
                end
                S7:begin
                    PC_Write <= 1'b0;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b0;
                    Mem_Write <= 0;
                    ALU_OP_o <= 0;
                    rs2_imm_s = 1'b1;
                end
                S8:begin
                    PC_Write <= 1'b0;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b0;
                    Mem_Write <= 0;
                end
                S9:begin
                    PC_Write <= 1'b0;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b1;
                    Mem_Write <= 0;
                    w_data_s = 2'b10;
                end
                S10:begin
                    PC_Write <= 1'b0;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b0;
                    Mem_Write <= 1;
                end
                S11:begin
                    PC_Write <= 1'b1;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b1;
                    Mem_Write <= 0;
                    w_data_s = 2'b11;
                    PC_s = 2'b01;
                end
                S12:begin
                    PC_Write <= 1'b1;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b1;
                    Mem_Write <= 0;
                    w_data_s = 2'b11;
                    PC_s = 2'b10;
                end
                S13:begin
                    PC_Write <= 1'b0;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b0;
                    Mem_Write <= 0;
                    ALU_OP_o <= 4'b1000;
                    rs2_imm_s <= 0;
                end
                S14:begin
                    PC_Write <= ZF;
                    PC0_Write <= 0;
                    IR_Write <= 1'b0;
                    Reg_Write <= 1'b0;
                    Mem_Write <= 0;
                    PC_s <= 2'b01;
                end
             endcase   
        end
    end
    
endmodule
