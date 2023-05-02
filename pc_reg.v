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
// Module:  pc_reg
// File:    pc_reg.v
// Author:  Lei Silei
// E-mail:  leishangwen@163.com
// Description: 指令指针寄存器PC
// Revision: 1.0
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module pc_reg(

	input	wire										clk,
	input wire										rst,
	
	output reg[`InstAddrBus]			pc,
	output reg                    ce
	
);

	always @ (posedge clk) begin		// 时钟上升沿的就把pc进行更新，这里联想到计组是不是一个cc就可以改了？不必等5个cc再更新？
		if (ce == `ChipDisable) begin  //指令存储器禁用的时候，pc为0。挺好理解的，存储器不开的时候，就算有pc也不能从存储器里面拿指令
			pc <= 32'h00000000;
		end else begin            // 指令存储器使能的时候，pc的值每时钟周期加4。这边加4是因为指令是4B
	 		pc <= pc + 4'h4;
		end
	end
	
	always @ (posedge clk) begin
		if (rst == `RstEnable) begin  // 复位的时候指令存储器禁用
			ce <= `ChipDisable;
		end else begin
			ce <= `ChipEnable;	// 复位结束后，指令存储器使能
		end
	end

endmodule