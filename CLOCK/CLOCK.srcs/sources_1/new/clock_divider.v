`timescale 1ns / 1ps
module clock_divider(input clk, input reset, output reg clk_1hz);
    reg [26:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            clk_1hz <= 0;
        end else begin
            if (count >= 50000000) begin
                count <= 0;
                clk_1hz <= ~clk_1hz;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule
