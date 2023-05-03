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
// Module:  if_id
// File:    if_id.v
// Author:  Lei Silei
// E-mail:  leishangwen@163.com
// Description: IF/ID阶段的寄存器
// Revision: 1.0
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module if_id(

	input	wire				  clk, //时钟信号
	input wire					  rst, //复位信号
	
	// 来自取指令阶段的信号，其中宏定义InstBus表示指令宽度，为32
	input wire[`InstAddrBus]	  if_pc, // pc_reg模块输出的pc作为输入
	input wire[`InstBus]          if_inst,//pc_reg模块输出的pc从指令存储器取出的指令作为输入

	// 对应译码阶段的信号
	output reg[`InstAddrBus]      id_pc, //用来传递上述两个信号
	output reg[`InstBus]          id_inst  
	
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			id_pc <= `ZeroWord;	//复位的时候pc为0
			id_inst <= `ZeroWord;	//复位的时候指令也为0，实际就是空指令
	  end else begin
		  id_pc <= if_pc;	// 其余时刻向下传递取值阶段的值
		  id_inst <= if_inst;
		end
	end

endmodule