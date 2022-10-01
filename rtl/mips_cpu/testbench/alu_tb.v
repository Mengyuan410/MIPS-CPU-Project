module alu_tb();
    logic clk;
    logic[5:0] Opcode;
    logic[31:0] read_out_1;
    logic[31:0] read_out_2;
    logic[5:0] Funccode;
    logic[2:0] state;
    logic[3:0] ALU_control;
    logic ALU_src;
    logic[63:0] result;
    logic result_is_zero;
    logic alu_en;


initial begin
    $dumpfile("alu_tb.vcd");
    $dumpvars(0, alu_tb);
    
    //test the state
    state = 3'b011; // change later to see it go wrong
    Opcode = 6'b001100;
    #5
    assert (ALU_control == 4'b0000) else $fatal(1, "failed");


    //test each function
    state = 3;
    alu_en = 1;
    #1
    //ADDIU
    clk = 0;
    Opcode = 6'b001001;
    read_out_1 = 35;
    read_out_2 = 28;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 63)else $fatal(0, "failed, result = %d", result);

    //ADDU
    clk = 0;
    Opcode = 6'b000000;
    Funccode = 6'b100001;
    read_out_1 = 4294967295; // (2^32)
    read_out_2 = 3;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 2)else $fatal(0, "failed, result = %d", result[31:0]);
    
    //AND
    clk = 0;
    Opcode = 6'b000000;
    Funccode = 6'b100100;
    read_out_1 = 13;
    read_out_2 = 5;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 5)else $fatal(0, "failed, result = %d", result);

    //ANDI
    clk = 0;
    Opcode = 6'b001100;
    read_out_1 = 5;
    read_out_2 = 9;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 1)else $fatal(0, "failed, result = %d", result);

    //BEQ
    clk = 0;
    Opcode = 6'b000100;
    read_out_1 = 5;
    read_out_2 = 5;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 0)else $fatal(0, "failed, result = %d", result);

    //BGEZ
    clk = 0;
    Opcode = 6'b000001;
    read_out_1 = 8;
    read_out_2 = 7;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 1)else $fatal(0, "failed, result = %d", result);

    //BGEZAL
    clk = 0;
    Opcode = 6'b000001;
    read_out_1 = 3;
    read_out_2 = 6;
    #5
    clk = 1;
    #5
    assert (result[31:0] == -3)else $fatal(0, "failed, result = %d", result);

    //BGTZ
    clk = 0;
    Opcode = 6'b000111;
    read_out_1 = 11;
    read_out_2 = 6;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 5)else $fatal(0, "failed, result = %d", result);

    //BLEZ
    clk = 0;
    Opcode = 6'b000110;
    read_out_1 = 4;
    read_out_2 = 8;
    #5
    clk = 1;
    #5
    assert (result[31:0] == -4)else $fatal(0, "failed, result = %d", result);

    //BLTZ
    clk = 0;
    Opcode = 6'b000001;
    read_out_1 = 7;
    read_out_2 = 1;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 6)else $fatal(0, "failed, result = %d", result);

    //BLTZAL
    clk = 0;
    Opcode = 6'b000001;
    read_out_1 = 131;
    read_out_2 = 455;
    #5
    clk = 1;
    #5
    assert (result[31:0] == -324)else $fatal(0, "failed, result = %d", result);

    //BNE
    clk = 0;
    Opcode =  6'b000101;
    read_out_1 = 35;
    read_out_2 = 34;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 1)else $fatal(0, "failed, result = %d", result);

    //DIV
    clk =0;
    Opcode = 6'b000000;
    Funccode = 6'b011010;
    read_out_1 = 9;
    read_out_2 = -3;
    #5
    clk = 1;
    #5
    assert (result[31:0] == -3 && result[63:32]==0)else $fatal(0, "failed, result = %d", result);

    //DIVU
    clk = 0;
    Opcode = 6'b000000;
    Funccode = 6'b011011;
    read_out_1 = 11;
    read_out_2 = 4;
    #5
    clk = 1;
    #5
    assert (result == 64'h300000002)else $fatal(0, "failed, result = %d", result);

    //LB
    clk = 0;
    Opcode = 6'b100000;
    read_out_1 = 8;
    read_out_2 = -7;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 1)else $fatal(0, "failed, result = %d", result);
    
    //LBU
    clk = 0;
    Opcode = 6'b100100;
    read_out_1 = 4;
    read_out_2 = 5;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 9)else $fatal(0, "failed, result = %d", result);
    
    //LH
    clk = 0;
    Opcode = 6'b100001;
    read_out_1 = 23;
    read_out_2 = -3;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 20)else $fatal(0, "failed, result = %d", result);
    
    //LHU
    clk = 0;
    Opcode = 6'b100101;
    read_out_1 = 5;
    read_out_2 = 20;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 25)else $fatal(0, "failed, result = %d", result);
    

    //LUI
    clk = 0;
    Opcode = 6'b001111;
    read_out_1 = 32'h57;
    read_out_2 = 32'ha;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 32'ha0000)else $fatal(0, "failed, result = %d", result);
    
    //LW
    clk = 0;
    Opcode = 6'b100011;
    read_out_1 = 23;
    read_out_2 = 20;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 43)else $fatal(0, "failed, result = %d", result);

    //LWL
    clk = 0;
    Opcode = 6'b100010;
    read_out_1 = 53;
    read_out_2 = 48;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 101)else $fatal(0, "failed, result = %d", result);

    //LWR
    clk = 0;
    Opcode = 6'b100110;
    read_out_1 = 12;
    read_out_2 = 52;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 64)else $fatal(0, "failed, result = %d", result);

    //MULT
    clk = 0;
    Opcode = 0;
    Funccode = 6'b011000;
    read_out_1 = -2147483648;
    read_out_2 = 2;
    #5
    clk = 1;
    #5
    assert (result == -4294967296) else $fatal(0, "failed, result = %d", result);

    //MULTU
    clk = 0;
    Opcode = 0;
    Funccode = 6'b011001;
    read_out_1 = 4;
    read_out_2 = 6;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 24)else $fatal(0, "failed, result = %d", result);

    //OR
    clk = 0;
    Opcode = 0;
    Funccode = 6'b100101;
    read_out_1 = 32'h33f0425a;
    read_out_2 = 32'h00000111;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 64'h33f0435b)else $fatal(0, "failed, result = %d", result);

    //ORI
    clk = 0;
    Opcode = 6'b001101;
    read_out_1 = 32'h00200020; 
    read_out_2 = 32'h0f01fb0e;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 64'h0f21fb2e)else $fatal(0, "failed, result = %d", result);

    //SB
    clk = 0;
    Opcode = 6'b101000;
    read_out_1 = 40;
    read_out_2 = 32;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 72)else $fatal(0, "failed, result = %d", result);

    //SH
    clk = 0;
    Opcode = 6'b101001;
    read_out_1 = 12;
    read_out_2 = 34;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 46)else $fatal(0, "failed, result = %d", result);

    //SLL
    clk = 0;
    Opcode = 0;
    Funccode = 6'b000000;
    read_out_1[10:6] = 5'b00100;
    read_out_2 = 32'h400;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 32'h4000)else $fatal(0, "failed, result = %d", result);

    //SLLV
    clk = 0;
    Opcode = 0;
    Funccode = 6'b000100; 
    read_out_1 = 8;
    read_out_2 = 4921;
    #5
    clk = 1;
    state = 2;
    #5
    clk = 0;
    #4
    state = 3;
    clk = 1;
    #3
    clk = 0;
    #3
    clk = 1;
    
    assert (result[31:0] == 1259776)else $fatal(0, "failed, result = %d", result);
    
    //SLT
    clk = 0;
    Opcode = 0;
    Funccode = 6'b101010;
    read_out_1 = 100034;
    read_out_2 = 235;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 0)else $fatal(0, "failed, result = %d", result);

    //SLTI
    clk = 0;
    Opcode = 6'b001010;
    read_out_1 = 223;
    read_out_2 = 20934;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 1)else $fatal(0, "failed, result = %d", result);

    //SLTIU
    clk = 0;
    Opcode = 6'b001011;
    read_out_1 = 123543632;
    read_out_2 = 98753;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 0)else $fatal(0, "failed, result = %d", result);

    //SLTU
    clk = 0;
    Opcode = 0;
    Funccode = 6'b101011;
    read_out_1 = 339456;
    read_out_2 = 2340053;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 1)else $fatal(0, "failed, result = %d", result);

    //SRA
    state = 2;
    clk = 0;
    Opcode = 0;
    Funccode = 6'b000011;
    read_out_1[10:6] = 4;
    read_out_2 = 32'h01101100;
    #5
    clk = 1;
    #5
    
    clk = 0 ;
    #3
    state = 3;
    #3
    clk = 1;
    #3
    clk = 0;
    #3
    clk = 1;
    #3
    assert (result[31:0] == 32'h00110110)else $fatal(0, "failed, result = %d", result);

    //SRAV
    state = 2;
    clk = 0;
    Opcode = 0;
    Funccode = 6'b000111;
    read_out_1 = 4;
    read_out_2 = 32'hf942b49f;
    #5
    clk = 1;
    #5
    clk = 0 ;
    #3
    state = 3;
    #3
    clk = 1;
    #3
    clk = 0;
    #3
    clk = 1;
    #3
    assert (result[31:0] == 32'hff942b49)else $fatal(0, "failed, result = %h", result);

    //SRL
    state = 2;
    clk = 0;
    Opcode = 0;
    Funccode = 6'b000010;
    read_out_1[10:6] = 8;
    read_out_2 = 32'h00001100;
    #5
    clk = 1;
    #5
    clk = 0 ;
    #3
    state = 3;
    #3
    clk = 1;
    #3
    clk = 0;
    #3
    clk = 1;
    #3
    assert (result[31:0] == 32'h00000011)else $fatal(0, "failed, result = %d", result);

    //SRLV
    state = 2;
    clk = 0;
    Opcode = 0;
    Funccode = 6'b000110;
    read_out_1 = 20;
    read_out_2 = 32'h00001111;
    #5
    clk = 1;
    #5
    clk = 0 ;
    #3
    state = 3;
    #3
    clk = 1;
    #3
    clk = 0;
    #3
    clk = 1;
    #3
    assert (result[31:0] == 0)else $fatal(0, "failed, result = %d", result);

    //SUBU when result should be positive
    state = 2;
    clk = 0;
    Opcode = 0;
    Funccode = 6'b100011;
    read_out_1 = 3392;
    read_out_2 = 32;
    #5
    clk = 1;
    #5
    clk = 0 ;
    #3
    state = 3;
    #3
    clk = 1;
    #3
    clk = 0;
    #3
    clk = 1;
    #3
    assert (result[31:0] == 3360)else $fatal(0, "failed, result = %d", result);
    
    //SUBU when result should be negative
    state = 2;
    clk = 0;
    Opcode = 0;
    Funccode = 6'b100011;
    read_out_1 = 3600;
    read_out_2 = 4800;
    #5
    clk = 1;
    #5
    clk = 0 ;
    #3
    state = 3;
    #3
    clk = 1;
    #3
    clk = 0;
    #3
    clk = 1;
    #3
    assert (result[31:0] == 2**64-1200)else $fatal(0, "failed, result = %d", result);

    //SW
    state = 2;
    clk = 0;
    Opcode = 6'b101011;
    read_out_1 = 3002;
    read_out_2 = 321;
    #5
    clk = 1;
    #5
    clk = 0 ;
    #3
    state = 3;
    #3
    clk = 1;
    #3
    clk = 0;
    #3
    clk = 1;
    #3
    assert (result[31:0] == 3323)else $fatal(0, "failed, result = %d", result);

    //XOR
    state = 2;
    clk = 0;
    Opcode = 0;
    Funccode = 6'b100110;
    read_out_1 = 32'hfb338291;
    read_out_2 = 32'h988be293;
    #5
    clk = 1;
    #5
    clk = 0 ;
    #3
    state = 3;
    #3
    clk = 1;
    #3
    clk = 0;
    #3
    clk = 1;
    #3
    assert (result[31:0] == 32'h63b86002)else $fatal(0, "failed, result = %d", result);

    //XORI
    state = 2;
    clk = 0;
    Opcode = 6'b001110;
    read_out_1 = 32'h213212fb;
    read_out_2 = 32'h122bfd32;
    #5
    clk = 1;
    #5
    clk = 0 ;
    #3
    state = 3;
    #3
    clk = 1;
    #3
    clk = 0;
    #3
    clk = 1;
    #3
    assert (result[31:0] == 32'h3319efc9)else $fatal(0, "failed, result = %d", result);
        state = 3;
    alu_en = 1;

    
    //ADDIU
    #3

    clk = 0;
    Opcode = 6'b001001;
    read_out_1 = 35;
    read_out_2 = 28;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 63)else $fatal(0, "failed, result = %d", result);
    

    //ADDU
    clk = 0;
    Opcode = 6'b000000;
    Funccode = 6'b100001;
    read_out_1 = 4294967295; // (2^32)
    read_out_2 = 3;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 2)else $fatal(0, "failed, result = %d", result[31:0]);
    
    //AND
    clk = 0;
    Opcode = 6'b000000;
    Funccode = 6'b100100;
    read_out_1 = 13;
    read_out_2 = 5;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 5)else $fatal(0, "failed, result = %d", result);

    //ANDI
    clk = 0;
    Opcode = 6'b001100;
    read_out_1 = 5;
    read_out_2 = 9;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 1)else $fatal(0, "failed, result = %d", result);

    //BEQ
    clk = 0;
    Opcode = 6'b000100;
    read_out_1 = 5;
    read_out_2 = 5;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 0)else $fatal(0, "failed, result = %d", result);

    //BGEZ
    clk = 0;
    Opcode = 6'b000001;
    read_out_1 = 8;
    read_out_2 = 7;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 1)else $fatal(0, "failed, result = %d", result);

    //BGEZAL
    clk = 0;
    Opcode = 6'b000001;
    read_out_1 = 3;
    read_out_2 = 6;
    #5
    clk = 1;
    #5
    assert (result[31:0] == -3)else $fatal(0, "failed, result = %d", result);

    //BGTZ
    clk = 0;
    Opcode = 6'b000111;
    read_out_1 = 11;
    read_out_2 = 6;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 5)else $fatal(0, "failed, result = %d", result);

    //BLEZ
    clk = 0;
    Opcode = 6'b000110;
    read_out_1 = 4;
    read_out_2 = 8;
    #5
    clk = 1;
    #5
    assert (result[31:0] == -4)else $fatal(0, "failed, result = %d", result);

    //BLTZ
    clk = 0;
    Opcode = 6'b000001;
    read_out_1 = 7;
    read_out_2 = 1;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 6)else $fatal(0, "failed, result = %d", result);

    //BLTZAL
    clk = 0;
    Opcode = 6'b000001;
    read_out_1 = 131;
    read_out_2 = 455;
    #5
    clk = 1;
    #5
    assert (result[31:0] == -324)else $fatal(0, "failed, result = %d", result);

    //BNE
    clk = 0;
    Opcode =  6'b000101;
    read_out_1 = 35;
    read_out_2 = 34;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 1)else $fatal(0, "failed, result = %d", result);

    //DIV
    clk = 0;
    Opcode = 6'b000000;
    Funccode = 6'b011010;
    read_out_1 = 32'hfffffff0; //-16
    read_out_2 = 2;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 32'hfffffff8 && result[63:32]==0)else $fatal(0, "failed, result = %d", result);
    // usually equal to 7FFFFFFF8?? is this right 0 or 1^
    
    //DIVU
    clk = 0;
    Opcode = 6'b000000;
    Funccode = 6'b011011;
    read_out_1 = 11;
    read_out_2 = 4;
    #5
    clk = 1;
    #5
    assert (result == 64'h300000002)else $fatal(0, "failed, result = %d", result);
    
    //LB
    clk = 0;
    Opcode = 6'b100000;
    read_out_1 = 32'hffffffff;
    read_out_2 = 1;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 0)else $fatal(0, "failed, result = %d", result);
    
    //LBU
    clk = 0;
    Opcode = 6'b100100;
    read_out_1 = 32'h7fffffff;
    read_out_2 = 2;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 32'h80000001)else $fatal(0, "failed, result = %d", result);
    
    //LH
    clk = 0;
    Opcode = 6'b100001;
    read_out_1 = 32'hffffffff;
    read_out_2 = 5;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 4)else $fatal(0, "failed, result = %d", result);
    
    //LHU
    clk = 0;
    Opcode = 6'b100101;
    read_out_1 = 32'h7fffffff;
    read_out_2 = 5;
    #5
    clk = 1;
    #5
    assert (result[31:0] == 32'h80000004)else $fatal(0, "failed, result = %d", result);

    //MULT
    clk = 0;
    Opcode = 6'b000000;
    Funccode = 6'b011000;
    read_out_1 = 32'hffffffff;
    read_out_2 = 5;
    #5
    clk = 1;
    #5
    assert (result == -5)else $fatal(0, "failed, result = %h", result);

    

    //test result_is_zero
    //use SUBU to get result = 0
    state = 2;
    clk = 0;
    Opcode = 0;
    Funccode = 6'b100011;
    read_out_1 = 1;
    read_out_2 = 1;
    #5
    clk = 1;
    #5
    clk = 0 ;
    #3
    state = 3;
    #3
    clk = 1;
    #3
    clk = 0;
    #3
    clk = 1;
    #3
    assert (result == 0)else $fatal(0, "failed, result = %d", result);
    assert (result_is_zero == 1)else $fatal(0, "failed, result_is_zero = %d", result_is_zero);

end

alu_control alu_con(
        .Opcode(Opcode),
        .Funccode(Funccode),
        .state(state),
        .ALU_control(ALU_control),
        .ALU_src(ALU_src)
);


alu a(
        .clk(clk),
        .control(ALU_control),
        .read_out_1(read_out_1),
        .read_out_2(read_out_2),
        .ALU_src(ALU_src),
        .alu_result(result),
        .result_is_zero(result_is_zero),
        .alu_en(alu_en)
);

endmodule

