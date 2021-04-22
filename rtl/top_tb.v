`timescale 1ns/1ps
`define CYCLE 10
`include "RISCV.v"
`include "FORWARD.v"
`include "ALU.v"
`include "DE.v"
`include "FA.v"
`include "FRIST_PIPE.v"
`include "SECOND_PIPE.v"
`include "IMM.v"
`include "PC.v"
`include "REGFILE.v"
`include "IM.v"
`include "DM.v"
module top_tb;

  reg clk;
  reg rst;
  wire [31:0] IM_address;
  wire DM_write;
  wire DM_enable;
  wire [31:0] DM_in;
  wire [31:0] DM_address;
  wire [31:0] IM_out;
  wire [31:0] DM_out;
  reg [31:0] GOLDEN[0:4095];
  integer gf,i,tmp;
  integer err;
  always #(`CYCLE/2) clk = ~clk;

  RISCV u_RISCV(
	.IM_addr_o(IM_address),
	.DM_WEN_o(DM_write),
	.DM_EN_o(DM_enable),
	.DM_addr_o(DM_address),
	.DM_data_o(DM_in),
    .IM_data_i(IM_out),
    .DM_data_i(DM_out),
    .clk(clk),
    .rst_n(~rst)
  );

  IM IM1(
    .clk(clk),
    .rst_n(~rst),
    .IM_write(1'b1),
    .IM_enable(1'b0),
    .IM_in(32'h0000_0000),
    .IM_address(IM_address[17:2]),
    .IM_out(IM_out)
  );


  DM DM1(
    .clk(clk),
    .rst_n(~rst),
    .DM_write(DM_write),
    .DM_enable(DM_enable),
    .DM_in(DM_in),
    .DM_address(DM_address[17:2]),
    .DM_out(DM_out)
  );


  initial
  begin
    clk = 0; rst = 1;
    #(`CYCLE) rst = 0;
  	//verification default program
  	$readmemh("IM_data.dat",IM1.mem_data);
  	$readmemh("DM_data.dat",DM1.mem_data); 
	gf=$fopen("golden.dat","r");
	i=0;
	while(!$feof(gf)) begin
	  tmp =$fscanf(gf,"%d\n",GOLDEN[i]);
	  i=i+1;
	end
	$fclose(gf); 
    #(`CYCLE*10000)
    $display( "\nDone\n" );
    for (i=0;i<10;i=i+1 ) 
    begin
      $display( "DM[%2d] = %h",i,DM1.mem_data[i]); 
    end
    err=0;
    for (i=1;i<32;i=i+1 ) begin
        if (u_RISCV.u_REGFILE.MEM[i]!=GOLDEN[i]) begin
          $display("register[%2d]=%d, expect=%d",i,u_RISCV.u_REGFILE.MEM[i],GOLDEN[i]); 
          err=err+1;
        end
        else begin
          $display("register[%2d]=%d, pass",i,u_RISCV.u_REGFILE.MEM[i]);
        end
    end
    result(err);
    $finish;
  end

  initial
  begin
    $dumpfile("top.vcd");
    $dumpvars(0, top_tb);
    #1000000 $finish;
  end
  
  task result;
    input integer err;
    begin
      if(err==0) begin
        $display("\n");
        $display("\n");
        $display("        ****************************               ");
        $display("        **                        **       |\__||  ");
        $display("        **  Congratulations !!    **      / O.O  | ");
        $display("        **                        **    /_____   | ");
        $display("        **  Simulation PASS!!     **   /^ ^ ^ \\  |");
        $display("        **                        **  |^ ^ ^ ^ |w| ");
        $display("        *************** ************   \\m___m__|_|");
        $display("\n");
      end
      else begin
        $display("\n");
        $display("\n");
        $display("        ****************************               ");
        $display("        **                        **       |\__||  ");
        $display("        **  OOPS!!                **      / X,X  | ");
        $display("        **                        **    /_____   | ");
        $display("        **  Simulation Failed!!   **   /^ ^ ^ \\  |");
        $display("        **                        **  |^ ^ ^ ^ |w| ");
        $display("        *************** ************   \\m___m__|_|");
        $display("         Totally has %d errors                     ",err); 
        $display("\n");
      end
    end
  endtask
endmodule
