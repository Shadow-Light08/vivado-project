`timescale 1ns / 1ps

module D_74LS198(
input CR_,
input CP,
input [1:0]S,
input Sr,
input Sl,
input [7:0]D,
output reg [7:0]Q
    );
    always@(posedge CP)
    begin
        if(!CR_)
            Q<=8'b0;
        else 
        begin
            if(S==2'b11)
                Q<=D;
            else if(S==2'b01)
                begin
                Q[6:0]<=Q[7:1];
                Q[7]=Sr;
                end
            else if(S==2'b10)
                begin
                Q[7:1]<=Q[6:0];
                Q[0]<=Sl;
                end
        end
    end
    
endmodule
