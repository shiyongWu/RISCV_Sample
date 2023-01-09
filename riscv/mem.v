//==================================
//Date  : 2022/09/20 
//Editor: shiyong
//Note  : mem 
//        
//
//==================================

module mem#(
    parameter XLEN     =  32 ,
    parameter ADDR_LEN =  10 ,
    parameter Words    =  1 << ADDR_LEN
)
(
    input  [ADDR_LEN-1:0]   addr,
    input  [XLEN-1:0]       wdata,
    input                   cs_n ,
    input                   we_n ,
    input                   clk  ,
    output reg [XLEN-1:0]   rdata
);

    reg [XLEN-1:0] mem_array [Words-1:0];

    always@(posedge clk)
        if( ! (cs_n & we_n)) mem_array[addr] <= #1 wdata;

    always@(negedge clk)
        if(!cs_n) rdata <= #1 mem_array[addr];

endmodule