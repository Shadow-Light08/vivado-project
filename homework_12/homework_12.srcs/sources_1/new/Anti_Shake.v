`timescale 1ns / 1ps

module Anti_Shake(
input CLK,//时钟
input inkey,//按键开关
input reset,
input CLR,//复位
output reg outkey
    );

    // 参数定义
    parameter RESET_DELAY = 100; // 系统复位后的延时, 1μs×100=100μs
    parameter SHAKE_DELAY = 10_000; // 抖动过滤的延时 //10ms
    
    //变量
    wire  L2H_Sig,H2L_Sig;
    wire clk;
    reg [19:0] reset_counter;      // 系统复位延时计数器
    reg [19:0] debounce_counter;   // 抖动过滤延时计数器
    reg stable;               // 稳定的按键状态
    reg L2H_F1, L2H_F2;           // L2H信号的两个寄存器
    reg H2L_F1, H2L_F2;           // H2L信号的两个寄存器
    assign L2H_Sig=L2H_F1^L2H_F2;
    assign H2L_Sig=H2L_F1^H2L_F2;
    Divider D(CLK,clk,reset);//将100MHz分频为1MHz
    
    initial 
    begin
    reset_counter = 0;
    debounce_counter = 0;
    stable = 0;
    L2H_F1 = 0;
    L2H_F2 = 0;
    H2L_F1 = 0;
    H2L_F2 = 0;
    outkey = 0;
    end

    always@(posedge clk or posedge CLR)
    begin
        if(CLR)//复位
        begin
            reset_counter <= RESET_DELAY;
            L2H_F1 <= 0;
            L2H_F2 <= 0;
            H2L_F1 <= 0;
            H2L_F2 <= 0;
            stable <= 0;
        end
        else if(reset_counter > 0)//复位延时
        begin
            reset_counter <= reset_counter - 1;
        end
        else//复位和延时结束，开始消抖
        begin
            // 更新寄存器
            L2H_F2 <= L2H_F1;
            L2H_F1 <= inkey;
            H2L_F2 <= H2L_F1;
            H2L_F1 <= inkey;
            
             // 检测抖动
            if ((L2H_Sig) || (H2L_Sig)) 
            begin
                // 有抖动，启动延时
                debounce_counter <= SHAKE_DELAY;
            end 
            else if (debounce_counter > 0) 
            begin
                // 计数抖动延时
                debounce_counter <= debounce_counter - 1;
            end 
            else 
            begin
                // 稳定状态，更新输出
                stable <= L2H_F1;
                outkey <= stable;
            end
        end
    end    
endmodule
