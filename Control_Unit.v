`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/04 21:12:05
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input clk,rst,
    input [5:0] Op,
    output reg [3:0] state,
    output reg PCWriteCond,PCWrite,BEQorBNE,
    output reg IorD,
    output reg MemRead,MemWrite,MemtoReg,
    output reg IRWrite,
    output reg [1:0] PCSource,ALUSrcB,
    output reg ALUSrcA,
    output reg RegWrite,RegDst,
    output reg [2:0] ALUOp
    );
    parameter [3:0] IF = 4'b0000,
        ID = 4'b0001,
        MAC = 4'b0010,//2,lw,sw
        MR = 4'b0011,//3,mem read:lw
        WB = 4'b0100,//4,write back
        MW = 4'b0101,//5,mem write:sw
        EXE1 = 4'b0110,//6,R type
        EXE2 = 4'b1010,//10,immediate number
        RCP = 4'b0111,//7,R type completion
        ICP = 4'b1011,//11,I type completion
        BRCH = 4'b1000,//8,Branch, Rtype
        JMP = 4'b1001;//9,Jump
	parameter [5:0] Rtype = 6'b000000,//ADD,SUB,AND,OR,XOR,NOR,SLT
        ADDI = 6'b001000,
	    ANDI = 6'b001100,
        ORI = 6'b001101,
        XORI = 6'b100110,
        SLTI = 6'b001010,
        LW = 6'b100011,
        SW = 6'b101011,
        BEQ = 6'b000100,
        BNE = 6'b000101,
        J = 6'b000010;
//	reg [3:0] state;
	reg [3:0] nextstate;
	reg flag0,flag1,flag2;
	
	always @(posedge clk or posedge rst)//state & stateout
	begin
	   if (rst) state <= IF;
       else state <= nextstate;
	end
	
	always @(*)//nextstate
	begin
        case(state)
            IF: nextstate = ID;
            ID:
            begin
                case (Op)
                    Rtype: nextstate = EXE1;
                    ADDI: nextstate = EXE2;
                    ANDI: nextstate = EXE2;
                    ORI: nextstate = EXE2;
                    XORI: nextstate = EXE2;
                    SLTI: nextstate = EXE2;
                    LW: nextstate = MAC;
                    SW: nextstate = MAC;
                    BEQ: nextstate = BRCH;
                    BNE: nextstate = BRCH;
                    J: nextstate = JMP;
                    default: nextstate = ID;
                endcase
            end
		    MAC:
            begin
	           if (Op==LW) nextstate = MR;
               else nextstate = MW;
		    end
            MR: nextstate = WB;
		    EXE1: nextstate = RCP;
    	    EXE2: nextstate = ICP;
            default: nextstate = IF;//WB,MW,RCP,ICP,BRCH.JMP
        endcase
    end

	always @ (state)//control
	begin
    	PCWriteCond = 0;
    	PCWrite = 0;
        IorD = 0;
        MemRead = 1;
        MemWrite = 0;
        MemtoReg = 0;
        IRWrite = 0;
        PCSource = 2'b00;
        ALUSrcB = 2'b01;
        ALUSrcA = 0;
        RegWrite = 0;
        RegDst = 0;
        ALUOp = 3'b000;
//    BEQorBNE
        BEQorBNE = ((Op==BEQ)? 1:0);
//    PCWriteCond
        if (state==BRCH) PCWriteCond = 1;
//    PCWrite
        PCWrite = ((state==JMP|state==IF)? 1:0);
//    IorD
        if (state==MR|state==MW) IorD = 1;
        else if (state==IF) IorD = 0;
//    MemRead
        MemRead = ((state==IF|state==MR)? 1:0);
//    MemWrite
        MemWrite = (state==MW? 1:0);
//    MemtoReg
        MemtoReg = (state==WB? 1:0);
//    IRWrite
        IRWrite = (state==IF? 1:0);
//    PCSource
        if (state == IF) PCSource = 2'b00;
        else if (state == BRCH) PCSource = 2'b01;
        else if (state == JMP) PCSource = 2'b10;
//    ALUOp
        if (state==IF | state==ID | state==MAC) ALUOp = 3'b000;
        else if (state == BRCH | state == JMP) ALUOp = 3'b001;
        else if (state == EXE1) ALUOp = 3'b111;
        else if (state == EXE2)
        begin
            case (Op)
                ADDI: ALUOp = 3'b000;
                ANDI: ALUOp = 3'b010;
                ORI: ALUOp = 3'b011;
                XORI: ALUOp = 3'b100;
                SLTI: ALUOp = 3'b110;
            endcase
        end
//    ALUSrcB
        if (state==EXE1 | state==BRCH) ALUSrcB = 2'b00;
        else if (state == IF) ALUSrcB = 2'b01;
        else if (state==MAC | state==EXE2) ALUSrcB = 2'b10;
        else if (state == ID) ALUSrcB = 2'b11;
//    ALUSrcA
        if (state==IF | state==ID) ALUSrcA = 0;
        else if (state==MAC | state==EXE1 | state==EXE2 | state==BRCH) ALUSrcA = 1;
//    RegWrite
        RegWrite = ((state==WB|state==RCP|state==ICP)? 1:0);
//    RegDst
        if (state==WB | state==ICP) RegDst = 0;
        else if (state == RCP) RegDst = 1;
    end
endmodule