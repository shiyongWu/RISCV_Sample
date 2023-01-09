`timescale  1ns/1ps

module Regfile #(
   parameter  XLEN = 32
)(
   input              clk       ,
   input              resetz    ,
   input       [4:0]  rs1_addr  ,
   input       [4:0]  rs2_addr  ,
   input       [4:0]  rd_addr   ,
   input  [XLEN-1:0]  rd_wdata  ,
   output [XLEN-1:0]  rs1_data_o,
   output [XLEN-1:0]  rs2_data_o
);

wire [XLEN-1:0] r1_n ,r2_n ,r3_n ,r4_n ,r5_n;
wire [XLEN-1:0] r6_n ,r7_n ,r8_n ,r9_n ,r10_n;
wire [XLEN-1:0] r11_n,r12_n,r13_n,r14_n,r15_n;
wire [XLEN-1:0] r16_n,r17_n,r18_n,r19_n,r20_n;
wire [XLEN-1:0] r21_n,r22_n,r23_n,r24_n,r25_n;
wire [XLEN-1:0] r26_n,r27_n,r28_n,r29_n,r30_n;
wire [XLEN-1:0] r31_n;

//reg
reg [XLEN-1:0] r1 ,r2 ,r3 ,r4 ,r5 ;
reg [XLEN-1:0] r6 ,r7 ,r8 ,r9 ,r10;
reg [XLEN-1:0] r11,r12,r13,r14,r15;
reg [XLEN-1:0] r16,r17,r18,r19,r20;
reg [XLEN-1:0] r21,r22,r23,r24,r25;
reg [XLEN-1:0] r26,r27,r28,r29,r30;
reg [XLEN-1:0] r31;

//reg , rdata
reg [XLEN-1:0] rs1_rdata;
reg [XLEN-1:0] rs2_rdata;

always@(posedge clk or negedge resetz)begin
   if(~resetz)begin
      r1   <= 'd0;  r16 <= 'd0;  r31 <= 'd0; 
      r2   <= 'd0;  r17 <= 'd0;
      r3   <= 'd0;  r18 <= 'd0;
      r4   <= 'd0;  r19 <= 'd0;
      r5   <= 'd0;  r20 <= 'd0;
      r6   <= 'd0;  r21 <= 'd0;
      r7   <= 'd0;  r22 <= 'd0;
      r8   <= 'd0;  r23 <= 'd0;
      r9   <= 'd0;  r24 <= 'd0;
      r10  <= 'd0;  r25 <= 'd0;
      r11  <= 'd0;  r26 <= 'd0;
      r12  <= 'd0;  r27 <= 'd0;
      r13  <= 'd0;  r28 <= 'd0;
      r14  <= 'd0;  r29 <= 'd0;
      r15  <= 'd0;  r30 <= 'd0;
   end
   else begin
      r1   <= r1_n;   r16 <= r16_n;  r31 <= r31_n; 
      r2   <= r2_n;   r17 <= r17_n;
      r3   <= r3_n;   r18 <= r18_n;
      r4   <= r4_n;   r19 <= r19_n;
      r5   <= r5_n;   r20 <= r20_n;
      r6   <= r6_n;   r21 <= r21_n;
      r7   <= r7_n;   r22 <= r22_n;
      r8   <= r8_n;   r23 <= r23_n;
      r9   <= r9_n;   r24 <= r24_n;
      r10  <= r10_n;  r25 <= r25_n;
      r11  <= r11_n;  r26 <= r26_n;
      r12  <= r12_n;  r27 <= r27_n;
      r13  <= r13_n;  r28 <= r28_n;
      r14  <= r14_n;  r29 <= r29_n;
      r15  <= r15_n;  r30 <= r30_n;
   end
end

assign r1_n  = (rd_addr == 5'd1 ) ? rd_wdata : r1 ;
assign r2_n  = (rd_addr == 5'd2 ) ? rd_wdata : r2 ;
assign r3_n  = (rd_addr == 5'd3 ) ? rd_wdata : r3 ;
assign r4_n  = (rd_addr == 5'd4 ) ? rd_wdata : r4 ;
assign r5_n  = (rd_addr == 5'd5 ) ? rd_wdata : r5 ;
assign r6_n  = (rd_addr == 5'd6 ) ? rd_wdata : r6 ;
assign r7_n  = (rd_addr == 5'd7 ) ? rd_wdata : r7 ;
assign r8_n  = (rd_addr == 5'd8 ) ? rd_wdata : r8 ;
assign r9_n  = (rd_addr == 5'd9 ) ? rd_wdata : r9 ;
assign r10_n = (rd_addr == 5'd10) ? rd_wdata : r10;
//
assign r11_n = (rd_addr == 5'd11) ? rd_wdata : r11;
assign r12_n = (rd_addr == 5'd12) ? rd_wdata : r12;
assign r13_n = (rd_addr == 5'd13) ? rd_wdata : r13;
assign r14_n = (rd_addr == 5'd14) ? rd_wdata : r14;
assign r15_n = (rd_addr == 5'd15) ? rd_wdata : r15;
assign r16_n = (rd_addr == 5'd16) ? rd_wdata : r16;
assign r17_n = (rd_addr == 5'd17) ? rd_wdata : r17;
assign r18_n = (rd_addr == 5'd18) ? rd_wdata : r18;
assign r19_n = (rd_addr == 5'd19) ? rd_wdata : r19;
assign r20_n = (rd_addr == 5'd20) ? rd_wdata : r20;
//
assign r21_n = (rd_addr == 5'd21) ? rd_wdata : r21;
assign r22_n = (rd_addr == 5'd22) ? rd_wdata : r22;
assign r23_n = (rd_addr == 5'd23) ? rd_wdata : r23;
assign r24_n = (rd_addr == 5'd24) ? rd_wdata : r24;
assign r25_n = (rd_addr == 5'd25) ? rd_wdata : r25;
assign r26_n = (rd_addr == 5'd26) ? rd_wdata : r26;
assign r27_n = (rd_addr == 5'd27) ? rd_wdata : r27;
assign r28_n = (rd_addr == 5'd28) ? rd_wdata : r28;
assign r29_n = (rd_addr == 5'd29) ? rd_wdata : r29;
assign r30_n = (rd_addr == 5'd30) ? rd_wdata : r30;
assign r31_n = (rd_addr == 5'd31) ? rd_wdata : r30;


//read data , rs1
always@(*)begin
   case(rs1_addr[4:0])
   5'd0 : rs1_rdata ='d0 ;
   5'd1 : rs1_rdata = r1 ;
   5'd2 : rs1_rdata = r2 ;
   5'd3 : rs1_rdata = r3 ;
   5'd4 : rs1_rdata = r4 ;   
   5'd5 : rs1_rdata = r5 ;
   5'd6 : rs1_rdata = r6 ;
   5'd7 : rs1_rdata = r7 ;
   5'd8 : rs1_rdata = r8 ;
   5'd9 : rs1_rdata = r9 ;
   5'd10: rs1_rdata = r10;
   5'd11: rs1_rdata = r11;
   5'd12: rs1_rdata = r12;
   5'd13: rs1_rdata = r13;
   5'd14: rs1_rdata = r14;
   5'd15: rs1_rdata = r15;
   5'd16: rs1_rdata = r16;
   5'd17: rs1_rdata = r17;
   5'd18: rs1_rdata = r18;
   5'd19: rs1_rdata = r19;
   5'd20: rs1_rdata = r20;
   5'd21: rs1_rdata = r21;
   5'd22: rs1_rdata = r22;
   5'd23: rs1_rdata = r23;
   5'd24: rs1_rdata = r24;
   5'd25: rs1_rdata = r25;
   5'd26: rs1_rdata = r26;
   5'd27: rs1_rdata = r27;
   5'd28: rs1_rdata = r28;
   5'd29: rs1_rdata = r29;
   5'd30: rs1_rdata = r30;
   5'd31: rs1_rdata = r31;
   default:begin
      rs1_rdata = 'd0;
   end
   endcase
end

//read data , rs2 
always@(*)begin
   case(rs2_addr[4:0])
   5'd0 : rs2_rdata ='d0 ;
   5'd1 : rs2_rdata = r1 ;
   5'd2 : rs2_rdata = r2 ;
   5'd3 : rs2_rdata = r3 ;
   5'd4 : rs2_rdata = r4 ;   
   5'd5 : rs2_rdata = r5 ;
   5'd6 : rs2_rdata = r6 ;
   5'd7 : rs2_rdata = r7 ;
   5'd8 : rs2_rdata = r8 ;
   5'd9 : rs2_rdata = r9 ;
   5'd10: rs2_rdata = r10;
   5'd11: rs2_rdata = r11;
   5'd12: rs2_rdata = r12;
   5'd13: rs2_rdata = r13;
   5'd14: rs2_rdata = r14;
   5'd15: rs2_rdata = r15;
   5'd16: rs2_rdata = r16;
   5'd17: rs2_rdata = r17;
   5'd18: rs2_rdata = r18;
   5'd19: rs2_rdata = r19;
   5'd20: rs2_rdata = r20;
   5'd21: rs2_rdata = r21;
   5'd22: rs2_rdata = r22;
   5'd23: rs2_rdata = r23;
   5'd24: rs2_rdata = r24;
   5'd25: rs2_rdata = r25;
   5'd26: rs2_rdata = r26;
   5'd27: rs2_rdata = r27;
   5'd28: rs2_rdata = r28;
   5'd29: rs2_rdata = r29;
   5'd30: rs2_rdata = r30;
   5'd31: rs2_rdata = r31;
   default:begin
      rs2_rdata = 'd0;
   end
   endcase   
end
    
//rdata output 
assign rs1_data_o = rs1_rdata;
assign rs2_data_o = rs2_rdata;    


endmodule