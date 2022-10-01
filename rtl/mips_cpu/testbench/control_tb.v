module control_tb(
);
    logic[31:0] instruction;
    logic[2:0] state;
    logic [1:0]reg_dst;
    // reg_dst = 0, inst[20:16]; reg_dst = 1, inst[15-11]; reg_dst = 2 write to $31
    logic mem_read;
    logic [2:0] data_to_reg;
    // data_to_reg = 0, reg input = ALU out; data_to_reg = 1, reg input = mem out,; data_to_reg = 2, PC output connect
    logic[3:0] alu_control_input;
    logic mem_write;
    logic reg_write;
    logic reg_read;
    logic alu_src;
    logic Hi_enable;
    logic Lo_enable;
    logic Branch_0;  



        initial begin
            $dumpfile("control1.vcd");
            $dumpvars(0,control_tb);
           
            #1
            state = 1;
            instruction = 32'h00000018;
            #1
            assert(mem_read == 1 && mem_write==0 && reg_write==0 && Hi_enable==0 && Lo_enable==0);
           
            #1
            state = 2;
            #1
            assert(mem_read == 0 && mem_write == 0 && reg_write == 0 && reg_read == 1 && Hi_enable==0 && Lo_enable==0);
           
            #1
            state = 3;
            #1
            assert(mem_read == 0 && mem_write == 0 && reg_write == 0 && reg_read == 0 && Hi_enable==0 && Lo_enable==0);
           
            #1
            state = 4;
            #1
            assert(mem_read == 0 && mem_write == 0 && reg_write == 0 && reg_read == 0 && Hi_enable==0 && Lo_enable==0);

            #1
            state = 5;
            #1
            assert(mem_read == 0 && mem_write == 0 && reg_write == 0 && reg_read == 0 && Hi_enable==1 && Lo_enable==1);            

            #1
            state = 1; // testing the mfhi
            instruction = 32'h00000010;
            #1
            assert(mem_read == 1 && mem_write == 0 && reg_write == 0 && reg_read == 0 && Hi_enable==0 && Lo_enable==0);

            #1
            state = 2;
            #1
            assert(mem_read == 0 && mem_write == 0 && reg_write == 0 && reg_read == 1 && Hi_enable==0 && Lo_enable==0);
           
            #1
            state = 3;
            #1
            assert(mem_read == 0 && mem_write == 0 && reg_write == 0 && reg_read == 0 && Hi_enable==0 && Lo_enable==0);
           
            #1
            state = 4;
            #1
            assert(mem_read == 0 && mem_write == 0 && reg_write == 0 && reg_read == 0 && Hi_enable==0 && Lo_enable==0);

            #1
            state = 5;
            #1// time = 20
            assert(mem_read == 0 && mem_write == 0 && reg_write == 1 && reg_read == 0); 




        end

    control cont(
        .instruction(instruction),
        .state(state),
        .reg_dst(reg_dst),
    // reg_dst = 0, inst[20:16]; reg_dst = 1, inst[15-11]; reg_dst = 2 write to $31
        .mem_read(mem_read),
        .data_to_reg(data_to_reg),
    // data_to_reg = 0, reg input = ALU out; data_to_reg = 1, reg input = mem out,; data_to_reg = 2, PC output connect
        .alu_control_input(alu_control_input),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .reg_read(reg_read),
        .alu_src(alu_src),
        .Hi_enable(Hi_enable),
        .Lo_enable(Lo_enable),
        .Branch_0(Branch_0)  
    );
endmodule

    /*
    MemRead
MemWrtite
DatatoReg
RegDst
RegWrite
RegRead
Hi Write
Lo Write*/