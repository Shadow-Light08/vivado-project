`timescale 1ns / 1ps

module C8_3(in,E,out,done);
input [7:0]in;
input E;
output reg [2:0]out;
output reg done;
always@(*)
begin
    if(E==0)
    begin
        casex(in)
        8'b00000001: begin out=3'b111;done=1;end
        8'b0000001x: begin out=3'b110;done=1;end
        8'b000001xx: begin out=3'b101;done=1;end
        8'b00001xxx: begin out=3'b100;done=1;end
        8'b0001xxxx: begin out=3'b011;done=1;end
        8'b001xxxxx: begin out=3'b010;done=1;end
        8'b01xxxxxx: begin out=3'b001;done=1;end
        8'b1xxxxxxx: begin out=3'b000;done=1;end
        8'b00000000: begin out=3'b000;done=0;end
        endcase
    end
    else
        begin out=3'b000;done=0; end
end
endmodule
