`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 20:09:01
// Design Name: 
// Module Name: Instruction_register
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


module Instruction_register(
    input [31:0] MemData,
    input IRWrite,clk,
    output reg [31:0] Instruction
    );
    always @ (posedge clk)
    begin
        if (IRWrite) Instruction <= MemData;
    end
endmodule
