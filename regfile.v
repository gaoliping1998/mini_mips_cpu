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
// Module:  regfile
// File:    regfile.v
// Author:  Lei Silei
// E-mail:  leishangwen@163.com
// Description: 通用寄存器，共32个
// Revision: 1.0
//////////////////////////////////////////////////////////////////////

`include "defines.v"

// 两读一写
module regfile(

	input wire						clk,
	input wire						rst,
	
	//写端口
	input wire						we,
	input wire[`RegAddrBus]			waddr,
	input wire[`RegBus]				wdata,
	
	//读端口1
	input wire						re1,
	input wire[`RegAddrBus]			raddr1,
	output reg[`RegBus]           	rdata1,
	
	//读端口2
	input wire						re2,
	input wire[`RegAddrBus]			raddr2,
	output reg[`RegBus]           	rdata2
	
);

	reg[`RegBus]  regs[0:`RegNum-1]; //定义了一个二维向量，即32个32位寄存器

	//写寄存器操作是时序逻辑电路，写操作发生在时钟信号的上升沿
	always @ (posedge clk) begin
		if (rst == `RstDisable) begin //当复位信号无效时
			if((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin //在写使能信号we有效，且写操作目的寄存器不等于0（因为mips32规定寄存器$0的值只能为0，所以不要写入）
				regs[waddr] <= wdata; // 将写数据保存到目的寄存器
			end
		end
	end
	
	//读寄存器操作是组合逻辑电路，一旦输入的raddr发生变化，那么会立即给出新地址对应的寄存器的值
	always @ (*) begin
		if(rst == `RstEnable) begin //当复位信号有效时，第一个读寄存器端口的输出始终为0
			  rdata1 <= `ZeroWord;		
	  end else if(raddr1 == `RegNumLog2'h0) begin //当复位信号无效的时候，如果读取的是$0，那么直接给出0
	  		rdata1 <= `ZeroWord;
	  end else if((raddr1 == waddr) && (we == `WriteEnable) //如果第一个读寄存器端口要读取的目标寄存器与要写入的目的寄存器是同一个寄存器，那么直接将要写入的值作为第一个读寄存器端口的输出
	  	            && (re1 == `ReadEnable)) begin
	  	  rdata1 <= wdata;
	  end else if(re1 == `ReadEnable) begin //如果上述情况都不满足，那么给出第一个读寄存器端口要读取的目标寄存器地址对应寄存器的值
	      rdata1 <= regs[raddr1];
	  end else begin	//第一个读寄存器端口不能使用时，直接输出0
	      rdata1 <= `ZeroWord;
	  end
	end

	always @ (*) begin  // 第二个读寄存器端口与上面同理
		if(rst == `RstEnable) begin
			  rdata2 <= `ZeroWord;
	  end else if(raddr2 == `RegNumLog2'h0) begin
	  		rdata2 <= `ZeroWord;
	  end else if((raddr2 == waddr) && (we == `WriteEnable) 
	  	            && (re2 == `ReadEnable)) begin
	  	  rdata2 <= wdata;
	  end else if(re2 == `ReadEnable) begin
	      rdata2 <= regs[raddr2];
	  end else begin
	      rdata2 <= `ZeroWord;
	  end
	end

endmodule