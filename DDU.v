`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 21:07:54
// Design Name: 
// Module Name: DDU
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


module DDU(
    input clk_500,rst,
    input cont,step,inc,dec,
    input [31:0] PCaddr,
    input [3:0] state,
    output clk,
    output reg [7:0] DDURaddr,
    output [15:0] led
    );
    reg run;
    integer cntinc,cntdec,cntstep;
    
    assign clk = (cont? clk_500:step);
    assign {led[7:0]} = DDURaddr;
    assign {led[15:8]} = {PCaddr[7:0]};
//    assign {led[11:8]} = state;
//    assign {led[15:12]} = 0;
        
    always @ (posedge clk_500)//run
    begin
        run <= 0;
        if (cont==1)
        begin
            run <= 1;
        end
        else
        begin
            if (step==1) run <= 1;
            else run <= 0;
        end
    end
    always @ (posedge clk_500)
    begin
        cntinc <= 0;
        cntdec <= 0;
        if (rst)
            DDURaddr <= 0;
        else if (inc)
        begin
            cntinc <= cntinc + 1;
            if (cntinc==10) DDURaddr <= DDURaddr+1;
        end
        else if (dec)
        begin
            cntdec <= cntdec + 1;
            if (cntdec==10) DDURaddr <= DDURaddr-1;
        end
    end
endmodule