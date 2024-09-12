`timescale 1ns / 1ps

module E3_8_sim;
reg [2:0]in,sel;
wire [7:0]out;
E3_8 Test(in,sel,out);
initial
begin
    //使能端处于无效电平?
    in=3'b000;sel=3'b011;
    #100;
    in=3'b001;sel=3'b001;
    #100;
    in=3'b100;sel=3'b110;
    #100;
    in=3'b011;sel=3'b111;
    #100;
    in=3'b111;sel=3'b101;
    #100;
    //使能端处于有效电平?
    in=3'b000;sel=3'b100;
    #100;
    in=3'b001;sel=3'b100;
    #100;
    in=3'b100;sel=3'b100;
    #100;
    in=3'b011;sel=3'b100;
    #100;
    in=3'b111;sel=3'b100;
    #100;
end
endmodule
