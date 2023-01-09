
//====================================================
// module      :  ahb slave wrapper
// editor      :  shiyong 
// data        :  2022/11/12
// description :
//---------------------------------------------------
//       Global singal 
//   HCLK        rising edge 
//   HRESETn     reset the bus and system , ative LOW
//---------------------------------------------------
//        input  singal
//   HSEL_Sx       :
//   HADDR[31:0]   :
//   HWRITE        :
//   HTRANS[1:0]   :
//   HSIZE[2:0]    :
//   HWDATA[31:0]  :
//--------------------------------------------------
//        output singal 
//   HREADY           Transfer reponse       
//   HRESP[1:0]       Transfer reponse
//   HRDATA[31:0]    
//--------------------------------------------------
//        split-capable slave (not implemetion)  
//====================================================
`timescale 1ns/10ps

module ahb_slave_wrap(    
    //AHB signal
    input          H_clk,
    input          H_resetn,
    //---------------------
    //AHB signal
    input          H_sel,
    input          H_write,
    input    [1:0] H_trans,
    //input    [2:0] H_size,
    input   [31:0] H_addr,
    input   [31:0] H_wdata,
    //MEM data input
    //---------------------
    //AHB signal
    output reg        H_ready,
    output reg [ 1:0] H_resp ,
    output reg [31:0] H_rdata
);

//HTRANS parameter
parameter T_IDLE   = 2'b00;
parameter T_BUSY   = 2'b01;
parameter T_NONSEQ = 2'b10;
parameter T_SEQ    = 2'b11;
//HRESP parameter
parameter OKAY   = 2'b00 ;
parameter ERROR  = 2'b01 ;
parameter RETRY  = 2'b10 ;
parameter SPLLIT = 2'b11 ;
//state machine
parameter S_IDLE = 2'b00;
parameter S_DATA = 2'b01;
parameter S_RESP = 2'b10;

//AHB valid , then sample address and control signal
wire      h_valid;

wire [31:0] addr_tmp_n;
wire        write_tmp_n;

reg  [31:0] addr_tmp;
reg         write_tmp;

//
wire [31:0] regfile_rdata;

assign h_valid = H_sel & (( H_trans == T_NONSEQ) | (H_trans == T_SEQ));
//sample
assign addr_tmp_n  = h_valid ? H_addr  : 32'b0;
assign write_tmp_n = h_valid ? H_write : 1'b0;

always@(posedge H_clk or negedge H_resetn)begin
    if(!H_resetn)begin
        addr_tmp   <= 32'b0;
        write_tmp  <= 1'b0;
    end
    else begin
        addr_tmp   <= addr_tmp_n ;
        write_tmp  <= write_tmp_n;
    end
end

//state 
reg [1:0] state;
reg [1:0] state_n;

always@(*)begin
    case(state)
        S_IDLE:begin
            if(h_valid) state_n = S_DATA ;
            else        state_n = S_IDLE ;
        end
        S_DATA:begin
            state_n = S_RESP ;
        end
        S_RESP:begin
            state_n = S_IDLE ;
        end
        default:begin
            state_n = S_IDLE ;
        end
    endcase
end

always@(posedge H_clk or negedge H_resetn)begin
    if(~ H_resetn) state <= 2'b0   ;
    else           state <= state_n;
end

//1024 x 32 
//1 words : 32bit
regfile U_regfile(
    .clk      (H_clk   ),
    .reset_n  (H_resetn),
    .addr     (addr_tmp[9:0]),
    .wdata    (H_wdata),
    .read     (!write_tmp),
    .write    (write_tmp),
    .rdata    (regfile_rdata)
);

always@(*)begin
    H_ready = 1'b1;
    H_resp  = OKAY;
    //
    case(state)
    S_DATA:begin
        H_rdata  = regfile_rdata;
    end
    default:begin
        H_rdata  = 32'd0;
    end
    endcase
end

endmodule