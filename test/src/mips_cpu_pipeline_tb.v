
module mips_cpu_pipeline_tb (
);
    logic clk, reset;
    logic waitrequest;
    logic[31:0] readdata; 
    logic read, write, active;
    logic[31:0] address; 
    logic[31:0] writedata;
    logic[31:0] register_v0;
    logic[3:0] byteenable;
    logic[15:0] count;
    parameter MEM_1 = "";
    parameter MEM_2 = "";

    initial begin
        clk = 0;
        count = 0;
        repeat(2000) begin
            #1;
            clk = !clk;
            #1;
            clk = !clk;
            count = count+1;
        end
        $finish;
    end

    // always @(*) begin
        // if(active == 0)begin
        //     $display("CPU MIPS : V0 = %d", register_v0);
        //     $display("Count:",count);
        //     $finish;
        // end
    // end
    
    initial begin
        reset = 0;
        @(negedge clk);
        reset = 1;
        
        @(negedge clk);//state 1
        reset = 0;

        @(negedge clk);

        while(active)begin
            @(negedge clk);
            
        end

        if(active == 0)begin
            $display("CPU MIPS : V0 = %d", register_v0);
            $display("Count:",count);
            $finish;
        end
        
    end

    mips_cpu_bus_pipeline cpu(
        //input
        .clk(clk),
        .reset(reset),
        .readdata(readdata),
        .waitrequest(waitrequest),
        //output
        .read(read),
        .write(write),
        .active(active),
        .address(address),
        .writedata(writedata),
        .register_v0(register_v0),
        .byteenable(byteenable)
    );
    
    mips_cpu_mock_mem #(MEM_1, MEM_2) mock_mem (
        .clk(clk),
        .address(address),
        .write_data(writedata),
        .byteenable(byteenable),
        .write_enable(write),
        .MemRead(read),
        //output 
        .read_data(readdata),
        .waitrequest(waitrequest)
    );

    

endmodule