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
// Description: ͨ�üĴ�������32��
// Revision: 1.0
//////////////////////////////////////////////////////////////////////

`include "defines.v"

// ����һд
module regfile(

	input wire						clk,
	input wire						rst,
	
	//д�˿�
	input wire						we,
	input wire[`RegAddrBus]			waddr,
	input wire[`RegBus]				wdata,
	
	//���˿�1
	input wire						re1,
	input wire[`RegAddrBus]			raddr1,
	output reg[`RegBus]           	rdata1,
	
	//���˿�2
	input wire						re2,
	input wire[`RegAddrBus]			raddr2,
	output reg[`RegBus]           	rdata2
	
);

	reg[`RegBus]  regs[0:`RegNum-1]; //������һ����ά��������32��32λ�Ĵ���

	//д�Ĵ���������ʱ���߼���·��д����������ʱ���źŵ�������
	always @ (posedge clk) begin
		if (rst == `RstDisable) begin //����λ�ź���Чʱ
			if((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin //��дʹ���ź�we��Ч����д����Ŀ�ļĴ���������0����Ϊmips32�涨�Ĵ���$0��ֵֻ��Ϊ0�����Բ�Ҫд�룩
				regs[waddr] <= wdata; // ��д���ݱ��浽Ŀ�ļĴ���
			end
		end
	end
	
	//���Ĵ�������������߼���·��һ�������raddr�����仯����ô�����������µ�ַ��Ӧ�ļĴ�����ֵ
	always @ (*) begin
		if(rst == `RstEnable) begin //����λ�ź���Чʱ����һ�����Ĵ����˿ڵ����ʼ��Ϊ0
			  rdata1 <= `ZeroWord;		
	  end else if(raddr1 == `RegNumLog2'h0) begin //����λ�ź���Ч��ʱ�������ȡ����$0����ôֱ�Ӹ���0
	  		rdata1 <= `ZeroWord;
	  end else if((raddr1 == waddr) && (we == `WriteEnable) //�����һ�����Ĵ����˿�Ҫ��ȡ��Ŀ��Ĵ�����Ҫд���Ŀ�ļĴ�����ͬһ���Ĵ�������ôֱ�ӽ�Ҫд���ֵ��Ϊ��һ�����Ĵ����˿ڵ����
	  	            && (re1 == `ReadEnable)) begin
	  	  rdata1 <= wdata;
	  end else if(re1 == `ReadEnable) begin //�����������������㣬��ô������һ�����Ĵ����˿�Ҫ��ȡ��Ŀ��Ĵ�����ַ��Ӧ�Ĵ�����ֵ
	      rdata1 <= regs[raddr1];
	  end else begin	//��һ�����Ĵ����˿ڲ���ʹ��ʱ��ֱ�����0
	      rdata1 <= `ZeroWord;
	  end
	end

	always @ (*) begin  // �ڶ������Ĵ����˿�������ͬ��
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