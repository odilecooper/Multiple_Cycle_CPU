`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/06 15:32:11
// Design Name: 
// Module Name: ALU_Source
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


module ALU_Source(
    input ALUSrcA,
    input [31:0] PCaddr,Rdata1,
    input [1:0] ALUSrcB,
    input [31:0] Rdata2,extout,
    output reg [31:0] a,b
    );
    wire [31:0] sl2_extout;
    assign sl2_extout = {extout[29:0],2'b00};
    always @ (*)
    begin
        if (ALUSrcA == 0) a = PCaddr;
        else a = Rdata1;
        case (ALUSrcB)
            2'b00:b = Rdata2;
            2'b01:b = {29'b00000000000000000000000000000,3'b100};
            2'b10:b = extout;
            2'b11:b = sl2_extout;
        endcase
    end
endmodule
