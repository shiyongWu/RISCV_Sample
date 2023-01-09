//====================================================
// module      :  ahb  MUX
// editor      :  shiyong 
// data        :  2022/11/12
// description :
//                Master to slave
//====================================================
`timescale 1ns/10ps

module ahb_mux_M2S(
       //address and control sel  signal
       input   H_grant_m1,
       input   H_grant_m2,
       //data grant sel signals
       input   H_grant_data_m1,
       input   H_grant_data_m2,
       //master 1
       input  [31:0]  H_addr_m1,
       input          H_write_m1,
       input  [ 1:0]  H_trans_m1,
       input  [31:0]  H_wdata_m1,
       //master 2
       input  [31:0]  H_addr_m2,
       input          H_write_m2,
       input  [ 1:0]  H_trans_m2,
       input  [31:0]  H_wdata_m2,
       //output
       output  reg [31:0]  H_addr_o,
       output  reg         H_write_o,
       output  reg [ 1:0]  H_trans_o,
       output  reg [31:0]  H_wdata_o
);

always@(*)begin
    //address and control phase
    case({H_grant_m1,H_grant_m2})
        2'b01:begin
           H_addr_o  = H_addr_m2;            
           H_write_o = H_write_m2;
           H_trans_o = H_trans_m2;
        end
        2'b10:begin
           H_addr_o  = H_addr_m1;
           H_write_o = H_write_m1;
           H_trans_o = H_trans_m1;
        end
        default:begin
           H_addr_o  = 32'hffff_ffff;
           H_write_o = 1'b0;
           H_trans_o = 1'b0;
        end
    endcase
    case ({H_grant_data_m1,H_grant_data_m2})
        2'b01:begin
            H_wdata_o = H_wdata_m2;
        end 
        2'b10:begin
            H_wdata_o = H_wdata_m1;
        end
        default: begin
            H_wdata_o = 32'h0000_0000;
        end
    endcase
end


endmodule