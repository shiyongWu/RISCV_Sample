module PC #(
    parameter  XLEN = 32
) (
    input                 clk,
    input                 resetz,
    output reg [XLEN-1:0] next_pc
);
    
    always@(posedge clk or negedge resetz)
        if(~resetz) next_pc <= 'd0;
        else next_pc <= next_pc + 'd4;

endmodule