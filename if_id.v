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
// Description: IF/ID�׶εļĴ���
// Revision: 1.0
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module if_id(

	input	wire				  clk, //ʱ���ź�
	input wire					  rst, //��λ�ź�
	
	// ����ȡָ��׶ε��źţ����к궨��InstBus��ʾָ���ȣ�Ϊ32
	input wire[`InstAddrBus]	  if_pc, // pc_regģ�������pc��Ϊ����
	input wire[`InstBus]          if_inst,//pc_regģ�������pc��ָ��洢��ȡ����ָ����Ϊ����

	// ��Ӧ����׶ε��ź�
	output reg[`InstAddrBus]      id_pc, //�����������������ź�
	output reg[`InstBus]          id_inst  
	
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			id_pc <= `ZeroWord;	//��λ��ʱ��pcΪ0
			id_inst <= `ZeroWord;	//��λ��ʱ��ָ��ҲΪ0��ʵ�ʾ��ǿ�ָ��
	  end else begin
		  id_pc <= if_pc;	// ����ʱ�����´���ȡֵ�׶ε�ֵ
		  id_inst <= if_inst;
		end
	end

endmodule