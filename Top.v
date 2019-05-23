`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/02 10:04:34
// Design Name: 
// Module Name: Top
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


module Top(
    input clk_in1,
//    input clk_500,
    input rst,
    input cont,step,mem,inc,dec,//DDU
    output [7:0] an,
    output [6:0] seg,
    output [15:0] led
    );
    wire [31:0] PCaddr,Jaddr,MemData,Instruction,MDRout,Rdata1,Rdata2,Wdata,extout,a,b,ALUresult,ALUout,DDURdata,DDUMdata,ddudata;
    wire [7:0] MEMRaddr,MEMWaddr,memaddr,DDURaddr;
    wire [5:0] Op;
    wire [4:0] rs,rt,rd,Rreg1,Rreg2,Wreg;
    wire [3:0] state;
    wire Zero,clk_100M,clk;
    wire clk_500;
    reg cntclk;
    //control signal
    wire PCWriteCond,PCWrite,BEQorBNE,IorD,MemRead,MemWrite,MemtoReg,IRWrite,ALUSrcA,RegWrite,RegDst;
    wire [1:0] PCSource,ALUSrcB;
    wire [2:0] ALUOp,ALUctrl;
    
    assign ddudata = (mem? DDUMdata:DDURdata);
    assign Op = Instruction[31:26];
	assign rs = Instruction[25:21];
	assign rt = Instruction[20:16];
	assign rd = Instruction[15:11];
	assign Rreg1 = rs;
	assign Rreg2 = rt;
	
	clk_wiz_0 clk100M(.clk_in1(clk_in1),.clk_out1(clk_100M));
	clk_500Hz clk500(clk_100M,clk_500);
    PC pc(clk,rst,Zero,PCWriteCond,PCWrite,BEQorBNE,PCSource,ALUresult,ALUout,Jaddr,PCaddr);
    assign memaddr = (IorD? ALUout[9:2]:PCaddr[9:2]);
    dist_mem_gen_0 insmemory(.clk(clk),.a(memaddr),.d(Rdata2),.dpra(DDURaddr),.we(MemWrite),.dpo(DDUMdata),.spo(MemData));
    Instruction_register ir(MemData,IRWrite,clk,Instruction);
    Memory_data_register mdr(clk,MemData,MDRout);
    assign Wreg = (RegDst==1? rd:rt);
    assign Wdata = (MemtoReg==1? MDRout:ALUout);
    Registers regs(clk,RegWrite,Rreg1,Rreg2,Wreg,DDURaddr[4:0],Wdata,Rdata1,Rdata2,DDURdata);
    Sign_Extend extend(Instruction[15:0],extout);
    ALU_Source alusrc(ALUSrcA,PCaddr,Rdata1,ALUSrcB,Rdata2,extout,a,b);
    ALU_Control alucontrol(ALUOp,Instruction[5:0],ALUctrl);
    ALU alu(ALUctrl,a,b,ALUresult,Zero);
    ALUOut aluout(clk,ALUresult,ALUout);
    count_J_addr jaddr(Instruction[25:0],PCaddr,Jaddr);
    Control_Unit ctrl(clk,rst,Op,state,PCWriteCond,PCWrite,BEQorBNE,IorD,MemRead,MemWrite,MemtoReg,IRWrite,PCSource,ALUSrcB,ALUSrcA,RegWrite,RegDst,ALUOp);
    DDU ddu(clk_500,rst,cont,step,inc,dec,PCaddr,state,clk,DDURaddr,led);
    DDU_display ddudp(clk_500,ddudata,an,seg);
endmodule