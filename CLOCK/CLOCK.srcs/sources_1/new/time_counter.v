`timescale 1ns / 1ps
module time_counter(input clk_1hz, input reset, output reg [5:0] sec, output reg [5:0] min, output reg [4:0] hour);
    always @(posedge clk_1hz or posedge reset) begin
        if (reset) begin
            sec <= 0; min <= 0; hour <= 0;
        end else begin
            if (sec < 59) sec <= sec + 1;
            else begin
                sec <= 0;
                if (min < 59) min <= min + 1;
                else begin
                    min <= 0;
                    if (hour < 23) hour <= hour + 1;
                    else hour <= 0;
                end
            end
        end
    end
endmodule
