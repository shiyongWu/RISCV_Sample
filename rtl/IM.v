module IM(
  input clk,
  input rst_n,
  input IM_write,
  input IM_enable,
  input [31:0] IM_in,
  input [15:0] IM_address,
  output [31:0] IM_out
);
  parameter MEsize= 65536;
   
  reg [31:0] mem_data [0:65535];


  integer i;
  
  assign #1 IM_out = (IM_enable == 1'b0) ? mem_data[IM_address] : 32'd0;
  
  always@(posedge clk)begin
	  if(~rst_n)begin
	     #1
		  for(i=0;i<MEsize;i=i+1)begin
			  mem_data[i]<=32'd0;
		  end
	  end
	  else begin
	     #1
         if( (IM_write ==1'd0) && (IM_enable == 1'b0)) mem_data[IM_address] <= IM_in;
	  end
  end

endmodule
