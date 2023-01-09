//=================================================================
//Date  : 2022/09/20 
//Editor: shiyong
//Note  : RISC-V immediate encoding by different instructions type
//================================================================

module IMM #(
    parameter XLEN_ZERO    = 32'd0,
    parameter XLEN         = 32 
)(
    input  [XLEN-1:7]          inst_i      ,//instruction [31:7]
    input                      IMM_I_type_1,
    input                      IMM_I_type_2,
    input                      IMM_S_type  ,
    input                      IMM_B_type  ,
    input                      IMM_U_type  ,
    input                      IMM_J_type  ,
    output  [XLEN-1:0]         IMM_Result  
);

    wire [XLEN-1:0] I_type_1_Result;
    wire [XLEN-1:0] I_type_2_Result;
    wire [XLEN-1:0] S_type_Result;
    wire [XLEN-1:0] B_type_Result;
    wire [XLEN-1:0] U_type_Result;
    wire [XLEN-1:0] J_type_Result;

    assign I_type_1_Result = {{21{inst_i[31]}},inst_i[30:20]};
    assign I_type_2_Result = {{27{inst_i[31]}},inst_i[24:20]};
    assign S_type_Result   = {{21{inst_i[31]}},inst_i[30:25],inst_i[11:7]};
    assign B_type_Result   = {{20{inst_i[31]}},inst_i[7],inst_i[30:25],inst_i[11:8],1'b0};
    assign U_type_Result   = {inst_i[31:12],12'd0};
    assign J_type_Result   = {{12{inst_i[31]}},inst_i[19:12],inst_i[20],inst_i[30:25],inst_i[24:21],1'b0};

    assign  IMM_Result     = IMM_I_type_1 ?  I_type_1_Result :
                             IMM_I_type_2 ?  I_type_2_Result :
                             IMM_S_type   ?  S_type_Result   :
                             IMM_B_type   ?  B_type_Result   :
                             IMM_J_type   ?  IMM_J_type      :
                                             32'd0           ;

endmodule