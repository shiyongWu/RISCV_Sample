module DM(
  input clk,
  input rst_n,
  input DM_write,
  input DM_enable,
  input [31:0] DM_in,
  input [15:0] DM_address,
  output [31:0] DM_out
);

  parameter MEsize = 65536;
  reg [31:0] mem_data [0:65535];


  assign #1 DM_out = (DM_enable == 1'b0) ? mem_data[DM_address] : 32'd0;

  integer i;
  always@(posedge clk)begin
	  if(~rst_n)begin
	    #1
		  for(i=0;i<65536;i=i+1)begin
		        mem_data[i]<=32'd0;
		 end
	  end
	  else begin
	    #1
        if( (DM_write ==1'd0) && (DM_enable == 1'b0)) mem_data[DM_address] <= DM_in;
	  end
  end
endmodule
