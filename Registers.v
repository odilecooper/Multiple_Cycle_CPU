`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/05 15:54:21
// Design Name: 
// Module Name: Registers
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


module Registers(
    input clk,
    input RegWrite,
    input [4:0] Rreg1,Rreg2,Wreg,DDURreg,
    input [31:0] Wdata,
    output [31:0] Rdata1,Rdata2,DDURdata
    );
    reg [31:0] register [0:31];
    assign Rdata1 = register[Rreg1];
    assign Rdata2 = register[Rreg2];
    assign DDURdata = register[DDURreg];
    always @ (posedge clk)//write
    begin
        register[0] <= 0;
        if (RegWrite)
        begin
            if (Wreg!=0) register[Wreg] <= Wdata;
        end
    end
endmodule