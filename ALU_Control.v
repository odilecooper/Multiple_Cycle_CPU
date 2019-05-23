`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 15:55:42
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control(
    input [2:0] ALUOp,
    input [5:0] func,
    output reg [2:0] ALUctrl
    );
    always @ (func or ALUOp)
    begin
        if (ALUOp==3'b111)
        begin
            case(func)
                6'b100000: ALUctrl = 3'b000;//add
                6'b100010: ALUctrl = 3'b001;//sub
                6'b100100: ALUctrl = 3'b010;//and
                6'b100101: ALUctrl = 3'b011;//or
                6'b100110: ALUctrl = 3'b100;//xor
                6'b100111: ALUctrl = 3'b101;//nor
                6'b101010: ALUctrl = 3'b110;//slt
                6'b000000: ALUctrl = 3'b000;//nop,add
            endcase
        end
        else ALUctrl = ALUOp;
    end
endmodule
