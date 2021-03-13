//---------------------------------------------
//Date: 2021/3/10
//Editer:Shi-Yong Wu
//**********************************************
//       32-bit RISC-V (I) Instructions Decoder
//----------------------------------------------
`timescale 1ns/1ps

module DE(
   input  [6:0] opcode_i, // inst[6:0]
   input  [2:0] funct3_i, // inst[14:12]
   input  [6:0] funct7_i, // inst[31:25]
   output [2:0] ALU_mode_sel_o,
   output       REG_WEN_o,
   output       DM_WEN_o,
   output       Branch_en_o,
   output       Branch_sel_o,
   output       Jump_en_o,
   output       Mux_ALB_B_sel_o,
   output       Mux_ALB_A_sel_o,
   output       WB_MUX_sel_o,
   output [1:0] EXE_mux_sel_o,   
   output [2:0] IMM_sel_o
);
   // opcode
   parameter R_TYPE_OP     = 7'b011_0011; 
   parameter S_TYPE_OP     = 7'b010_0011; 
   parameter I_TYPE_REG_OP = 7'b001_0011; 
   parameter I_TYPE_MEM_OP = 7'b000_0011;
   parameter B_TYPE_OP     = 7'b110_0011;
   parameter U_TYPE_OP_1   = 7'b011_0111; //lui
   parameter U_TYPE_OP_2   = 7'b001_0111; //auipc
   parameter J_TYPE_OP_1   = 7'b110_0111; //jalr
   parameter J_TYPE_OP_2   = 7'b110_1111; //jal
   //B-Type funct3 
   //beq    funct3 =3'd0 (3'b000)
   //bne    funct3 =3'd1 (3'b001) 
   //blt    funct3 =3'd4 (3'b100)
   //bge    funct3 =3'd5 (3'b101)
   //bltu   funct3 =3'd6 (3'b110)
   //bgeu   funct3 =3'd7 (3'b111)
   //for R-type 
   parameter FUN3_ADD  = 3'b000; // funct7 = 7'd32 , sub
   parameter FUN3_Sll  = 3'b001;
   parameter FUN3_SLT  = 3'b010;
   parameter FUN3_SLTU = 3'b011;
   parameter FUN3_XOR  = 3'b100;
   parameter FUN3_SR   = 3'b101; // funct7 = 7'd0 , logic shift (srl), funct7 = 7'd16 arthmetic shift (sra)
   parameter FUN3_OR   = 3'b110;
   parameter FUN3_AND  = 3'b111;

   
   // I,S,B,U,J 
   // Immediate mux
   assign IMM_sel_o = ((opcode_i == I_TYPE_REG_OP)||(opcode_i == I_TYPE_MEM_OP)) ? 3'd1:
                      (opcode_i == S_TYPE_OP) ? 3'd2 :
					  (opcode_i == B_TYPE_OP) ? 3'd3 :
					  ((opcode_i == U_TYPE_OP_1)||(opcode_i == U_TYPE_OP_2)) ? 3'd4 :
					  ((opcode_i == J_TYPE_OP_1)||(opcode_i == J_TYPE_OP_2)) ? 3'd5 : 3'd0;
   // funct3 : 000
   // ALU    : ADD
   // R-type : add , sub; I-type: addi; B-type: beq(?) how to use adder 
   // add , normal carry ripple adder
   // XOR , C_wire = 32'd0 , result = sum_wire
   // OR  , C_wire = {32{1'b1}}, result = CA_wire
   // AND , C_wire = 32'd0 , result = CA_wire
   assign   ALU_mode_sel_o = (funct3 == FUN3_XOR) ? 3'd1 : 
                             (funct3 == FUN3_OR)  ? 3'd2 :
                             (funct3 == FUN3_AND) ? 3'd3 : 3'd0;
   //register write back enable
   //R-type,I-type, U_type ,J_type : 0
   // S_type , B_type = 1
   assign REG_WEN_o = ((opcode_i == S_TYPE_OP) || ( opcode_i == B_TYPE_OP));
   //Mem write enable  negative
   assign DM_WEN_o  = ~ (opcode_i == S_TYPE_OP);
   //Jump condition 
   assign Jump_en_o = (opcode_i == J_TYPE_OP_1) || ( opcode_i == J_TYPE_OP_2);
   //branch condition
   assign branch_en_o = (opcode_i == B_TYPE_OP);
   // jalr is different .
   assign Branch_sel_o = (opcode_i == J_TYPE_OP_1);
   
   assign Mux_ALB_A_sel_o = (opcode_i == U_TYPE_OP_2);
   //MUX_ALB_B_sel
   // R: 0  U : don't care
   // S: 1  Jalr :  1
   // I: 1  Jal : don't care
   // B: 0    
   assign Mux_ALB_B_sel_o = ~ ((opcode_i == R_TYPE_OP) || (opcode == B_TYPE_OP));
     
   assign WB_MUX_sel_o  =  (opcode_i == I_TYPE_MEM_OP);
   
   assign EXE_mux_sel_o = ((opcode_i == U_TYPE_OP_1)) ? 2'd1 :
                          ((opcode_i == J_TYPE_OP_1) || (opcode_i == J_TYPE_OP_2)) ? 2'd2 : 2'd0;
endmodule
