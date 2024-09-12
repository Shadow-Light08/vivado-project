`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 21:50:37
// Design Name: 
// Module Name: Top
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



module Top(clk,rst_n, clk_nt,sw1,sw2,Led,which,seg,EN);
    //显示字段
    input clk,rst_n, clk_nt;
    input [3:0] sw1;//LED选择rs1,rs2,rd,opcode,funct3,funct7
    input [2:0] sw2;//数码管选择PC、IR、W_Data、MDR
    output reg [6:0] Led;
    output [2:0] which;
    output [7:0] seg;
    output reg EN=1;
    reg [31:0] Lcd;
    //取指令
    reg [31:0] PC=32'h0000_0000,PC0=32'h0000_0000;
    wire [31:0] Inst_Code;
    reg [31:0] IR;
    //译码
    wire [4:0]rs1,rs2,rd,funct3,funct7;
    wire [6:0]opcode;
    wire [31:0]imm32;
    wire IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,IS_BEQ,IS_JAL,IS_JALR;
    //控制信号
    wire PC_write,PC0_write,IR_write,Reg_write,Mem_write,rs2_imm_s;
    reg PC_write_R,PC0_write_R,IR_write_R,rs2_imm_s_R;
    //运算器
    wire [31:0] R_Data_A,R_Data_B;
    reg [31:0] A,B,F;
    wire [31:0] ALU_A,ALU_B,ALU_F;
    wire [3:0] ALU_OP,ALU_OP_R;
    wire ZF,SF,CF,OF;
    reg [3:0] FR;
    wire [31:0]M_R_Data;
    reg [31:0] MDR,W_Data;
    //多路选择
    wire [1:0] w_data_s,PC_s;
    reg [1:0] w_data_s_R,PC_s_R;
    
    always@(*)
    begin
        PC_write_R<=PC_write;
        PC0_write_R<=PC0_write;
        IR_write_R<=IR_write;
        w_data_s_R<=w_data_s;
        PC_s_R<=PC_s;
        rs2_imm_s_R<=rs2_imm_s;
    end
    
    //PC
    always@(posedge rst_n or negedge clk)
    begin
        //rst_n=1时清零
        if(rst_n) begin 
            PC <= 32'h0000_0000; 
            PC0 <= 32'h0000_0000;
        end
        else
        begin
            if(PC0_write_R)
                PC0<=PC;
            if(PC_write_R)
                case(PC_s_R)
                   2'b00:PC <= PC + 4;//顺序
                   2'b01:PC <= PC0 + imm32;//beq/jal
                   2'b10:PC <= F;//jalr
                   default:PC<=32'bz;
                endcase
        end      
    end
    //IR
    RAM_I IM(
    .clka(clk), // input clka
    .wea(0), // input [0 : 0] wea
    .addra(PC[7:2]), // input [5 : 0] addra
    .dina(32'hFFFF_FFFF), // input [31 : 0] dina
    .douta(Inst_Code) // output [31 : 0] douta
); 
    
    always @(posedge rst_n or negedge clk)
    begin
        //rst_n上升沿来临，IR清零
        if(rst_n) IR <= 32'h0000_0000;
        else
        if(IR_write_R) IR <= Inst_Code;           
    end
    
    ID1 uut1(IR,rs1,rs2,rd,opcode,funct3,funct7,imm32);
    ID2 uut2(opcode,funct3,funct7,
             IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,IS_BEQ,IS_JAL,IS_JALR,
             ALU_OP);
    CU  uut3(~rst_n,clk,
              IS_R,IS_IMM,IS_LUI,IS_LW,IS_SW,IS_BEQ,IS_JAL,IS_JALR,ALU_OP,ZF,
              PC_write,PC0_write,IR_write,Reg_write,Mem_write,
              rs2_imm_s,w_data_s,PC_s,ALU_OP_R);
    always@(*)
    begin
        A<=R_Data_A;
        B<=R_Data_B;
    end
    assign ALU_A = A;
    assign ALU_B = rs2_imm_s_R ? imm32 : B;
    Regs uut4(~rst_n,Reg_write,~clk,rd,W_Data,rs1,rs2,R_Data_A,R_Data_B);                      
    ALU uut5(ALU_A,ALU_B,ALU_OP_R,ALU_F,ZF,SF,CF,OF);
    always@(*)
    begin
        F<=ALU_F;
        FR[3]<=ZF;
        FR[2]<=SF;
        FR[1]<=CF;
        FR[0]<=OF;
        case(w_data_s_R)
            2'b00:W_Data<=F;
            2'b01:W_Data<=imm32;
            2'b10:W_Data<=MDR;
            2'b11:W_Data<=PC;
        endcase 
    end
    RAM_D uut6(clk,Mem_write,F[7:2],B,M_R_Data);   
    always@(negedge clk)
    begin
        MDR<=M_R_Data;
    end
          
    always@(*)
    begin
        case(sw1)
            4'b0000:Led <= { 2'b0 , rs1 };
            4'b0001:Led <= { 2'b0 , rs2 };
            4'b0010:Led <= { 2'b0 , rd };
            
            4'b0011:Led <= opcode;
            4'b0100:Led <= { 4'b0 , funct3 };
            4'b0101:Led <=  funct7 ;
            
            4'b0110:Led <=  PC_s_R ;
            4'b0111:Led <=  PC_write_R ;
            4'b1000:Led <=  rs2_imm_s_R ;
            4'b1001:Led <=  w_data_s_R ;
            4'b1010:Led <=  IS_IMM ;
            4'b1011:Led <=  Reg_write ;
            4'b1100:Led <=  ZF ;
            4'b1101:Led <=  ALU_OP_R ;
            default :Led<=7'b1111111;
        endcase
        case(sw2)
            3'b000:Lcd <= PC;
            3'b001:Lcd <= IR;
            3'b010:Lcd <= W_Data;
            3'b011:Lcd <= MDR;            
            3'b100:Lcd <= F;            
            3'b101:Lcd <= ALU_A;            
            3'b110:Lcd <= imm32;         
            3'b111:Lcd <= ALU_B;         
        endcase                               
    end
    Display uut7(clk_nt,Lcd,which,seg);
endmodule
