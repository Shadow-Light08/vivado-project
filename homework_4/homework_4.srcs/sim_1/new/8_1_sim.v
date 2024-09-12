`timescale 1ns / 1ps

module S8_1_sim();
wire  [3:0]Y;
reg [3:0]A,B,C,D,E,F,G,H;
reg [2:0]S;
S8_1 Test(A,B,C,D,E,F,G,H,S,Y);
initial
begin 
    A=4'b0001;B=4'b0010;C=4'b0011;D=4'b0100;E=4'b0101;F=4'b0110;G=4'b0111;H=4'b1000;
    S=3'b000; #100;
    S=3'b001; #100;
    S=3'b010; #100;
    S=3'b011; #100;
    
    S=3'b100; #100;
    S=3'b101; #100;
    S=3'b110; #100;
    S=3'b111; #100;
end
endmodule
