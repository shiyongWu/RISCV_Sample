`timescale 1ps/1ps

module ahb_top_tb;

parameter CLOCK_RATE = 10 ;

reg  HCLK;
reg  HRESET_n;
//
wire        req_m1  ;
wire        lock_m1 ;
wire        write_m1;
wire [31:0] addr_m1 ;
wire [31:0] wdata_m1;
wire [ 2:0] burst_m1;
//
wire        req_m2  ;
wire        lock_m2 ;
wire        write_m2;
wire [31:0] addr_m2 ;
wire [31:0] wdata_m2;
wire [ 2:0] burst_m2;

master_ahb_task master_1(
            .clk         (HCLK     ),
            .req_o       (req_m1   ),
            .lock_o      (lock_m1  ),
            .write_o     (write_m1 ),
            .addr_o      (addr_m1  ),
            .wdata_o     (wdata_m1 ),
            .burst_o     (burst_m1 )
);

master_ahb_task master_2(
            .clk         (HCLK     ),
            .req_o       (req_m2   ),
            .lock_o      (lock_m2  ),
            .write_o     (write_m2 ),
            .addr_o      (addr_m2  ),
            .wdata_o     (wdata_m2 ),
            .burst_o     (burst_m2 )
);

always #(CLOCK_RATE/2) HCLK = ~ HCLK;

ahb_top U_AHB_TOP(
    .H_clk        (HCLK      ),
    .H_resetn     (HRESET_n  ),
    //
    .req_m1       (req_m1    ),
    .lock_m1      (lock_m1   ),
    .write_m1     (write_m1  ),
    .addr_m1      (addr_m1   ),
    .wdata_m1     (wdata_m1  ),
    .burst_m1     (burst_m1  ),
    //
    .req_m2       (req_m2    ),
    .lock_m2      (lock_m2   ),
    .write_m2     (write_m2  ),
    .addr_m2      (addr_m2   ),
    .wdata_m2     (wdata_m2  ),
    .burst_m2     (burst_m2  )
);

initial begin
    //
    HRESET_n =   1'b1;
    HCLK     =   1'b0;    
    #100
    HRESET_n =   1'b0;
    #200
    HRESET_n =   1'b1;

    master_1.SINGLE_WRITE(32'h1000_0000,32'h0000_FFF1);
    master_1.SINGLE_WRITE(32'h1000_0001,32'h0000_FFF2);

    master_1.SINGLE_READ(32'h1000_0000);
    master_1.SINGLE_READ(32'h1000_0001);
    repeat (20)@(posedge HCLK);
    $finish;
end

initial
 begin
    $dumpfile("./VCD/ahb_top_tb.vcd");
    $dumpvars(2,ahb_top_tb);
    $dumpvars(0,ahb_top_tb.U_AHB_TOP);
 end

endmodule