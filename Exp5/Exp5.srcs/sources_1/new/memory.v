`timescale 1ns / 1ps

module memory(
    input Mem_Write,             //读写操作，0：读；1：写
    input clk_dm,
    input [7:0] DM_Addr,         //地址输入
    input [31:0] M_W_Data,       //数据输入
    input [1:0]Size_s,           //访问尺寸
    input SE_s,                  //扩展方式
    output reg [31:0] M_R_Data   //数据输出
    );
    
    reg [31:0] temp_W_Data;
    wire [31:0] temp_R_Data;
    reg [15:0]X_Half_W;          //读半字数据记录
    reg [7:0]Y_W;               //读字节数据记录
    reg [3:0]wea;                //使能端
    
     RAM_B ram (
      .clka(clk_dm),    // input wire clka
      .wea(wea),      // input wire [3 : 0] wea
      .addra(DM_Addr[7:2]),  // input wire [5 : 0] addra
      .dina(temp_W_Data),    // input wire [31 : 0] dina
      .douta(temp_R_Data)  // output wire [31 : 0] douta
    );
   
    always@(posedge clk_dm)begin
       //write
       if(Mem_Write)begin
            //半字
          case(Size_s)
            2'b01:begin
                wea <= DM_Addr[1]?4'b1100:4'b0011;//高半字或低半字写使能
                temp_W_Data <= DM_Addr[1]?{M_W_Data[15:0],16'b0}:{16'b0,M_W_Data[15:0]};
                //写半字
            end
            //字节
            2'b00:begin
                case(DM_Addr[1:0])
                    2'b00: begin wea <= 4'b0001;temp_W_Data <= {24'b0,M_W_Data[7:0]};end
                    2'b01: begin wea <= 4'b0010;temp_W_Data <= {16'b0,M_W_Data[7:0],8'b0};end
                    2'b10: begin wea <= 4'b0100;temp_W_Data <= {8'b0,M_W_Data[7:0],16'b0};end
                    2'b11: begin wea <= 4'b1000;temp_W_Data <= {M_W_Data[7:0],24'b0};end
                endcase
            end
            //字
            2'b10:  begin
                wea <= 4'b1111;
                temp_W_Data <= M_W_Data;
            end
            
            default:begin
                wea <= 4'h0000;
                temp_W_Data <= M_W_Data;
            end
           endcase
        end
     end
    always @(posedge clk_dm)begin
    //read
        //字节
        if(Size_s == 2'b00)begin
            case(DM_Addr[1:0])
                2'b00: Y_W <= temp_R_Data[7:0];//记录字节数据
                2'b01: Y_W <= temp_R_Data[15:8];
                2'b10: Y_W <= temp_R_Data[23:16];
                2'b11: Y_W <= temp_R_Data[31:24];
                default: Y_W <= 8'b0;
            endcase
            M_R_Data <= {SE_s?{24{Y_W[7]}}:{24'b0},Y_W};//输出到M_R_Data
        end
        //半字
        else if(Size_s == 2'b01)begin
            X_Half_W <= DM_Addr[1] ? temp_R_Data[31:16]:temp_R_Data[15:0];//记录半字数据
            M_R_Data <= {SE_s?{16{X_Half_W[15]}}:{16'b0},X_Half_W};//输出到M_R_Data
        end
        //字
        else
        M_R_Data <= temp_R_Data;
    end
    
endmodule