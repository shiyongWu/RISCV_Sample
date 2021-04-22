//---------------------------------------------------------
//Date: 2021/3/14
//Editer:Shi-Yong Wu
//*********************************************************
//      IF,ID output register ( the frist pipeline stage)
//---------------------------------------------------------
`timescale 1ns/1ps
module SECOND_PIPE
#(
   parameter XLEN = 32,
   parameter ZERO = 32'd0
)
(
   output reg [XLEN-1:0]src2_DATA_o,
   output reg [XLEN-1:0]EXE_DATA_o,
   output reg           REG_WEN_o,
   output reg           DM_enable_n_o,
   output reg           DM_WEN_o,
   output reg           WB_MUX_sel_o,
   output reg      [4:0]rd_addr_o,
   input  [XLEN-1:0] src2_data_i,
   input  [XLEN-1:0] EXE_DATA_i,
   input             REG_WEN_i,
   input             DM_enable_n_i,
   input             DM_WEN_i,
   input             WB_MUX_sel_i,
   input       [4:0] rd_addr_i,
   input             branch_i,
   input             clk,
   input             rst_n
);



   wire [XLEN-1:0] src2_DATA_wire;
   wire [XLEN-1:0] EXE_DATA_wire;
   wire            REG_WEN_wire;
   wire            DM_WEN_wire;
   wire            DM_enable_n_wire;
   wire            WB_MUX_sel_wire;
   wire      [4:0] rd_addr_wire;

   assign src2_DATA_wire    = (branch_i == 1'd1) ? ZERO : src2_data_i;
   assign EXE_DATA_wire     = (branch_i == 1'd1) ? ZERO : EXE_DATA_i;
   assign REG_WEN_wire      = (branch_i == 1'd1) ? 1'd1 : REG_WEN_i;
   assign DM_WEN_wire       = (branch_i == 1'd1) ? 1'd1 : DM_WEN_i;
   assign DM_enable_n_wire  = (branch_i == 1'd1) ? 1'd1 : DM_enable_n_i;
   assign WB_MUX_sel_wire   = (branch_i == 1'd1) ? 1'd0 : WB_MUX_sel_i;
   assign rd_addr_wire      = (branch_i == 1'd1) ? 5'd0 : rd_addr_i;


   
   always@(posedge clk)begin
     if(~rst_n)begin
	     src2_DATA_o   <= ZERO;
	     EXE_DATA_o    <= ZERO;
	     REG_WEN_o     <= 1'd1;
		 DM_enable_n_o <= 1'd1;
		 DM_WEN_o      <= 1'd1;
		 WB_MUX_sel_o  <= 1'd0;
		 rd_addr_o     <= 5'd0;
	 end
	 else begin
	     src2_DATA_o   <= src2_DATA_wire;     
	     EXE_DATA_o    <= EXE_DATA_wire;     
	     REG_WEN_o     <= REG_WEN_wire; 
         DM_WEN_o      <= DM_WEN_wire; 		 
		 DM_enable_n_o <= DM_enable_n_wire;       
		 WB_MUX_sel_o  <= WB_MUX_sel_wire; 
		 rd_addr_o     <= rd_addr_wire;	 
	 end
   end
   



endmodule 
