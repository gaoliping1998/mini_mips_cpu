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
// Description: ָ��ָ��Ĵ���PC
// Revision: 1.0
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module pc_reg(

	input	wire										clk,
	input wire										rst,
	
	output reg[`InstAddrBus]			pc,
	output reg                    ce
	
);

	always @ (posedge clk) begin		// ʱ�������صľͰ�pc���и��£��������뵽�����ǲ���һ��cc�Ϳ��Ը��ˣ����ص�5��cc�ٸ��£�
		if (ce == `ChipDisable) begin  //ָ��洢�����õ�ʱ��pcΪ0��ͦ�����ģ��洢��������ʱ�򣬾�����pcҲ���ܴӴ洢��������ָ��
			pc <= 32'h00000000;
		end else begin            // ָ��洢��ʹ�ܵ�ʱ��pc��ֵÿʱ�����ڼ�4����߼�4����Ϊָ����4B
	 		pc <= pc + 4'h4;
		end
	end
	
	always @ (posedge clk) begin
		if (rst == `RstEnable) begin  // ��λ��ʱ��ָ��洢������
			ce <= `ChipDisable;
		end else begin
			ce <= `ChipEnable;	// ��λ������ָ��洢��ʹ��
		end
	end

endmodule