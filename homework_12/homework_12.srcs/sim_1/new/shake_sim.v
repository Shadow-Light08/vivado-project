`timescale 1ns / 1ps

module shake_sim();
reg CLK;
reg inkey;
reg reset;
reg CLR;
wire outkey;

// 实例化Anti_Shake模块
Anti_Shake Test (
    .CLK(CLK), 
    .inkey(inkey), 
    .reset(reset), 
    .CLR(CLR), 
    .outkey(outkey)
);

// 时钟信号生成
initial begin
    CLK = 0;
    forever #5 CLK = ~CLK; // 产生100MHz的时钟信号
end

initial begin
    // 初始化
    inkey = 0;
    reset = 1;
    CLR = 0;

    // 重置系统
    #10 reset = 0;

    // 模拟按键输入
    #100_000 inkey = 1; // 模拟按键按下
    #20_000 inkey = 0;  // 模拟按键释放
    #100_000 inkey = 1; // 再次模拟按键按下
    #100_000 inkey = 0; // 再次模拟按键释放

    // 完成测试
    #200000 $finish;
end

endmodule

