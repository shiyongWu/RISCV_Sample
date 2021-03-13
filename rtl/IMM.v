//---------------------------------------------
//Date: 2021/3/11
//Editer:Shi-Yong Wu
//**********************************************
//       immediate value generator
//----------------------------------------------
`timescale 1ns/1ps
module IMM
#(
  parameter XLEN = 32
  parameter INST = 25
)
(
    input  [INST-1:0] IMM_i,
	input  [2:0]      IMM_sel_i,
    output [XLEN-1:0] IMM_V_o
);

   wire [XLEN-1:0] I_TYPE_IMM_V;
   wire [XLEN-1:0] S_TYPE_IMM_V;
   wire [XLEN-1:0] B_TYPE_IMM_V;
   wire [XLEN-1:0] U_TYPE_IMM_V;
   wire [XLEN-1:0] J_TYPE_IMM_V;
   
   assign I_TYPE_IMM_V = { {21{IMM_i[24]}},IMM_i[23:18],IMM_i[17:14],IMM_i[13]};
   assign S_TYPE_IMM_V = { {21{IMM_i[24]}},IMM_i[23:18],IMM_i[4:1],IMM_i[0]};
   assign B_TYPE_IMM_V = { {20{IMM_i[24]}},IMM_i[0],IMM_i[23:18],IMM_i[4:1],1'd0};
   assign U_TYPE_IMM_V = { IMM_i[24],IMM_i[23:13],IMM_i[12:5],12'd0};
   assign J_TYPE_IMM_V = { {12{IMM_i[24]}},IMM_i[12:5],IMM_i[13],IMM_i[23:18],IMM_i[17:14],1'd0};
   
   assign IMM_V_o = ( IMM_sel_i == 3'd1) ? I_TYPE_IMM_V :
                    ( IMM_sel_i == 3'd2) ? S_TYPE_IMM_V :
					( IMM_sel_i == 3'd3) ? B_TYPE_IMM_V :
					( IMM_sel_i == 3'd4) ? U_TYPE_IMM_V :
					( IMM_sel_i == 3'd5) ? J_TYPE_IMM_V : ({XLEN{1'd1}});

endmodule
