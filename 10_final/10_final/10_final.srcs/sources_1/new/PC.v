`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/27 13:08:51
// Design Name: 
// Module Name: PC
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

module PC(rst_n, clk_im, pc_write, pc);
    //pc_write控制的是发送信号
    input rst_n, clk_im, pc_write;
    //pc_in=pc+4
    output reg [31:0] pc=32'h0000_0000;
    
    
    always @(posedge rst_n or negedge clk_im)
    begin
        //rst_n=1时清零
        if(rst_n) begin pc <= 32'h0000_0000; end
        else
        begin
            if(pc_write)
                pc <= pc + 4;
        end
    end
    

endmodule