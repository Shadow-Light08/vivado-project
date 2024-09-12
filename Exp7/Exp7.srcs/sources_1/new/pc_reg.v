`timescale 1ns / 1ps

module pc_reg(
    input PC_Write,
    input clk_im,
    input [31:0] new_pc,
    output [31:0]now_pc,
    output [5:0] addr
    );
    
    reg [31:0] pc = 0;
    
   always@(negedge clk_im)
   begin
        if(PC_Write)pc = new_pc;
   end
   assign now_pc = pc;
   assign addr = pc[7:2];
endmodule
