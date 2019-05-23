`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 20:15:53
// Design Name: 
// Module Name: Memory_data_register
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


module Memory_data_register(
    input clk,
    input [31:0] MemData,
    output reg [31:0] MDRout
    );
    always @ (posedge clk)
    begin
        MDRout <= MemData;
    end
endmodule
