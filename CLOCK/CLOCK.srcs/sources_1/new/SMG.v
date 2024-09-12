`timescale 1ns / 1ps
module SMG(input clk, input [31:0] data, output reg [7:0] which, output reg [7:0] seg);
    reg [2:0] current_digit;
    reg [3:0] digit_value;
    
    always @(posedge clk) begin
        current_digit <= current_digit + 1;
    end

    always @(*) begin
        case(current_digit)
            3'd0: digit_value = data[3:0];    // SS (��λ)
            3'd1: digit_value = data[7:4];    // SS (ʮλ)
            3'd2: digit_value = data[11:8];   // MM (��λ)
            3'd3: digit_value = data[15:12];  // MM (ʮλ)
            3'd4: digit_value = data[19:16];  // HH (��λ)
            3'd5: digit_value = data[23:20];  // HH (ʮλ)
            default: digit_value = 4'hF;      // Ĭ�����������ʾ�κ�����
        endcase
    end

    always @(*) begin
        which = 8'b11111111; // ��ʼ��Ϊ�ر����������
        which[current_digit] = 0; // ���ǰ�����

        case(digit_value)
            4'h0: seg = 8'b00000011; // 0
            4'h1: seg = 8'b10011111; // 1
            4'h2: seg = 8'b00100101; // 2
            4'h3: seg = 8'b00001101; // 3
            4'h4: seg = 8'b10011001; // 4
            4'h5: seg = 8'b01001001; // 5
            4'h6: seg = 8'b01000001; // 6 
            4'h7: seg = 8'b00011111; // 7
            4'h8: seg = 8'b00000001; // 8
            4'h9: seg = 8'b00001001; // 9
            default: seg = 8'b11111111; // Ĭ��������ر����ж�
        endcase
    end
endmodule
