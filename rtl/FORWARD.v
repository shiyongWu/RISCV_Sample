`timescale 1ns/1ps

module FORWARD(
       output src1_forward_sel,
       output src2_forward_sel,
       input  [4:0]    src1_de,
       input  [4:0]    src2_de,
       input  [4:0]      rd_wb
);

    assign src1_forward_sel = (src1_de == rd_wb) ? 1'd1:1'd0;
    assign src2_forward_sel = (src2_de == rd_wb) ? 1'd1:1'd0;    

endmodule
