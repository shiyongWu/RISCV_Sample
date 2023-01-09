//==================================
//Date  : 2022/09/20 
//Editor: shiyong
//Note  : RISC-V OP decode
//        input instr lsb 6-bit
//
//==================================

//****************************************
// valid instuction op[1:0] must be 2'b11
// For RV-32I
//****************************************
// op[6:5]   op[4:2]     Instruction type
//  2'b00    3'b000         LOAD
//  2'b00    3'b011       MISC-MEM
//  2'b00    3'b100        OP-IMM 
//  2'b00    3'b101        AUIPC
//---
//  2'b01    3'b000        STORE
//  2'b01    3'b100         OP
//  2'b01    3'b101         LUI
//----
//  2'b11    3'b000       BRANCH
//  2'b11    3'b001        JALR
//  2'b11    3'b011         JAL
//  2'b11    3'b100       SYSTEM

module decoder (
    input [6:0] op_i    , //instrustion[6:0]
    input [2:0] fun3_i  , //instruction[14:12] , R_type , I_type , S_type , B_type
    input [6:0] fun7_i  , //instruction[31:25] 
    //for imm module singal
    output IMM_I_type_1,
    output IMM_I_type_2,
    output IMM_S_type  ,
    output IMM_B_type  ,
    output IMM_U_type  ,
    output IMM_J_type  ,
    //Jump signal 
    output unconditional_Jump,
    output conditional_Jump  ,
    //OP src2 mux sel
    output src2_mux_sel      ,
    //OP output sel          
    output  op_add_sel       ,
    output  op_sub_sel       ,
    output  op_sll_sel       ,
    output  op_sltu_sel      ,
    output  op_xor_sel       ,
    output  op_srl_sel       ,
    output  op_sra_sel       ,
    output  op_or_sel        ,
    output  op_and_sel       ,
    //register write back 
    output  [3:0]   reg_wen 
);

    wire op_valid;
    //
    wire LOAD_instr;
    wire MISC_MEM_instr;
    wire OP_IMM_instr;
    wire AUIPC_instr;
    //
    wire STORE_instr;
    wire OP_instr;
    wire LUI_instr;
    //
    wire BRANCH_instr;
    wire JALR_instr;
    wire JAL_instr;
    wire SYSTEM_instr;

    assign op_vaild = (&op_i[1:0]); //op_i[1:0] == 2'b11

    assign LOAD_instr     = ( op_i[6:2] == 5'b00000) & op_valid;
    assign MISC_MEM_instr = ( op_i[6:2] == 5'b00011) & op_valid;
    assign OP_IMM_instr   = ( op_i[6:2] == 5'b00100) & op_vaild;
    assign AUIPC_instr    = ( op_i[6:2] == 5'b00101) & op_vaild;
    assign STORE_instr    = ( op_i[6:2] == 5'b01000) & op_vaild;
    assign OP_instr       = ( op_i[6:2] == 5'b01100) & op_valid;
    assign LUI_instr      = ( op_i[6:2] == 5'b01101) & op_valid;
    assign BRANCH_instr   = ( op_i[6:2] == 5'b11000) & op_valid;
    assign JALR_instr     = ( op_i[6:2] == 5'b11001) & op_valid & (fun3_i == 3'd0);
    assign JAL_instr      = ( op_i[6:2] == 5'b11011) & op_valid;
    assign SYSTEM_instr   = ( op_i[6:2] == 5'b11100) & op_valid;

    //OP_instr 
    wire OP_ADD  = (fun7_i == 7'h00) & (fun3_i == 3'd0) & OP_instr ;
    wire OP_SUB  = (fun7_i == 7'h20) & (fun3_i == 3'd0) & OP_instr ;
    wire OP_SLL  = (fun7_i == 7'h00) & (fun3_i == 3'd1) & OP_instr ;
    wire OP_SLT  = (fun7_i == 7'h00) & (fun3_i == 3'd2) & OP_instr ;
    wire OP_SLTU = (fun7_i == 7'h00) & (fun3_i == 3'd3) & OP_instr ;
    wire OP_XOR  = (fun7_i == 7'h00) & (fun3_i == 3'd4) & OP_instr ;
    wire OP_SRL  = (fun7_i == 7'h00) & (fun3_i == 3'd5) & OP_instr ;
    wire OP_SRA  = (fun7_i == 7'h20) & (fun3_i == 3'd5) & OP_instr ;
    wire OP_OR   = (fun7_i == 7'h00) & (fun3_i == 3'd6) & OP_instr ;
    wire OP_AND  = (fun7_i == 7'h00) & (fun3_i == 3'd7) & OP_instr ;

    //OP_IMM_instr
    wire OP_IMM_ADD   =                    (fun3_i == 3'd0) & OP_IMM_instr ;
    wire OP_IMM_SLL   = (fun7_i == 7'h0) & (fun3_i == 3'd1) & OP_IMM_instr ;
    wire OP_IMM_SLTI  =                    (fun3_i == 3'd2) & OP_IMM_instr ;
    wire OP_IMM_SLTIU =                    (fun3_i == 3'd3) & OP_IMM_instr ;
    wire OP_IMM_XORI  =                    (fun3_i == 3'd4) & OP_IMM_instr ;
    wire OP_IMM_SRLI  = (fun7_i == 7'h0) & (fun3_i == 3'd5) & OP_IMM_instr ;
    wire OP_IMM_SRAI  = (fun7_i == 7'h0) & (fun3_i == 3'd5) & OP_IMM_instr ;
    wire OP_IMM_ORI   =                    (fun3_i == 3'd6) & OP_IMM_instr ;
    wire OP_IMM_ANDI  =                    (fun3_i == 3'd7) & OP_IMM_instr ;

    //BRANCH_instr
    wire Branch_BEQ   = (fun3_i == 3'd0) & BRANCH_instr ;
    wire Branch_BNE   = (fun3_i == 3'd1) & BRANCH_instr ;
    wire Branch_BLT   = (fun3_i == 3'd4) & BRANCH_instr ;
    wire Branch_BGE   = (fun3_i == 3'd5) & BRANCH_instr ;
    wire Branch_BLTU  = (fun3_i == 3'd6) & BRANCH_instr ;
    wire Branch_BGEU  = (fun3_i == 3'd7) & BRANCH_instr ;

    //LOAD_instr
    wire LOAD_LB      = (fun3_i == 3'd0) & LOAD_instr ;
    wire LOAD_LH      = (fun3_i == 3'd1) & LOAD_instr ;
    wire LOAD_LW      = (fun3_i == 3'd2) & LOAD_instr ;
    wire LOAD_LBU     = (fun3_i == 3'd4) & LOAD_instr ;
    wire LOAD_LHU     = (fun3_i == 3'd5) & LOAD_instr ;
    
    //STORE_instr
    wire STORE_SB     = (fun3_i == 3'd0) & STORE_instr ;
    wire STORE_SH     = (fun3_i == 3'd1) & STORE_instr ;
    wire STORE_SW     = (fun3_i == 3'd2) & STORE_instr ;

    //-------------------------------------------------------------------

    //output to module IMM
    assign IMM_I_type_1 = OP_IMM_ADD | OP_IMM_SLTI | OP_IMM_SLTIU | OP_IMM_XORI | OP_IMM_ORI | OP_IMM_ANDI | JALR_instr | LOAD_instr;
    assign IMM_I_type_2 = OP_IMM_SLL | OP_IMM_SRLI | OP_IMM_SRAI  ;
    assign IMM_S_type   = STORE_instr  ;
    assign IMM_B_type   = BRANCH_instr ;
    assign IMM_U_type   = LUI_instr | AUIPC_instr ;
    assign IMM_J_type   = JAL_instr ;

    //output JUMP signal
    assign unconditional_Jump = JAL_instr | JALR_instr;
    assign conditional_Jump   = BRANCH_instr ;
    
    //output op src2 mux
    //1'b0 : data from register
    //1'b1 : data from IMM
    assign src2_mux_sel =  IMM_I_type_1 | IMM_I_type_2 | IMM_S_type | IMM_U_type | IMM_J_type ;
endmodule