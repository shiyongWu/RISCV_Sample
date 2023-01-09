//====================================================
// module      :  ahb address decoder
// editor      :  shiyong 
// data        :  2022/11/12
// description :
//                address decorder , Hsel to slave
//====================================================

module ahb_decoder (
        input  [31:0]  H_addr, 
        output         hsel_s1,
        output         hsel_s2
);
//31 30 29 28
assign hsel_s1 = (H_addr[31:28]== 4'h1) ? 1'b1 : 1'b0;
assign hsel_s2 = (H_addr[31:28]== 4'h2) ? 1'b1 : 1'b0;

endmodule