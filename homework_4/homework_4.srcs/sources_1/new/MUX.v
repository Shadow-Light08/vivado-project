`timescale 1ns / 1ps


module MUX(E,S,A,B,C,D,Y);
input E;
input [1:0]S;
input [3:0]A,B,C,D;
output reg[3:0]Y;
always @(*) 
begin
    if(E==1)
    begin
        case(S)
            2'b00: Y=A;
            2'b01: Y=B;
            2'b10: Y=C;
            2'b11: Y=D;
        endcase
    end    
    else
        Y=4'b0000;
end

endmodule

//module MUX(E,S,A,B,C,D,Y);
//input E;
//input [1:0]S;
//input [3:0]A,B,C,D;
//output [3:0]Y;

//assign Y=(~S[1]&~S[0]&A)|(~S[1]&S[0]&B)|(S[1]&~S[0]&C)|(S[1]&S[0]&A);

//endmodule

//用上 :?

//module MUX(E,S,A,B,C,D,Y);
//input E;
//input [1:0]S;
//input [3:0]A,B,C,D;
//output [3:0]Y;
//wire [3:0]X;

//always @(*) 
//begin

//    case(S)
//        2'b00: X=A;
//        2'b01: X=B;
//        2'b10: X=C;
//        2'b11: X=D;
//    endcase
    
//    Y=E==1?4'b0000:X;
//end

//endmodule