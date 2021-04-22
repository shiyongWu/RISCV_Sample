//---------------------------------------------
//Date: 2021/3/15
//Editer:Shi-Yong Wu
//**********************************************
//       Program counter
//----------------------------------------------
`timescale 1ns/1ps
module PC
#(
  parameter XLEN = 32,
  parameter ZERO = 32'd0
)(

  output reg [XLEN-1:0] PC_o,
  input                 clk,
  input                 rst_n,
  input                 PC_sel_i,
  input      [XLEN-1:0] PC_branch_i
);


  wire [XLEN-1:0] PC_wire;
  
  assign PC_wire = (PC_sel_i == 1'b1) ?  PC_branch_i : (PC_o + 32'd4);
  
  always@(posedge clk)begin
    if(~rst_n)begin
	  PC_o  <= ZERO;
	end
	else begin
	  PC_o  <= PC_wire;
	end
  end

endmodule
