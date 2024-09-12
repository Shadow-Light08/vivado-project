`timescale 1ns / 1ps
module digital_clock(input clk, input reset, output [7:0] which, output [7:0] se);
    wire clk_1hz;
    wire [5:0] sec, min;
    wire [4:0] hour;
    wire [31:0] data;

    clock_divider divider(.clk(clk), .reset(reset), .clk_1hz(clk_1hz));
    time_counter counter(.clk_1hz(clk_1hz), .reset(reset), .sec(sec), .min(min), .hour(hour));

    // 将时、分、秒转换为32位BCD格式
    assign data = {hour/10, hour%10, min/10, min%10, sec/10, sec%10, 8'b0};

    // 您的显示模块
    SMG display( .clk(clk), .data(data), .which(which), .seg(se));
endmodule