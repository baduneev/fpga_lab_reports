`timescale 1ns / 1ps

module processor_frontend_tb;

    reg clk;
    reg rst;

    reg [7:0] alu_result;

    wire [7:0]  pc;
    wire [15:0] inst;

    wire [2:0] read_reg1;
    wire [2:0] read_reg2;
    wire [2:0] write_reg;
    wire       write_enable;

    wire [7:0] immediate;
    wire       sel_2s_comp;
    wire       sel_operand1;
    wire [2:0] alu_op;

    wire [7:0] regout1;
    wire [7:0] regout2;

    wire [7:0] operand1;
    wire [7:0] operand2;

    // Instantiate processor front-end
    processor_frontend_8bit uut (
        .clk(clk),
        .rst(rst),

        .alu_result(alu_result),

        .pc(pc),
        .inst(inst),

        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_enable(write_enable),

        .immediate(immediate),
        .sel_2s_comp(sel_2s_comp),
        .sel_operand1(sel_operand1),
        .alu_op(alu_op),

        .regout1(regout1),
        .regout2(regout2),

        .operand1(operand1),
        .operand2(operand2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Temporary fake ALU for testing only
    always @(*) begin
        case (alu_op)

            3'b000: alu_result = operand1 + operand2; // ADD

            // For SUB, operand2 is already 2's complement
            3'b001: alu_result = operand1 + operand2; // SUB

            3'b010: alu_result = operand1 & operand2; // AND
            3'b011: alu_result = operand1 | operand2; // OR
            3'b100: alu_result = operand1 ^ operand2; // XOR
            3'b101: alu_result = operand1 + 8'd1;     // INC
            3'b110: alu_result = operand1 - 8'd1;     // DEC

            default: alu_result = 8'd0;

        endcase
    end

    initial begin
        $dumpfile("processor_frontend_tb.vcd");
        $dumpvars(0, processor_frontend_tb);

        $monitor(
            "time=%0t | pc=%0d | inst=%h | we=%b | wr=R%0d | r1=R%0d | r2=R%0d | op1=%0d | op2=%0d | alu=%0d | R1=%0d R2=%0d R3=%0d R4=%0d R5=%0d R6=%0d R7=%0d",
            $time,
            pc,
            inst,
            write_enable,
            write_reg,
            read_reg1,
            read_reg2,
            operand1,
            operand2,
            alu_result,
            uut.rf.regs[1],
            uut.rf.regs[2],
            uut.rf.regs[3],
            uut.rf.regs[4],
            uut.rf.regs[5],
            uut.rf.regs[6],
            uut.rf.regs[7]
        );

        rst = 1;
        #12;

        rst = 0;
        #120;

        $finish;
    end

endmodule