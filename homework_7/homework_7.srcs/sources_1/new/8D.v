`timescale 1ns / 1ps

module eight_D(
input OE_,
input CLR,
input CLK,
input [7:0]D,
output [7:0]Q
    );
    reg [7:0]Qt;
    always@(posedge CLK)
    begin
        if(CLR)
            Qt<=8'b0;
        else 
            Qt<=D;
    end
    assign Q=OE_? 8'bz:Qt;
endmodule
