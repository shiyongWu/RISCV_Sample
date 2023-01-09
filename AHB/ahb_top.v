//====================================================
// module      :  ahb arbiter 
// editor      :  shiyong 
// data        :  2022/11/12
// description :
//              advanced high performance bus
//----------------------------------------------------

module ahb_top (
    //AHB global signal
    input         H_clk   ,
    input         H_resetn,
    //
    input         req_m1  ,
    input         lock_m1 ,
    input         write_m1,
    input  [31:0] addr_m1 ,  
    input  [31:0] wdata_m1,
    input  [ 2:0] burst_m1,
    //
    input         req_m2  ,
    input         lock_m2 ,
    input         write_m2,
    input  [31:0] addr_m2 ,  
    input  [31:0] wdata_m2,
    input  [ 2:0] burst_m2
);

wire [31:0]  H_rdata   ;
//
wire         H_grant_m1;
wire [ 1:0]  H_resp_m1 ;


wire         H_busreq_m1;
wire         H_lock_m1  ;
wire         H_write_m1 ;
wire [ 1:0]  H_trans_m1 ;
wire [ 2:0]  H_burst_m1 ;
wire [31:0]  H_addr_m1  ;
wire [31:0]  H_wdata_m1 ;
//
wire         H_grant_m2;
wire [ 1:0]  H_resp_m2 ;

wire         H_busreq_m2;
wire         H_lock_m2  ;
wire         H_write_m2 ;
wire [ 1:0]  H_trans_m2 ;
wire [ 2:0]  H_burst_m2 ;
wire [31:0]  H_addr_m2  ;
wire [31:0]  H_wdata_m2 ;
//
wire         H_grant_data_m1;
wire         H_grant_data_m2;

//
wire [31:0]  H_addr_o  ;
wire         H_write_o ;
wire [ 1:0]  H_trans_o ;
wire [31:0]  H_wdata_o ;
//
wire         hsel_s1   ;
wire         hsel_s2   ;
//
wire         H_ready_s1;
wire [ 1:0]  H_resp_s1 ;
wire [31:0]  H_rdata_s1;
//
wire         H_ready_s2;
wire [ 1:0]  H_resp_s2 ;
wire [31:0]  H_rdata_s2;
//
wire         H_ready_o ;
wire [31:0]  H_rdata_o ;

ahb_master_wrap u_master_1(
    .req       (req_m1    ),
    .lock      (lock_m1   ),
    .write     (write_m1  ),
    .addr      (addr_m1   ),
    .wdata     (wdata_m1  ),
    .burst     (burst_m1  ),
    //input AHB bus global signal
    .H_clk     (H_clk     ),
    .H_resetn  (H_resetn  ),
    //input AHB bus siganl
    .H_grant   (H_grant_m1),
    .H_ready   (H_ready_o ),
    .H_resp    (H_resp_m1 ),
    .H_rdata   (H_rdata_o ),
    //output AHB bus signal
    .H_busreq  (H_busreq_m1),
    .H_lock    (H_lock_m1  ),
    .H_write   (H_write_m1 ),
    .H_trans   (H_trans_m1 ),
    .H_burst   (H_burst_m1 ),
    .H_addr    (H_addr_m1  ),
    .H_wdata   (H_wdata_m1 )
);

ahb_master_wrap u_master_2(
    .req       (req_m2    ),
    .lock      (lock_m2   ),
    .write     (write_m2  ),
    .addr      (addr_m2   ),
    .wdata     (wdata_m2  ),
    .burst     (burst_m2  ),
    //input AHB bus global signal
    .H_clk     (H_clk     ),
    .H_resetn  (H_resetn  ),
    //input AHB bus siganl
    .H_grant   (H_grant_m2),
    .H_ready   (H_ready_o ),
    .H_resp    (H_resp_m2 ),
    .H_rdata   (H_rdata_o ),
    //output AHB bus signal
    .H_busreq  (H_busreq_m2),
    .H_lock    (H_lock_m2  ),
    .H_write   (H_write_m2 ),
    .H_trans   (H_trans_m2 ),
    .H_burst   (H_burst_m2 ),
    .H_addr    (H_addr_m2  ),
    .H_wdata   (H_wdata_m2 )
);

ahb_arbiter U_AHB_ARBITER(
    .H_clk        (H_clk    ),
    .H_resetn     (H_resetn ),
    //
    .H_busreq_m1  (H_busreq_m1),
    .H_busreq_m2  (H_busreq_m2),
    //
    .H_grant_m1       (H_grant_m1     ),
    .H_grant_m2       (H_grant_m2     ),
    .H_grant_data_m1  (H_grant_data_m1),
    .H_grant_data_m2  (H_grant_data_m2)
);

ahb_mux_M2S U_AHB_MUX_M2S(
    .H_grant_m1      (H_grant_m1     ),
    .H_grant_m2      (H_grant_m2     ),
    //
    .H_grant_data_m1 (H_grant_data_m1),
    .H_grant_data_m2 (H_grant_data_m2),
    //
    .H_addr_m1       (H_addr_m1      ),
    .H_write_m1      (H_write_m1     ),
    .H_trans_m1      (H_trans_m1     ),
    .H_wdata_m1      (H_wdata_m1     ),
    //
    .H_addr_m2       (H_addr_m2      ),
    .H_write_m2      (H_write_m2     ),
    .H_trans_m2      (H_trans_m2     ),
    .H_wdata_m2      (H_wdata_m2     ),
    //
    .H_addr_o        (H_addr_o       ),
    .H_write_o       (H_write_o      ),
    .H_trans_o       (H_trans_o      ),
    .H_wdata_o       (H_wdata_o      )
);

ahb_decoder U_AHB_DECODER( 
    .H_addr          (H_addr_o),
    .hsel_s1         (hsel_s1 ),
    .hsel_s2         (hsel_s2 )
);

ahb_slave_wrap U_SLAVE_1(
    .H_clk           (H_clk     ),
    .H_resetn        (H_resetn  ),
    //
    .H_sel           (hsel_s1   ),
    .H_write         (H_write_o ),
    .H_trans         (H_trans_o ),
    .H_addr          (H_addr_o  ),
    .H_wdata         (H_wdata_o ),
    //
    .H_ready         (H_ready_s1),
    .H_resp          (H_resp_s1 ),
    .H_rdata         (H_rdata_s1)
);

ahb_slave_wrap U_SLAVE_2(
    .H_clk           (H_clk     ),
    .H_resetn        (H_resetn  ),
    //
    .H_sel           (hsel_s2   ),
    .H_write         (H_write_o ),
    .H_trans         (H_trans_o ),
    .H_addr          (H_addr_o  ),
    .H_wdata         (H_wdata_o ),
    //
    .H_ready         (H_ready_s2),
    .H_resp          (H_resp_s2 ),
    .H_rdata         (H_rdata_s2)
);

ahb_mux_S2M U_ahb_mux_S2M(
    //slave 1
    .H_ready_s1      (H_ready_s1),
    .H_rdata_s1      (H_rdata_s1),
    //slave 2
    .H_ready_s2      (H_ready_s2),
    .H_rdata_s2      (H_rdata_s2),
    //output
    .H_ready_o       (H_ready_o ),
    .H_rdata_o       (H_rdata_o )
);

endmodule