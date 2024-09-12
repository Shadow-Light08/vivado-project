`timescale 1ns / 1ps
module ALU(
    input [31:0]A,
    input [31:0]B,
    input [3:0]ALU_OP, //选择
    output reg [31:0]F,
    output reg ZF,  //零标志
    output reg SF,  //符号标志
    output reg CF,  //进位标志
    output reg OF   //溢出标志
    );
    reg C;  //双符号位
    reg [31:0] ALU_F;
    reg flags[3:0];//记录四个标志
    reg is_add;
    always@(*)
    begin
        case(ALU_OP)
            4'b0000:begin {C,ALU_F}<=A+B;end                         // 0000:A+B
            4'b0001:begin {C,ALU_F}<=A<<B;end                        // 0001:A<<B
            4'b0010:begin {C,ALU_F}<=$signed(A)<$signed(B)?1:0;end   // 0010:有符号数比较(A<B) ?1 :0
            4'b0011:begin {C,ALU_F}<=A<B?1:0;end                     // 0011:无符号数比较(A<B) ? 1 : 0
            4'b0100:begin {C,ALU_F}<=A^B;end                         // 0100:A^B
            4'b0101:begin {C,ALU_F}<=A>>B;end                        // 0101:逻辑右移:A<<<B，高位补0
            4'b0110:begin {C,ALU_F}<=A|B;end                         // 0110:按位或:A | B
            4'b0111:begin {C,ALU_F}<=A&B;end                         // 0111: A & B
            4'b1000:begin {C,ALU_F}<=A-B;end                         // 1000:A-B
            4'b1101:begin {C,ALU_F}<=A>>>B;end                       // 1101:算数右移A>>B
        endcase
         is_add = (ALU_OP == 4'b0000)?1:0;
        ZF=ALU_F==32'd0 ?1:0;
        SF=ALU_F[31];
        CF=(~is_add & C) + (is_add & C);
        OF=A[31]^B[31]^C^ALU_F[31];
    end

endmodule
