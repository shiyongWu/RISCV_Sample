//====================================================
// module      :  ahb arbiter 
// editor      :  shiyong 
// data        :  2022/11/12
// description :
//----------------------------------------------------
//       Global singal 
//   HCLK        rising edge 
//   HRESETn     reset the bus and system , ative LOW
//----------------------------------------------------
//       | arbiter requests and locks |  
//    HBUSERQ_Mx     
//    HLCOK_Mx
//----------------------------------------------------
//            Address and control
//    HBURST[2:0]
//    HRESP[1:0]
//    HREADY
//----------------------------------------------------
//            Output 
//    HGRANT_Mx   : arbiter grants
//    HMASTLOCK   
//====================================================

module ahb_arbiter(
        input            H_clk,
        input            H_resetn,
        //-----------------------------
        //  Arbiter requests and locks
        input            H_busreq_m1,
        //input            H_lock_m1  ,
        input            H_busreq_m2,
        //input            H_lock_m2  ,
        //-----------------------------
        //  output Arbiter grants
        output   reg         H_grant_m1      ,
        output   reg         H_grant_m2      ,
        output   reg         H_grant_data_m1 ,
        output   reg         H_grant_data_m2 
        //output   reg [3:0]   H_master        ,
        //output               H_mastlock 
);

parameter A_IDLE        = 'd0;
parameter A_GRANT       = 'd1; // send HGRANT to master 
parameter A_GRANT_WDATA = 'd2; // send HGRANT 
parameter A_FINISH      = 'd3; // Finish 
//
reg       H_busreq_m1_buf;
reg       H_busreq_m2_buf;
//
reg [1:0] priority_record_n;
reg [1:0] priority_record;

//state
reg [1:0] state;
reg [1:0] state_n;

//priority record
always@(posedge H_clk or negedge H_resetn)begin
        if(!H_resetn)begin
           priority_record <= 2'b10;
        end
        else begin
           priority_record <= priority_record_n;
        end
end

always@(*)begin
        case(state)
        A_IDLE:begin
                if(H_busreq_m1 | H_busreq_m2) state_n = A_GRANT;
                else                           state_n = A_IDLE;
        end
        A_GRANT:begin
                state_n = A_GRANT_WDATA;
        end
        A_GRANT_WDATA:begin
                state_n = A_FINISH;
        end
        A_FINISH:begin
                state_n = A_IDLE;
        end
        endcase
end

always@(posedge H_clk or negedge H_resetn)begin
        if(!H_resetn)begin
                state <= 2'b0;
        end
        else begin
                state <= state_n;
        end
end



//output
always@(*)begin
        if(state == A_GRANT)begin
                H_grant_m1        = 1'b0;
                H_grant_m2        = 1'b0;
                priority_record_n = priority_record;
                case ({H_busreq_m1_buf,H_busreq_m2_buf})
                      2'b01:begin
                        H_grant_m2   = 1'b1;
                      end
                      2'b10:begin
                        H_grant_m1   = 1'b1;
                      end  
                      2'b11:begin
                        if(priority_record[0])H_grant_m2 = 1'b1;
                        else                  H_grant_m1 = 1'b1;
                        priority_record_n = ({priority_record[0],priority_record[1]});
                      end
                      default:begin                        
                      end
                endcase
        end
        else begin
                H_grant_m1        = 1'b0;
                H_grant_m2        = 1'b0;
                priority_record_n = priority_record;                
        end
end

always@(posedge H_clk or negedge H_resetn)begin
        if(!H_resetn)begin
                H_busreq_m1_buf <= 1'b0;
                H_busreq_m2_buf <= 1'b0;
                H_grant_data_m1 <= 1'b0;
                H_grant_data_m2 <= 1'b0;
        end
        else begin
                H_busreq_m1_buf <= H_busreq_m1;
                H_busreq_m2_buf <= H_busreq_m2;                
                H_grant_data_m1 <= H_grant_m1 ;
                H_grant_data_m2 <= H_grant_m2 ;
        end
end

endmodule