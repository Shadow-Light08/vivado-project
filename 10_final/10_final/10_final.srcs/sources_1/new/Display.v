`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/16 21:47:27
// Design Name: 
// Module Name: Display
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


module Display(clk,data,which,seg);
    input clk;  //时钟
    input [32:1] data;  //数据
    output reg [2:0] which=0;  //片选信号
    output reg[7:0] seg;  //片选数据
    reg [14:0] count = 0;
    reg [3:0] digit;
    always@(posedge clk)count<=count+1'b1;
    always@(negedge clk)if(&count)which<=which+1'b1;
    always @*
    begin
        case(which)
        0:digit<=data[32:29];
        1:digit<=data[28:25];
        2:digit<=data[24:21];
        3:digit<=data[20:17];
        4:digit<=data[16:13];
        5:digit<=data[12:9];
        6:digit<=data[8:5];
        7:digit<=data[4:1];
        endcase
    end
    always@*
    begin
        case(digit)
        //_为了分隔比特方便阅读
        4'h0:seg<=8'b0000_0011;
        4'h1:seg<=8'b1001_1111;
        4'h2:seg<=8'b0010_0101;
        4'h3:seg<=8'b0000_1101;
        4'h4:seg<=8'b1001_1001;
        4'h5:seg<=8'b0100_1001;
        4'h6:seg<=8'b0100_0001;
        4'h7:seg<=8'b0001_1111;
        4'h8:seg<=8'b0000_0001;
        4'h9:seg<=8'b0000_1001;
        4'hA:seg<=8'b0001_0001;
        4'hB:seg<=8'b1100_0001;
        4'hC:seg<=8'b0110_0011;
        4'hD:seg<=8'b1000_0101;
        4'hE:seg<=8'b0110_0001;
        4'hF:seg<=8'b0111_0001;
        endcase
    end
endmodule