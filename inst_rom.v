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
// Module:  inst_rom
// File:    inst_rom.v
// Author:  Lei Silei
// E-mail:  leishangwen@163.com
// Description: 指令存储器
// Revision: 1.0
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module inst_rom(

//	input	wire										clk,
	input wire                    		ce,//使能信号
	input wire[`InstAddrBus]			addr,//要读取的指令地址
	output reg[`InstBus]				inst//读出的指令
	
);

	reg[`InstBus]  inst_mem[0:`InstMemNum-1];//使用二维向量定义存储器，2^17个单元，难道地址线是17根吗？

	initial $readmemh ( "inst_rom.data", inst_mem );//使用系统函数$readmemh来初始化存储器，注意只能用在仿真中，不可综合

	always @ (*) begin
		if (ce == `ChipDisable) begin
			inst <= `ZeroWord;
	  end else begin
		  inst <= inst_mem[addr[`InstMemNumLog2+1:2]];//指令地址是32位的，将第2-18位取出作为存储器地址
		end
	end

endmodule