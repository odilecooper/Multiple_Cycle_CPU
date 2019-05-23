`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 16:48:16
// Design Name: 
// Module Name: ALUOut
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


module ALUOut(
    input clk,
    input [31:0] ALUresult,
    output reg [31:0] ALUOut
    );
    always @ (posedge clk)
    begin
        ALUOut <= ALUresult;
    end
endmodule