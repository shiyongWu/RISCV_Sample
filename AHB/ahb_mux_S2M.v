//====================================================
// module      :  ahb address and control decoder
// editor      :  shiyong 
// data        :  2022/11/12
// description :
//                Slave to Master
//---------------------------------------------------
//        input signal
//   
//===================================================

`timescale 1ns/10ps

module ahb_mux_S2M(
       //
       input         H_ready_s1,
       input  [31:0] H_rdata_s1,
       //
       input         H_ready_s2,
       input  [31:0] H_rdata_s2,
       //
       output        H_ready_o,
       output [31:0] H_rdata_o
);

assign H_ready_o = H_ready_s1 & H_ready_s2;

assign H_rdata_o = H_rdata_s1 | H_rdata_s2;


endmodule