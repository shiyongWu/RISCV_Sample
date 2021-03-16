//---------------------------------------------------------
//Date: 2021/3/14
//Editer:Shi-Yong Wu
//*********************************************************
//      IF,ID output register ( the frist pipeline stage)
//---------------------------------------------------------
`timescale 1ns/1ps
module FRIST_PIPE
#(
    parameter XLEN = 32,
	parameter ZERO = 32'd0
)
(
     output reg      [1:0]RI_COM_sel_o,
	 output reg      [2:0]B_COM_sel_o,
	 output reg      [1:0]SF_sel_o,
     output reg           ADD_B_sel_o,
     output reg      [1:0]ADD_OP_sel_o,
     output reg      [1:0]ALU_Result_sel_o,
     output reg           REG_WEN_o,
     output reg           DM_enable_n_o,
	 output reg           DM_WEN_o,
	 output reg           Branch_en_o,
	 output reg           Branch_sel_o,
	 output reg           Jump_en_o,
	 output reg           MUX_ALU_A_sel_o,
	 output reg           MUX_ALU_B_sel_o,
	 output reg           WB_MUX_sel_o,
	 output reg      [1:0]EXE_MUX_sel_o,
	 output reg      [4:0]rs1_addr_o,
	 output reg      [4:0]rs2_addr_o,
	 output reg      [4:0]rd_addr_o,
	 output reg [XLEN-1:0]IMM_V_o,
	 output reg [XLEN-1:0]PC_o,	 
	 input      [1:0]RI_COM_sel_i,  
	 input      [2:0]B_COM_sel_i,
	 input      [1:0]SF_sel_i,
	 input           ADD_B_sel_i,
	 input      [1:0]ADD_OP_sel_i,
	 input      [1:0]ALU_Result_sel_i,
	 input           REG_WEN_i,
	 input           DM_enable_n_i,
	 input           DM_WEN_i,
	 input           Branch_en_i,
	 input           Branch_sel_i,
	 input           Jump_en_i,
	 input           MUX_ALU_A_sel_i,
	 input           MUX_ALU_B_sel_i,
	 input           WB_MUX_sel_i,
	 input      [1:0]EXE_MUX_sel_i,
	 input      [4:0]rs1_addr_i,
	 input      [4:0]rs2_addr_i,
	 input      [4:0]rd_addr_i,
	 input [XLEN-1:0]IMM_V_i,
	 input [XLEN-1:0]PC_i,
     input  	     clk,
	 input           rst_n
);

     wire      [1:0]RI_COM_sel_wire;
	 wire      [2:0]B_COM_sel_wire;
	 wire      [1:0]SF_sel_wire;
     wire           ADD_B_sel_wire;
     wire      [1:0]ADD_OP_sel_wire;
     wire      [1:0]ALU_Result_sel_wire;
     wire           REG_WEN_wire;
     wire           DM_enable_n_wire;
	 wire           DM_WEN_wire;
	 wire           Branch_en_wire;
	 wire           Branch_sel_wire;
	 wire           Jump_en_wire;
	 wire           MUX_ALU_A_sel_wire;
	 wire           MUX_ALU_B_sel_wire;
	 wire           WB_MUX_sel_wire;
	 wire      [1:0]EXE_MUX_sel_wire;
	 wire      [4:0]rs1_addr_wire;
	 wire      [4:0]rs2_addr_wire;
	 wire      [4:0]rd_addr_wire;
	 wire [XLEN-1:0]IMM_V_wire;
	 wire [XLEN-1:0]PC_wire;	 


     assign RI_COM_sel_wire     = RI_COM_sel_i;
	 assign B_COM_sel_wire      = B_COM_sel_i;
	 assign SF_sel_wire         = SF_sel_i;
	 assign ADD_B_sel_wire      = ADD_B_sel_i;
	 assign ADD_OP_sel_wire     = ADD_OP_sel_i;
	 assign ALU_Result_sel_wire = ALU_Result_sel_i;
	 assign REG_WEN_wire        = REG_WEN_i;
	 assign DM_enable_n_wire    = DM_enable_n_i;
	 assign DM_WEN_wire         = DM_WEN_i;
     assign Branch_en_wire      = Branch_en_i;
     assign Branch_sel_wire     = Branch_sel_i;
     assign Jump_en_wire        = Jump_en_i;
     assign MUX_ALU_A_sel_wire  = MUX_ALU_A_sel_i;
     assign MUX_ALU_B_sel_wire  = MUX_ALU_B_sel_i;
     assign WB_MUX_sel_wire     = WB_MUX_sel_i;
     assign EXE_MUX_sel_wire    = EXE_MUX_sel_i;
     assign rs1_addr_wire       = rs1_addr_i;
     assign rs2_addr_wire       = rs2_addr_i;
     assign rd_addr_wire        = rd_addr_i;
     assign IMM_V_wire          = IMM_V_i;
     assign PC_wire             = PC_i;





     always@(posedge clk)begin
       if(~rst_n)begin
         RI_COM_sel_o       <=  2'd0;
         B_COM_sel_o        <=  3'd0;
         SF_sel_o           <=  2'd0;
         ADD_B_sel_o        <=  1'd0;
         ADD_OP_sel_o       <=  2'd0;
         ALU_Result_sel_o   <=  2'd0;
         REG_WEN_o          <=  1'd1;
         DM_enable_n_o      <=  1'd1;
         DM_WEN_o           <=  1'd1;
         Branch_en_o        <=  1'd0;
         Branch_sel_o       <=  1'd0;
         Jump_en_o          <=  1'd0;
         MUX_ALU_A_sel_o    <=  1'd0;
         MUX_ALU_B_sel_o    <=  1'd0;
         WB_MUX_sel_o       <=  1'd0;
         EXE_MUX_sel_o      <=  2'd0;
         rs1_addr_o         <=  5'd0;
         rs2_addr_o         <=  5'd0;
         rd_addr_o          <=  5'd0;
	     IMM_V_o            <=  ZERO;
	     PC_o               <=  ZERO;
	   end
	   else begin
         RI_COM_sel_o       <= RI_COM_sel_wire;
         B_COM_sel_o        <= B_COM_sel_wire;   
         SF_sel_o           <= SF_sel_wire;    
         ADD_B_sel_o        <= ADD_B_sel_wire;       
         ADD_OP_sel_o       <= ADD_OP_sel_wire;    
         ALU_Result_sel_o   <= ALU_Result_sel_wire;   
         REG_WEN_o          <= REG_WEN_wire;
         DM_enable_n_o      <= DM_enable_n_wire;      
         DM_WEN_o           <= DM_WEN_wire;  
         Branch_en_o        <= Branch_en_wire;       
         Branch_sel_o       <= Branch_sel_wire;    
         Jump_en_o          <= Jump_en_wire;   
         MUX_ALU_A_sel_o    <= MUX_ALU_A_sel_wire;
         MUX_ALU_B_sel_o    <= MUX_ALU_B_sel_wire;
         WB_MUX_sel_o       <= WB_MUX_sel_wire;
         EXE_MUX_sel_o      <= EXE_MUX_sel_wire;   
         rs1_addr_o         <= rs1_addr_wire;  
         rs2_addr_o         <= rs2_addr_wire;      
         rd_addr_o          <= rd_addr_wire;     
         IMM_V_o            <= IMM_V_wire;      
	     PC_o               <= PC_wire;        
       end
     end

endmodule 