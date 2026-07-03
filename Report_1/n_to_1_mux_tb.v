`timescale 1ns/1ps

module n_to_1_mux_tb;

    // Parameters for this test
    parameter N = 32;
    parameter WIDTH = 8;
    parameter SEL_WIDTH = 5;

    // Combined input bus:
    // 32 inputs × 8 bits = 256 bits
    reg [N*WIDTH-1:0] data_in;

    // Select line
    reg [SEL_WIDTH-1:0] sel;

    // Output
    wire [WIDTH-1:0] d_out;

    // Instantiate generic N:1 MUX
    n_to_1_mux #(
        .N(N),
        .WIDTH(WIDTH),
        .SEL_WIDTH(SEL_WIDTH)
    ) uut (
        .data_in(data_in),
        .sel(sel),
        .d_out(d_out)
    );

    initial begin
        // Generate VCD waveform file
        $dumpfile("n_to_1_mux.vcd");
        $dumpvars(0, n_to_1_mux_tb);

        // Print output in terminal
        $monitor("Time = %0t | sel = %b | d_out = %h",
                 $time, sel, d_out);

        /*
          Assign unique 8-bit values to all 32 inputs.

          data_in[7:0]    = input 0
          data_in[15:8]   = input 1
          data_in[23:16]  = input 2
          ...
          data_in[255:248] = input 31
        */

        data_in[7:0]    = 8'hA1;  // Input 0
        data_in[15:8]   = 8'hB2;  // Input 1
        data_in[23:16]  = 8'hC3;  // Input 2
        data_in[31:24]  = 8'hD4;  // Input 3
        data_in[39:32]  = 8'hE5;  // Input 4
        data_in[47:40]  = 8'hF6;  // Input 5
        data_in[55:48]  = 8'h77;  // Input 6
        data_in[63:56]  = 8'h88;  // Input 7
        data_in[71:64]  = 8'h99;  // Input 8
        data_in[79:72]  = 8'hAA;  // Input 9
        data_in[87:80]  = 8'hBB;  // Input 10
        data_in[95:88]  = 8'hCC;  // Input 11
        data_in[103:96] = 8'hDD;  // Input 12
        data_in[111:104] = 8'hEE; // Input 13
        data_in[119:112] = 8'hFF; // Input 14
        data_in[127:120] = 8'h00; // Input 15
        data_in[135:128] = 8'h11; // Input 16
        data_in[143:136] = 8'h22; // Input 17
        data_in[151:144] = 8'h33; // Input 18
        data_in[159:152] = 8'h44; // Input 19
        data_in[167:160] = 8'h55; // Input 20
        data_in[175:168] = 8'h66; // Input 21
        data_in[183:176] = 8'h77; // Input 22
        data_in[191:184] = 8'h88; // Input 23
        data_in[199:192] = 8'h99; // Input 24
        data_in[207:200] = 8'hAA; // Input 25
        data_in[215:208] = 8'hBB; // Input 26
        data_in[223:216] = 8'hCC; // Input 27
        data_in[231:224] = 8'hDD; // Input 28
        data_in[239:232] = 8'hEE; // Input 29
        data_in[247:240] = 8'hFF; // Input 30
        data_in[255:248] = 8'h00; // Input 31

        // Test every selection value
        sel = 5'b00000; #10;   // Expected output = A1
        sel = 5'b00001; #10;   // Expected output = B2
        sel = 5'b00010; #10;   // Expected output = C3
        sel = 5'b00011; #10;   // Expected output = D4
        sel = 5'b00100; #10;   // Expected output = E5
        sel = 5'b00101; #10;   // Expected output = F6
        sel = 5'b00110; #10;   // Expected output = 77
        sel = 5'b00111; #10;   // Expected output = 88
        sel = 5'b01000; #10;   // Expected output = 99
        sel = 5'b01001; #10;   // Expected output = AA
        sel = 5'b01010; #10;   // Expected output = BB
        sel = 5'b01011; #10;   // Expected output = CC
        sel = 5'b01100; #10;   // Expected output = DD
        sel = 5'b01101; #10;   // Expected output = EE
        sel = 5'b01110; #10;   // Expected output = FF
        sel = 5'b01111; #10;   // Expected output = 00
        sel = 5'b10000; #10;   // Expected output = 11
        sel = 5'b10001; #10;   // Expected output = 22
        sel = 5'b10010; #10;   // Expected output = 33
        sel = 5'b10011; #10;   // Expected output = 44
        sel = 5'b10100; #10;   // Expected output = 55
        sel = 5'b10101; #10;   // Expected output = 66
        sel = 5'b10110; #10;   // Expected output = 77
        sel = 5'b10111; #10;   // Expected output = 88
        sel = 5'b11000; #10;   // Expected output = 99
        sel = 5'b11001; #10;   // Expected output = AA
        sel = 5'b11010; #10;   // Expected output = BB
        sel = 5'b11011; #10;   // Expected output = CC
        sel = 5'b11100; #10;   // Expected output = DD
        sel = 5'b11101; #10;   // Expected output = EE
        sel = 5'b11110; #10;   // Expected output = FF

        $finish;
    end

endmodule