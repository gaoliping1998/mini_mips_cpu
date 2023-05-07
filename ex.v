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
// Description: ִ�н׶�
// Revision: 1.0
//////////////////////////////////////////////////////////////////////

`include "defines.v"

module ex(

	input wire					  rst ,
	
	//�͵�ִ�н׶ε���Ϣ
	input wire[`AluOpBus]         aluop_i,//����������
	input wire[`AluSelBus]        alusel_i,//��������
	input wire[`RegBus]           reg1_i,//Դ������1
	input wire[`RegBus]           reg2_i,//Դ������2
	input wire[`RegAddrBus]       wd_i,//Ҫд���Ŀ�ļĴ�����ַ
	input wire                    wreg_i,//�Ƿ�Ҫд��Ŀ�ļĴ���

	
	output reg[`RegAddrBus]       wd_o,//Ҫд���Ŀ�ļĴ�����ַ
	output reg                    wreg_o,//�Ƿ�Ҫд��Ŀ�ļĴ���
	output reg[`RegBus]			  wdata_o//Ҫд���Ŀ�ļĴ�����ֵ
	
);

	reg[`RegBus] logicout;//�����߼�����Ľ������������ΪʲôҪ��һ���Ĵ�����û�����Ļ�����Ҳ���Դ浽�����EX/MEM��ˮ�Ĵ�������
	always @ (*) begin
		if(rst == `RstEnable) begin
			logicout <= `ZeroWord;
		end else begin
			case (aluop_i) //����aluop_iָʾ�����������ͽ�������
				`EXE_OR_OP:			begin
					logicout <= reg1_i | reg2_i;//oriָ��ִ���߼���
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
	 		wdata_o <= logicout; //wdata_o�д��������
	 	end
	 	default:					begin
	 		wdata_o <= `ZeroWord;
	 	end
	 endcase
 end	

endmodule