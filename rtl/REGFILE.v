//---------------------------------------------
//Date: 2021/3/14
//Editer:Shi-Yong Wu
//**********************************************
//      32 * 32 Regfile
//----------------------------------------------
`timescale 1ns/1ps
module REGFILE
#(
   parameter XLEN = 32,
   parameter ZERO = 32'd0
)(
   output [XLEN-1:0] src1_data_o,
   output [XLEN-1:0] src2_data_o,
   input       [4:0] src1_addr_i,
   input       [4:0] src2_addr_i,
   input       [4:0] rd_addr_i,
   input             WEN_i,
   input  [XLEN-1:0] data_i,
   input             clk,
   input             rst_n   
);
   integer i,j;

   reg   [XLEN-1:0] MEM[0:31];
   wire  [XLEN-1:0] MEM_wire[0:31];
       
   //read 
   assign src1_data_o = MEM[src1_addr_i];
   assign src2_data_o = MEM[src2_addr_i];
  
   
   //write 
   //1~9
   assign MEM_wire[1]  = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd1)) ? data_i:MEM[1];
   assign MEM_wire[2]  = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd2)) ? data_i:MEM[2];
   assign MEM_wire[3]  = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd3)) ? data_i:MEM[3];
   assign MEM_wire[4]  = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd4)) ? data_i:MEM[4];
   assign MEM_wire[5]  = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd5)) ? data_i:MEM[5];
   assign MEM_wire[6]  = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd6)) ? data_i:MEM[6];
   assign MEM_wire[7]  = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd7)) ? data_i:MEM[7];
   assign MEM_wire[8]  = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd8)) ? data_i:MEM[8];
   assign MEM_wire[9]  = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd9)) ? data_i:MEM[9];
   //10~19
   assign MEM_wire[10] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd10)) ? data_i:MEM[10];
   assign MEM_wire[11] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd11)) ? data_i:MEM[11];
   assign MEM_wire[12] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd12)) ? data_i:MEM[12];
   assign MEM_wire[13] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd13)) ? data_i:MEM[13];
   assign MEM_wire[14] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd14)) ? data_i:MEM[14];
   assign MEM_wire[15] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd15)) ? data_i:MEM[15];
   assign MEM_wire[16] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd16)) ? data_i:MEM[16];
   assign MEM_wire[17] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd17)) ? data_i:MEM[17];
   assign MEM_wire[18] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd18)) ? data_i:MEM[18];
   assign MEM_wire[19] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd19)) ? data_i:MEM[19];
   //20~29
   assign MEM_wire[20] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd20)) ? data_i:MEM[20];
   assign MEM_wire[21] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd21)) ? data_i:MEM[21];
   assign MEM_wire[22] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd22)) ? data_i:MEM[22];
   assign MEM_wire[23] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd23)) ? data_i:MEM[23];
   assign MEM_wire[24] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd24)) ? data_i:MEM[24];
   assign MEM_wire[25] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd25)) ? data_i:MEM[25];
   assign MEM_wire[26] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd26)) ? data_i:MEM[26];
   assign MEM_wire[27] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd27)) ? data_i:MEM[27];
   assign MEM_wire[28] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd28)) ? data_i:MEM[28];
   assign MEM_wire[29] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd29)) ? data_i:MEM[29];   
   //30~31
   assign MEM_wire[30] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd30)) ? data_i:MEM[30];
   assign MEM_wire[31] = ((WEN_i == 1'd0)&&(rd_addr_i == 5'd31)) ? data_i:MEM[31];
  
   //MEM Seq
   always@(posedge clk)begin
        if(~rst_n)begin
	      for(i=0;i<32;i=i+1)begin
		     MEM[i] <= ZERO;
		  end
	    end
	    else begin
	      for(j=1;j<32;j=j+1)begin
		     MEM[j] <= MEM_wire[j];
		  end
	    end
   end


endmodule 