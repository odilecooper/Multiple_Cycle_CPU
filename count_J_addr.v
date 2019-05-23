`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/06 14:06:49
// Design Name: 
// Module Name: count_J_addr
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


module count_J_addr(
    input [25:0] ins_addr,
    input [31:0] PC,
    output reg [31:0] Jaddr
    );
    wire [27:0] sl2_addr;
    
    assign sl2_addr = ins_addr << 2;
    always @ (PC or sl2_addr)
    begin
        Jaddr = {PC[31:28],sl2_addr[27:0]};
    end
endmodule
