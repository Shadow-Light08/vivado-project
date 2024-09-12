`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 18:11:44
// Design Name: 
// Module Name: CU
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


module CU(
    input rst_n,
    input clk,
    input IS_R, 
    input IS_IMM, 
    input IS_LUI,
    input IS_LW,
    input IS_SW,
    input IS_BEQ,
    input IS_JAL,
    input IS_JALR,
    input [3:0] ALU_OP,
    input ZF,
    output reg PC_write,
    output reg PC0_write,
    output reg IR_write,
    output reg Reg_write,
    output reg Mem_write,
    output reg rs2_imm_s,
    output reg [1:0] w_data_s,
    output reg [1:0] PC_s,
    output reg [3:0] ALU_OP_o
    );
    reg [3:0] ST,Next_ST;
    `define Idle 4'b0000
    `define S1 4'b0001
    `define S2 4'b0010
    `define S3 4'b0011
    `define S4 4'b0100
    `define S5 4'b0101
    `define S6 4'b0110
    `define S7 4'b0111
    `define S8 4'b1000
    `define S9 4'b1001
    `define S10 4'b1010
    `define S11 4'b1011
    `define S12 4'b1100
    `define S13 4'b1101
    `define S14 4'b1110
    // 第一段：状态转移，在clk的边沿进行状态转移，是同步时序逻辑电路
    always @(negedge rst_n or posedge clk)
    begin
        if (!rst_n) ST <= `Idle; // 初始状态
        else ST <= Next_ST; // clk的上跳沿，进行状态转移
    end
    // 第二段：次态函数，对次态的阻塞式赋值，是组合逻辑函数
    always @(*)
    begin
        Next_ST = `Idle;
        case (ST) // 根据状态转移图进行次态赋值
            `Idle: Next_ST = `S1;
            `S1: begin
                if (IS_LUI) Next_ST = `S6;
                else begin
                    if(IS_JAL) Next_ST = `S11;
                    else Next_ST = `S2;                    
                end
            end
            `S2: begin
                if (IS_R) Next_ST = `S3;
                else begin
                    if(IS_BEQ) Next_ST = `S13;
                    else
                        begin
                            if(IS_IMM) Next_ST = `S5 ;
                            else Next_ST = `S7;
                        end
                end
            end
            `S3: Next_ST = `S4;
            `S5: Next_ST = `S4;
            `S4: Next_ST = `S1;
            `S6: Next_ST = `S1;
            
            `S7: begin
                if(IS_LW) Next_ST = `S8;
                else
                begin
                    if(IS_SW) Next_ST = `S10;
                    else Next_ST = `S12;
                end
            end
            `S8: Next_ST = `S9;
            `S9: Next_ST = `S1;
            `S10: Next_ST = `S1;
            `S11: Next_ST = `S1;
            `S12: Next_ST = `S1;
            
            `S13: Next_ST = `S14;
            `S14: Next_ST = `S1;
            default: Next_ST = `S1;
        endcase
    end
    // 第三段：输出函数，在clk的上跳沿，根据下一状态进行控制信号的非阻塞式赋值
    always @(negedge rst_n or posedge clk) 
    begin
        if (!rst_n)  // 全部信号初始化为0
        begin
            PC_write<=1'b0; PC0_write<=1'b0; IR_write<=1'b0;
            Reg_write<=1'b0; Mem_write<=1'b0; ALU_OP_o<=4'b0000;
            rs2_imm_s<=1'b0;w_data_s<=2'b00;PC_s<=2'b00;
        end
        else
        begin
             // 每个状态下输出的控制信号
            case(Next_ST)
                `S1:begin //取指令，PC自增
                     PC_write<=1'b1; PC0_write<=1'b1; IR_write<=1'b1;
                     Reg_write<=1'b0; Mem_write<=1'b0;
                     PC_s<=2'b00;
                end
                `S2:begin //R/I/lw/sw/jalr/beq
                     PC_write<=1'b0; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b0; Mem_write<=1'b0;
                end
                `S3:begin //R
                     PC_write<=1'b0; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b0; Mem_write<=1'b0; ALU_OP_o<=ALU_OP;
                     rs2_imm_s<=1'b0;
                end
                `S4:begin //R
                     PC_write<=1'b0; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b1; Mem_write<=1'b0;
                     w_data_s<=2'b00;
                end
                `S5:begin //I
                     PC_write<=1'b0; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b0; Mem_write<=1'b0; ALU_OP_o<=ALU_OP;
                     rs2_imm_s<=1'b1;
                end
                `S6:begin //lui
                     PC_write<=1'b0; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b1; Mem_write<=1'b0; 
                     w_data_s<=2'b01;
                end  
                `S7:begin //lw/sw/jalr
                     PC_write<=1'b0; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b0; Mem_write<=1'b0; ALU_OP_o<=4'b0000;
                     rs2_imm_s<=1'b1;
                end     
                `S8:begin //lw
                     PC_write<=1'b0; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b0; Mem_write<=1'b0; 
                end         
                `S9:begin //lw
                     PC_write<=1'b0; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b1; Mem_write<=1'b0; 
                     w_data_s<=2'b10;
                end
                `S10:begin //sw
                     PC_write<=1'b0; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b0; Mem_write<=1'b1; 
                end
                `S11:begin //jal
                     PC_write<=1'b1; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b1; Mem_write<=1'b0; 
                     w_data_s<=2'b11;PC_s<=2'b01;
                end
                `S12:begin //jalr
                     PC_write<=1'b1; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b1; Mem_write<=1'b0; 
                     w_data_s<=2'b11;PC_s<=2'b10;
                end
                `S13:begin //beq
                     PC_write<=1'b0; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b0; Mem_write<=1'b0;ALU_OP_o<=4'b1000; 
                     rs2_imm_s<=1'b0;
                end
                `S14:begin //beq
                     PC_write<=ZF; PC0_write<=1'b0; IR_write<=1'b0;
                     Reg_write<=1'b0; Mem_write<=1'b0; 
                     PC_s<=2'b01;
                end
            endcase
        end
    end
    
endmodule
