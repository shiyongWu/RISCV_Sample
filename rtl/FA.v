//---------------------------------------------
//Date: 2021/3/12
//Editer:Shi-Yong Wu
//**********************************************
//       1-bit Full adder
//----------------------------------------------
`timescale 1ns/1ps
module FA(
    input  A_i,
	input  B_i,
	input  C_i,
	output S_o, //Sum out
	output CA_o //Carry out
);

  assign S_o = A_i ^ B_i ^ C_i;
  assign CA_o = ((A_i & B_i) ^ ((A_i ^ B_i) & C_i));

endmodule 