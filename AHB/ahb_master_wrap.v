//====================================================
// module      :  ahb master wrapper
// editor      :  shiyong 
// data        :  2022/11/12
// description :
//---------------------------------------------------
//       Global singal 
//   HCLK        rising edge 
//   HRESETn     reset the bus and system , ative LOW
//---------------------------------------------------
//      input  singal
//   HGRANT              Arbiter grant   
//   HREADY              Transfer response 
//   HRESP[1:0]          Transfer response 
//   HRDATA[31:0]        Data  from slave
// --------------------------------------------------
//      output  singal
//    HBUSREQ            Arbiter 
//    HLOCK              Arbiter
//    HWRITE      
//    HTRANS[1:0]       
//    HSIZE[2:0]                      
//    HBUSRST[2:0]         
//    HPROT[3:0]         
//    HADDR[31:0]        
//    HWDATA[31:0]      data
//====================================================
`timescale 1ns/10ps

module ahb_master_wrap(
    //from host
    input         req   ,
    input         lock  ,
    input         write ,  //1'b0 : read data , 1'b1 : write
    input [31:0]  addr  ,
    input [31:0]  wdata ,
    input  [2:0]  burst ,    
    //AHB bus signal
    input         H_clk,
    input         H_resetn,
    //AHB bus signal
    input         H_grant, //from arbiter
    input         H_ready, //from slaves
    input   [1:0] H_resp,  
    input  [31:0] H_rdata,
    //to AHB bus signal
    output  reg        H_busreq,
    output  reg        H_lock,
    output  reg        H_write,
    output  reg [1:0]  H_trans,
    //output reg  [2:0] H_size,
    output  reg [2:0]  H_burst,
    //output reg [3:0] H_prot,
    output  reg [31:0] H_addr,
    output  reg [31:0] H_wdata
);

//Master State Machine
parameter M_IDLE   = 3'd0; //Master idle state
parameter M_REQ    = 3'd1; //Send request to the arbiter
parameter M_ADDR   = 3'd2; //Address Phase
parameter M_DATA   = 3'd3; //Data Phase
parameter M_RESP   = 3'd4; //Wait Transfer response
parameter M_FINISH = 3'd5; //Finish the transfer
//HBURST 
parameter SINGLE = 3'b000;
parameter INCR   = 3'b001;
parameter WRAP4  = 3'b010;
parameter INCR4  = 3'b011;
parameter WRAP8  = 3'b100;
parameter INCR8  = 3'b101;
parameter WRAP16 = 3'b110;
parameter INCR16 = 3'b111;
//HTRANS[1:0]
parameter T_IDLE   = 2'b00;
parameter T_BUSY   = 2'b01;
parameter T_NONSEQ = 2'b10;
parameter T_SEQ    = 2'b11;

//master state machine
reg  [2:0] state;
reg  [2:0] state_n;

always@(*)begin
    case(state)
        M_IDLE:begin
            if(req) state_n = M_REQ;
            else    state_n = M_IDLE; 
        end
        M_REQ:begin            
            state_n = M_ADDR ; 
        end
        M_ADDR:begin
            if(H_grant && H_ready) state_n = M_ADDR;
            else                   state_n = M_DATA;
        end
        M_DATA:begin
            if(burst == SINGLE) state_n = M_RESP ;
            else                state_n = M_IDLE ;
        end
        M_RESP:begin
            state_n = M_FINISH;
        end
        M_FINISH:begin
            state_n = M_IDLE;
        end
        default:begin
            state_n = M_IDLE; 
        end
    endcase
end

always@(posedge H_clk or negedge H_resetn)begin
    if(~H_resetn) state <= 3'b0;
    else          state <= state_n;
end

//signal output
always@(*)begin
    H_busreq = (state == M_REQ ) ? 1'b1     : 1'b0          ;
    H_lock   = (state == M_REQ ) ? lock     : 1'b0          ;
    H_addr   = (state == M_ADDR) ? addr     : 32'hFFFF_FFFF ;
    H_write  = (state == M_ADDR) ? write    : 1'b0          ;
    H_burst  = (state == M_ADDR) ? burst    : SINGLE        ;
    H_trans  = (state == M_ADDR) ? T_NONSEQ : T_IDLE        ;
    H_wdata  = wdata;
end

endmodule