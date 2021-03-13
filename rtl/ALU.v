//---------------------------------------------
//Date: 2021/3/12
//Editer:Shi-Yong Wu
//**********************************************
//       ALU
//----------------------------------------------
`timescale 1ns/1ps
module ALU
#(
   parameter XLEN = 32
)(
   input  [XLEN-1:0] src1,
   input  [XLEN-1:0] src2,
   input
   output [XLEN-1:0] Result_o,
   output            overflow_o
);
  
   wire [XLEN-1:0] A_wire;
   wire [XLEN-1:0] B_wire;
   wire [XLEN-1:0] C_wire;
   wire [XLEN-1:0] Sum_wire; 
   wire [XLEN-1:0] CA_wire;
   
   //input
   assign A_wire = src1;
   assign B_wire = src2;
   // C_wire is 32'd0 ,then Sum_wire = A ^ B
   // 
   assign C_wire = () 32'b0 : {CA_wire[30:0],1'b0};
   
   // 32-bit carry ripple adder
   FA FA0(.A_i(A_wire[0]),.B_i(B_wire[0]),.C_i(C_wire[0]),.S_o(Sum_wire[0]),.CA_o(CA_wire[0]));
   FA FA1(.A_i(A_wire[1]),.B_i(B_wire[1]),.C_i(C_wire[1]),.S_o(Sum_wire[1]),.CA_o(CA_wire[1]));
   FA FA2(.A_i(A_wire[2]),.B_i(B_wire[2]),.C_i(C_wire[2]),.S_o(Sum_wire[2]),.CA_o(CA_wire[2]));
   FA FA3(.A_i(A_wire[3]),.B_i(B_wire[3]),.C_i(C_wire[3]),.S_o(Sum_wire[3]),.CA_o(CA_wire[3]));
   FA FA4(.A_i(A_wire[4]),.B_i(B_wire[4]),.C_i(C_wire[4]),.S_o(Sum_wire[4]),.CA_o(CA_wire[4]));
   FA FA5(.A_i(A_wire[5]),.B_i(B_wire[5]),.C_i(C_wire[5]),.S_o(Sum_wire[5]),.CA_o(CA_wire[5]));
   FA FA6(.A_i(A_wire[6]),.B_i(B_wire[6]),.C_i(C_wire[6]),.S_o(Sum_wire[6]),.CA_o(CA_wire[6]));
   FA FA7(.A_i(A_wire[7]),.B_i(B_wire[7]),.C_i(C_wire[7]),.S_o(Sum_wire[7]),.CA_o(CA_wire[7]));
   FA FA8(.A_i(A_wire[8]),.B_i(B_wire[8]),.C_i(C_wire[8]),.S_o(Sum_wire[8]),.CA_o(CA_wire[8]));
   FA FA9(.A_i(A_wire[9]),.B_i(B_wire[9]),.C_i(C_wire[9]),.S_o(Sum_wire[9]),.CA_o(CA_wire[9]));
   FA FA10(.A_i(A_wire[10]),.B_i(B_wire[10]),.C_i(C_wire[10]),.S_o(Sum_wire[10]),.CA_o(CA_wire[10]));
   FA FA11(.A_i(A_wire[11]),.B_i(B_wire[11]),.C_i(C_wire[11]),.S_o(Sum_wire[11]),.CA_o(CA_wire[11]));
   FA FA12(.A_i(A_wire[12]),.B_i(B_wire[12]),.C_i(C_wire[12]),.S_o(Sum_wire[12]),.CA_o(CA_wire[12]));
   FA FA13(.A_i(A_wire[13]),.B_i(B_wire[13]),.C_i(C_wire[13]),.S_o(Sum_wire[13]),.CA_o(CA_wire[13]));
   FA FA14(.A_i(A_wire[14]),.B_i(B_wire[14]),.C_i(C_wire[14]),.S_o(Sum_wire[14]),.CA_o(CA_wire[14]));
   FA FA15(.A_i(A_wire[15]),.B_i(B_wire[15]),.C_i(C_wire[15]),.S_o(Sum_wire[15]),.CA_o(CA_wire[15]));
   FA FA16(.A_i(A_wire[16]),.B_i(B_wire[16]),.C_i(C_wire[16]),.S_o(Sum_wire[16]),.CA_o(CA_wire[16]));
   FA FA17(.A_i(A_wire[17]),.B_i(B_wire[17]),.C_i(C_wire[17]),.S_o(Sum_wire[17]),.CA_o(CA_wire[17]));
   FA FA18(.A_i(A_wire[18]),.B_i(B_wire[18]),.C_i(C_wire[18]),.S_o(Sum_wire[18]),.CA_o(CA_wire[18]));
   FA FA19(.A_i(A_wire[19]),.B_i(B_wire[19]),.C_i(C_wire[19]),.S_o(Sum_wire[19]),.CA_o(CA_wire[19]));
   FA FA20(.A_i(A_wire[20]),.B_i(B_wire[20]),.C_i(C_wire[20]),.S_o(Sum_wire[20]),.CA_o(CA_wire[20]));
   FA FA21(.A_i(A_wire[21]),.B_i(B_wire[21]),.C_i(C_wire[21]),.S_o(Sum_wire[21]),.CA_o(CA_wire[21]));
   FA FA22(.A_i(A_wire[22]),.B_i(B_wire[22]),.C_i(C_wire[22]),.S_o(Sum_wire[22]),.CA_o(CA_wire[22]));
   FA FA23(.A_i(A_wire[23]),.B_i(B_wire[23]),.C_i(C_wire[23]),.S_o(Sum_wire[23]),.CA_o(CA_wire[23]));
   FA FA24(.A_i(A_wire[24]),.B_i(B_wire[24]),.C_i(C_wire[24]),.S_o(Sum_wire[24]),.CA_o(CA_wire[24]));
   FA FA25(.A_i(A_wire[25]),.B_i(B_wire[25]),.C_i(C_wire[25]),.S_o(Sum_wire[25]),.CA_o(CA_wire[25]));
   FA FA26(.A_i(A_wire[26]),.B_i(B_wire[26]),.C_i(C_wire[26]),.S_o(Sum_wire[26]),.CA_o(CA_wire[26]));
   FA FA27(.A_i(A_wire[27]),.B_i(B_wire[27]),.C_i(C_wire[27]),.S_o(Sum_wire[27]),.CA_o(CA_wire[27]));
   FA FA28(.A_i(A_wire[28]),.B_i(B_wire[28]),.C_i(C_wire[28]),.S_o(Sum_wire[28]),.CA_o(CA_wire[28]));
   FA FA29(.A_i(A_wire[29]),.B_i(B_wire[29]),.C_i(C_wire[29]),.S_o(Sum_wire[29]),.CA_o(CA_wire[29]));
   FA FA30(.A_i(A_wire[30]),.B_i(B_wire[30]),.C_i(C_wire[30]),.S_o(Sum_wire[30]),.CA_o(CA_wire[30]));
   FA FA31(.A_i(A_wire[31]),.B_i(B_wire[31]),.C_i(C_wire[31]),.S_o(Sum_wire[31]),.CA_o(CA_wire[31]));
   
   //output 
   assign Result_o    = Sum_wire;
   assign overflow_o  = CA_wire[31];
   
endmodule 
