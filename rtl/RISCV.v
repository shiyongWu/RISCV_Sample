//---------------------------------------------
//Date: 2021/3/12
//Editer:Shi-Yong Wu
//**********************************************
//       RISC-V CPU TOP module
//----------------------------------------------
`timescale 1ns/1ps
module RISCV
#(
  parameter XLEN = 32
)(
   output [XLEN-1:0] IM_addr_o,
   output            DM_WEN_o,
   output            DM_EN_o,   
   output [XLEN-1:0] DM_addr_o,
   output [XLEN-1:0] DM_data_o,
   input  [XLEN-1:0] IM_data_i,
   input  [XLEN-1:0] DM_data_i,
   input             clk,
   input             rst_n
);
   
   wire [XLEN-1:0] PC_wire;
   wire [XLEN-1:0] instr_wire;
   //For Decoder
   wire      [1:0] RI_COM_sel_wire;
   wire      [2:0] B_COM_sel_wire;
   wire      [1:0] SF_sel_wire;
   wire            ADD_B_sel_wire;
   wire      [1:0] ADD_OP_sel_wire;
   wire      [1:0] ALU_Result_sel_wire;
   wire            REG_WEN_wire;
   wire            DM_enable_n_wire;
   wire            DM_WEN_wire;
   wire            Branch_en_wire;
   wire            Branch_sel_wire;
   wire            Jump_en_wire;
   wire            MUX_ALU_A_sel_wire;
   wire            MUX_ALU_B_sel_wire;
   wire            WB_MUX_sel_wire;
   wire      [1:0] EXE_MUX_sel_wire;
   wire      [2:0] IMM_sel_wire;
   //For IMM
   wire [XLEN-1:0] IMM_V_wire;
   //For FRIST_PIPE output wire
   wire      [1:0]RI_COM_sel_D_wire;
   wire      [2:0]B_COM_sel_D_wire;
   wire      [1:0]SF_sel_D_wire;
   wire           ADD_B_sel_D_wire;
   wire      [1:0]ADD_OP_sel_D_wire;
   wire      [1:0]ALU_Result_sel_D_wire;
   wire           REG_WEN_D_wire;
   wire           DM_enable_n_D_wire;
   wire           DM_WEN_D_wire;
   wire           Branch_en_D_wire;
   wire           Branch_sel_D_wire;
   wire           Jump_en_D_wire;
   wire           MUX_ALU_A_sel_D_wire;
   wire           MUX_ALU_B_sel_D_wire;
   wire           WB_MUX_sel_D_wire;
   wire      [1:0]EXE_MUX_sel_D_wire;
   wire      [4:0]rs1_addr_D_wire;
   wire      [4:0]rs2_addr_D_wire;
   wire      [4:0]rd_addr_D_wire;
   wire [XLEN-1:0]IMM_V_D_wire;
   wire [XLEN-1:0]PC_D_wire;	
   //For RegFile 
   wire [XLEN-1:0] src1_data_wire;
   wire [XLEN-1:0] src2_data_wire;
   //For FORWARD
   wire  src1_forward_sel_wire;
   wire  src2_forward_sel_wire;
   //For ALU wire
   wire [XLEN-1:0] ALU_src1_wire;
   wire [XLEN-1:0] ALU_src2_wire;
   wire [XLEN-1:0] ALU_Result_wire;
   wire            ALU_B_COM_wire;
   // Jump and Branch wire
   wire            PC_sel_wire;
   wire            branch_triggle;
   wire [XLEN-1:0] PC_branch_wire;
   // EXE_DATA wire
   wire [XLEN-1:0] EXE_DATA_wire;
   //SECOND_PIPE wire
   wire [XLEN-1:0] src2_data_D2_wire;
   wire [XLEN-1:0] EXE_DATA_D2_wire;
   wire            REG_WEN_D2_wire;
   wire            DM_enable_n_D2_wire;
   wire            DM_WEN_D2_wire;
   wire            WB_MUX_sel_D2_wire;
   wire      [4:0] rd_addr_D2_wire;
   //write back 
   wire [XLEN-1:0] WB_DATA_wire;
   
   //input
   assign instr_wire = IM_data_i;
   
   PC u_PC(.PC_sel_i(PC_sel_wire),
		   .PC_branch_i(PC_branch_wire),
		   .PC_o(PC_wire),
		   .clk(clk),
           .rst_n(rst_n)
   );
   
   //output
   assign IM_addr_o = PC_wire;
   
   DE u_DE(.RI_COM_sel_o(RI_COM_sel_wire), //for ALU , RI_compare sel
           .B_COM_sel_o(B_COM_sel_wire),  //for ALU , B_compare sel
           .SF_sel_o(SF_sel_wire),     //for ALU 
           .ADD_B_sel_o(ADD_B_sel_wire),
           .ADD_OP_sel_o(ADD_OP_sel_wire),	
           .ALU_Result_sel_o(ALU_Result_sel_wire),
           .REG_WEN_o(REG_WEN_wire),
		   .DM_enable_n_o(DM_enable_n_wire),
           .DM_WEN_o(DM_WEN_wire),
           .Branch_en_o(Branch_en_wire),
           .Branch_sel_o(Branch_sel_wire),
           .Jump_en_o(Jump_en_wire),
           .MUX_ALU_A_sel_o(MUX_ALU_A_sel_wire),
           .MUX_ALU_B_sel_o(MUX_ALU_B_sel_wire),
           .WB_MUX_sel_o(WB_MUX_sel_wire),
           .EXE_MUX_sel_o(EXE_MUX_sel_wire),
           .IMM_sel_o(IMM_sel_wire),
           .opcode_i(instr_wire[6:0]),
           .funct3_i(instr_wire[14:12]),
           .funct7_i(instr_wire[31:25])
   );
   
   IMM u_IMM(.IMM_V_o(IMM_V_wire),
             .IMM_i(instr_wire[31:7]),
			 .IMM_sel_i(IMM_sel_wire)
   );
   
   
   FRIST_PIPE u_FRIST_PIPE(.RI_COM_sel_o(RI_COM_sel_D_wire),
						   .B_COM_sel_o(B_COM_sel_D_wire),
						   .SF_sel_o(SF_sel_D_wire),
						   .ADD_B_sel_o(ADD_B_sel_D_wire),
						   .ADD_OP_sel_o(ADD_OP_sel_D_wire),
						   .ALU_Result_sel_o(ALU_Result_sel_D_wire),
						   .REG_WEN_o(REG_WEN_D_wire),
						   .DM_enable_n_o(DM_enable_n_D_wire),
						   .DM_WEN_o(DM_WEN_D_wire),
						   .Branch_en_o(Branch_en_D_wire),
						   .Branch_sel_o(Branch_sel_D_wire),
						   .Jump_en_o(Jump_en_D_wire),
						   .MUX_ALU_A_sel_o(MUX_ALU_A_sel_D_wire),
						   .MUX_ALU_B_sel_o(MUX_ALU_B_sel_D_wire),
						   .WB_MUX_sel_o(WB_MUX_sel_D_wire),
						   .EXE_MUX_sel_o(EXE_MUX_sel_D_wire),
						   .rs1_addr_o(rs1_addr_D_wire),
						   .rs2_addr_o(rs2_addr_D_wire),
						   .rd_addr_o(rd_addr_D_wire),
						   .IMM_V_o(IMM_V_D_wire),
						   .PC_o(PC_D_wire),
						   //input
                           .RI_COM_sel_i(RI_COM_sel_wire),
						   .B_COM_sel_i(B_COM_sel_wire),
						   .SF_sel_i(SF_sel_wire),
						   .ADD_B_sel_i(ADD_B_sel_wire),
						   .ADD_OP_sel_i(ADD_OP_sel_wire),
						   .ALU_Result_sel_i(ALU_Result_sel_wire),
						   .REG_WEN_i(REG_WEN_wire),
						   .DM_enable_n_i(DM_enable_n_wire),
						   .DM_WEN_i(DM_WEN_wire),
						   .Branch_en_i(Branch_en_wire),
						   .Branch_sel_i(Branch_sel_wire),
						   .Jump_en_i(Jump_en_wire),
						   .MUX_ALU_A_sel_i(MUX_ALU_A_sel_wire),
						   .MUX_ALU_B_sel_i(MUX_ALU_B_sel_wire),
						   .WB_MUX_sel_i(WB_MUX_sel_wire),
						   .EXE_MUX_sel_i(EXE_MUX_sel_wire),
						   .rs1_addr_i(instr_wire[19:15]),
						   .rs2_addr_i(instr_wire[24:20]),
						   .rd_addr_i(instr_wire[11:7]),
						   .IMM_V_i(IMM_V_wire),
						   .PC_i(PC_wire),
                                                   .branch_i(PC_sel_wire),
						   .clk(clk),
						   .rst_n(rst_n)
   );
   //--------------------------------------------------------------------------
   REGFILE u_REGFILE(.src1_data_o(src1_data_wire),
                     .src2_data_o(src2_data_wire),
					 .src1_addr_i(rs1_addr_D_wire),
					 .src2_addr_i(rs2_addr_D_wire),
					 .rd_addr_i(rd_addr_D2_wire),
                     .WEN_i(REG_WEN_D2_wire),
					 .data_i(WB_DATA_wire),
					 .clk(clk),
					 .rst_n(rst_n)
   );
      
   FORWARD u_FORWARD(.src1_forward_sel(src1_forward_sel_wire),
                     .src2_forward_sel(src2_forward_sel_wire),
                     .src1_de(rs1_addr_D_wire),
                     .src2_de(rs2_addr_D_wire),
                     .rd_wb(rd_addr_D2_wire)
   );

   assign ALU_src1_wire = (MUX_ALU_A_sel_D_wire  == 1'd1) ? PC_D_wire    :
                          (src1_forward_sel_wire == 1'd1) ? WB_DATA_wire : src1_data_wire;
   assign ALU_src2_wire = (MUX_ALU_B_sel_D_wire  == 1'd1) ? IMM_V_D_wire :
                          (src2_forward_sel_wire == 1'd1) ? WB_DATA_wire : src2_data_wire;
   
   ALU u_ALU(.src1(ALU_src1_wire),
             .src2(ALU_src2_wire),
             .RI_COM_sel_i(RI_COM_sel_D_wire),
             .B_COM_sel_i(B_COM_sel_D_wire),
             .SF_sel_i(SF_sel_D_wire),
             .ADD_B_sel_i(ADD_B_sel_D_wire),
             .ADD_OP_sel_i(ADD_OP_sel_D_wire),
             .ALU_Result_sel_i(ALU_Result_sel_D_wire),
             .B_COM_o(ALU_B_COM_wire),  
             .Result_o(ALU_Result_wire)
   );
   
   assign PC_branch_wire = (Jump_en_D_wire == 1'b1) ? ALU_Result_wire : (PC_D_wire + IMM_V_D_wire);
   assign branch_triggle = (ALU_B_COM_wire & Branch_en_D_wire);
   assign PC_sel_wire    = (branch_triggle ^ Jump_en_D_wire);
   
   assign EXE_DATA_wire  = (EXE_MUX_sel_D_wire == 2'd1) ? IMM_V_D_wire:
                           (EXE_MUX_sel_D_wire == 2'd2) ? (PC_D_wire + 32'd4) : ALU_Result_wire;
   
   
   SECOND_PIPE u_SECOND_PIPE(.src2_DATA_o(src2_data_D2_wire),
                             .EXE_DATA_o(EXE_DATA_D2_wire),
                             .REG_WEN_o(REG_WEN_D2_wire),
                             .DM_enable_n_o(DM_enable_n_D2_wire),
                             .DM_WEN_o(DM_WEN_D2_wire),
                             .WB_MUX_sel_o(WB_MUX_sel_D2_wire),
                             .rd_addr_o(rd_addr_D2_wire),
                             .src2_data_i(src2_data_wire),
                             .EXE_DATA_i(EXE_DATA_wire),
                             .REG_WEN_i(REG_WEN_D_wire),
                             .DM_enable_n_i(DM_enable_n_D_wire),
                             .DM_WEN_i(DM_WEN_D_wire),
                             .WB_MUX_sel_i(WB_MUX_sel_D_wire),
                             .rd_addr_i(rd_addr_D_wire),
                             .branch_i(branch_triggle),
                             .clk(clk),
                             .rst_n(rst_n)
   );
   
   assign WB_DATA_wire = (WB_MUX_sel_D2_wire == 1'b1) ? DM_data_i : EXE_DATA_D2_wire;
   //output
   assign DM_WEN_o  = DM_WEN_D2_wire;
   assign DM_EN_o   = DM_enable_n_D2_wire;
   assign DM_addr_o = EXE_DATA_D2_wire;
   assign DM_data_o = src2_data_D2_wire;
   
endmodule
