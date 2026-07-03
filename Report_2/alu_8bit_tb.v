// ============================================================
// Description: Testbench for 8-bit ALU
// ============================================================

`timescale 1ns/1ps

module alu_8bit_tb;

    // Testbench input signals
    reg [7:0] A;
    reg [7:0] B;
    reg [2:0] sel;

    // Testbench output signals
    wire [7:0] result;
    wire       carry;
    wire       zero;

    // --------------------------------------------------------
    // Instantiate the ALU module
    // --------------------------------------------------------
    alu_8bit uut (
        .A(A),
        .B(B),
        .sel(sel),
        .result(result),
        .carry(carry),
        .zero(zero)
    );

    // --------------------------------------------------------
    // Task for automatically checking expected output
    // --------------------------------------------------------
    task check_output;
        input [7:0] expected_result;
        input       expected_carry;
        input       expected_zero;

        begin
            if ((result === expected_result) &&
                (carry  === expected_carry) &&
                (zero   === expected_zero)) begin

                $display("PASS --> Result=%h Carry=%b Zero=%b",
                         result, carry, zero);
            end

            else begin
                $display("FAIL --> Got: Result=%h Carry=%b Zero=%b",
                         result, carry, zero);

                $display("          Expected: Result=%h Carry=%b Zero=%b",
                         expected_result, expected_carry, expected_zero);
            end
        end
    endtask

    // --------------------------------------------------------
    // Apply different test cases
    // --------------------------------------------------------
    initial begin

        // Generate waveform file for GTKWave
        $dumpfile("alu_8bit.vcd");
        $dumpvars(0, alu_8bit_tb);

        // Print a heading in terminal
        $display("==============================================");
        $display("       8-BIT ALU VERILOG SIMULATION");
        $display("==============================================");

        // Initialize all inputs
        A   = 8'b00000000;
        B   = 8'b00000000;
        sel = 3'b000;

        #10;

        // ----------------------------------------------------
        // Test 1: Addition
        // 05 + 03 = 08
        // ----------------------------------------------------
        $display("\nTest 1: Addition");
        A   = 8'h05;
        B   = 8'h03;
        sel = 3'b000;

        #10;
        check_output(8'h08, 1'b0, 1'b0);

        // ----------------------------------------------------
        // Test 2: Addition with carry
        // FF + 01 = 100 hexadecimal
        // Result = 00 and Carry = 1
        // ----------------------------------------------------
        $display("\nTest 2: Addition with Carry");
        A   = 8'hFF;
        B   = 8'h01;
        sel = 3'b000;

        #10;
        check_output(8'h00, 1'b1, 1'b1);

        // ----------------------------------------------------
        // Test 3: Subtraction without borrow
        // 0A - 04 = 06
        // ----------------------------------------------------
        $display("\nTest 3: Subtraction without Borrow");
        A   = 8'h0A;
        B   = 8'h04;
        sel = 3'b001;

        #10;
        check_output(8'h06, 1'b0, 1'b0);

        // ----------------------------------------------------
        // Test 4: Subtraction with borrow
        // 03 - 05 = FE in 8-bit two's complement
        // Borrow = 1
        // ----------------------------------------------------
        $display("\nTest 4: Subtraction with Borrow");
        A   = 8'h03;
        B   = 8'h05;
        sel = 3'b001;

        #10;
        check_output(8'hFE, 1'b1, 1'b0);

        // ----------------------------------------------------
        // Test 5: AND operation
        // AA AND 0F = 0A
        // ----------------------------------------------------
        $display("\nTest 5: AND Operation");
        A   = 8'hAA;
        B   = 8'h0F;
        sel = 3'b010;

        #10;
        check_output(8'h0A, 1'b0, 1'b0);

        // ----------------------------------------------------
        // Test 6: OR operation
        // A0 OR 0F = AF
        // ----------------------------------------------------
        $display("\nTest 6: OR Operation");
        A   = 8'hA0;
        B   = 8'h0F;
        sel = 3'b011;

        #10;
        check_output(8'hAF, 1'b0, 1'b0);

        // ----------------------------------------------------
        // Test 7: XOR operation
        // AA XOR 0F = A5
        // ----------------------------------------------------
        $display("\nTest 7: XOR Operation");
        A   = 8'hAA;
        B   = 8'h0F;
        sel = 3'b100;

        #10;
        check_output(8'hA5, 1'b0, 1'b0);

        // ----------------------------------------------------
        // Test 8: NOT operation
        // NOT 0F = F0
        // ----------------------------------------------------
        $display("\nTest 8: NOT Operation");
        A   = 8'h0F;
        B   = 8'h00;
        sel = 3'b101;

        #10;
        check_output(8'hF0, 1'b0, 1'b0);

        // ----------------------------------------------------
        // Test 9: Left shift
        // 91 = 10010001
        // 91 << 1 = 22
        // Carry = original MSB = 1
        // ----------------------------------------------------
        $display("\nTest 9: Left Shift");
        A   = 8'h91;
        B   = 8'h00;
        sel = 3'b110;

        #10;
        check_output(8'h22, 1'b1, 1'b0);

        // ----------------------------------------------------
        // Test 10: Right shift
        // 91 = 10010001
        // 91 >> 1 = 48
        // Carry = original LSB = 1
        // ----------------------------------------------------
        $display("\nTest 10: Right Shift");
        A   = 8'h91;
        B   = 8'h00;
        sel = 3'b111;

        #10;
        check_output(8'h48, 1'b1, 1'b0);

        // ----------------------------------------------------
        // Test 11: Zero flag test
        // 45 - 45 = 00
        // zero flag must become 1
        // ----------------------------------------------------
        $display("\nTest 11: Zero Flag Test");
        A   = 8'h45;
        B   = 8'h45;
        sel = 3'b001;

        #10;
        check_output(8'h00, 1'b0, 1'b1);

        // End simulation
        $display("\n==============================================");
        $display("Simulation completed.");
        $display("==============================================");

        #10;
        $finish;
    end

endmodule