//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2014 leishangwen@163.com                       ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
// Module:  ex
// File:    ex.v
// Author:  Lei Silei
// E-mail:  leishangwen@163.com
// Description: 执行阶段
// Revision: 1.0
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module ex(

	input wire					  rst ,
	
	//送到执行阶段的信息
	input wire[`AluOpBus]         aluop_i,//运算子类型
	input wire[`AluSelBus]        alusel_i,//运算类型
	input wire[`RegBus]           reg1_i,//源操作数1
	input wire[`RegBus]           reg2_i,//源操作数2
	input wire[`RegAddrBus]       wd_i,//要写入的目的寄存器地址
	input wire                    wreg_i,//是否要写入目的寄存器

	
	output reg[`RegAddrBus]       wd_o,//要写入的目的寄存器地址
	output reg                    wreg_o,//是否要写入目的寄存器
	output reg[`RegBus]			  wdata_o//要写入的目的寄存器的值
	
);

	reg[`RegBus] logicout;//保存逻辑运算的结果，疑问这里为什么要有一个寄存器，没有它的话不是也可以存到后面的EX/MEM流水寄存器里吗？
	always @ (*) begin
		if(rst == `RstEnable) begin
			logicout <= `ZeroWord;
		end else begin
			case (aluop_i) //依据aluop_i指示的运算子类型进行运算
				`EXE_OR_OP:			begin
					logicout <= reg1_i | reg2_i;//ori指令执行逻辑或
				end
				default:				begin
					logicout <= `ZeroWord;
				end
			endcase
		end    //if
	end      //always


 always @ (*) begin
	 wd_o <= wd_i;	 	 	
	 wreg_o <= wreg_i;
	 case ( alusel_i ) 
	 	`EXE_RES_LOGIC:		begin
	 		wdata_o <= logicout; //wdata_o中存放运算结果
	 	end
	 	default:					begin
	 		wdata_o <= `ZeroWord;
	 	end
	 endcase
 end	

endmodule