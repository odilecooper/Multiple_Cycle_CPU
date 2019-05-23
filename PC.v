`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/02 10:12:46
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


module PC(  
    input clk,rst,Zero,
    input PCWriteCond,PCWrite,BEQorBNE,
    input [1:0] PCSource,
    input [31:0] ALUresult,ALUOut,Jaddr,
    output reg[31:0] PCAdd  
);
    wire PCctrl;
    assign PCctrl = PCWrite | PCWriteCond;
    
    always @ (posedge clk or posedge rst)
    begin
        if (rst)
            PCAdd <= 0;
        else if (PCctrl)
        begin
            case (PCSource)
                2'b00: PCAdd <= ALUresult;
                2'b01:
                begin
                    if (BEQorBNE^Zero) PCAdd <= PCAdd;//branch
                    else PCAdd <= ALUOut;
                end
                2'b10: PCAdd <= Jaddr;//J
                default: PCAdd <= PCAdd;
            endcase
        end
        else PCAdd <= PCAdd;
    end
endmodule