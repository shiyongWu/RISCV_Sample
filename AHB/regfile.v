//====================================================
// module      :  regfile 
// editor      :  shiyong 
// data        :  2022/11/12
// description :  mem 
//                test ahb protocol
//----------------------------------------------------

module regfile (
        input             clk    ,
        input             reset_n,
        input  [ 9:0]     addr   ,
        input  [31:0]     wdata  ,
        input             read   ,
        input             write  ,
        //
        output reg [31:0] rdata
);

reg [31:0] mem_core [0:1023];

integer i;

always @(posedge clk or negedge reset_n) begin
    if(~reset_n)begin
        for(i=0; i <1024;i=i+1)begin
            mem_core[i] <= 32'd0;
        end 
    end
    else begin
        if(write) mem_core [addr] <= wdata; 
    end
end

always@(*)begin
    rdata = read ? mem_core[addr] : 32'h0000_0000;
end
    
endmodule