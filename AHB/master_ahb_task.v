
module master_ahb_task(
            input             clk     ,
            output reg        req_o   ,
            output reg        lock_o  ,
            output reg        write_o ,
            output reg [31:0] addr_o  ,
            output reg [31:0] wdata_o ,
            output reg [ 2:0] burst_o 
);
    initial begin
            req_o    = 1'b0;
            lock_o   = 1'b0;
            write_o  = 1'b0;
            addr_o   = 32'h0000_0000;
            wdata_o  = 32'h0000_0000;
            burst_o  = 3'd0;        
    end


    task SINGLE_WRITE;
        input [31:0] addr;
        input [31:0] wdata;

        begin
            repeat (1) @(posedge clk);
            req_o    = 1'b1;
            lock_o   = 1'b1;
            write_o  = 1'b1;
            addr_o   = addr;
            wdata_o  = wdata;
            burst_o  = 3'd0;
            repeat (3)@(posedge clk);
            req_o    = 1'b0;
            lock_o   = 1'b0;
            write_o  = 1'b0;
            addr_o   = addr;
            wdata_o  = wdata;
            burst_o  = 3'd0;
            repeat (6)@(posedge clk);            
        end
    endtask

    task SINGLE_READ;
        input [31:0] addr;

        begin
            repeat (1) @(posedge clk);
            req_o    = 1'b1;
            lock_o   = 1'b1;
            write_o  = 1'b0;
            addr_o   = addr;
            wdata_o  = 32'd0;
            burst_o  = 3'd0;
            repeat (3)@(posedge clk);
            req_o    = 1'b0;
            lock_o   = 1'b0;
            write_o  = 1'b0;
            addr_o   = addr;
            wdata_o  = 32'd0;
            burst_o  = 3'd0;   
            repeat (6)@(posedge clk);          
        end
    endtask    

endmodule