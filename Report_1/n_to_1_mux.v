
module n_to_1_mux #(
    parameter N = 32,             // Number of inputs
    parameter WIDTH = 8,         // Width of each input
    parameter SEL_WIDTH = 5      // log2(N), for N=32 --> 5 bits
)(
    input  [N*WIDTH-1:0] data_in,  // Combined input bus
    input  [SEL_WIDTH-1:0] sel,    // Select line
    output reg [WIDTH-1:0] d_out   // Selected output
);

    always @(*) begin
       
    // Check whether the selected input index is valid.
    // Example:
    // If N = 8, valid sel values are 0 to 7.
    // If sel is 8 or more, it means sel is trying to select
    // an input that does not exist.
    if (sel < N)

        // Select WIDTH number of bits from the combined input bus.
        //
        // Syntax:
        // data_in[starting_bit +: number_of_bits]
        //
        // Here:
        // starting_bit   = sel * WIDTH
        // number_of_bits = WIDTH
        //
        // Example for WIDTH = 8:
        //
        // sel = 0  --> data_in[0  +: 8] = data_in[7:0]
        // sel = 1  --> data_in[8  +: 8] = data_in[15:8]
        // sel = 2  --> data_in[16 +: 8] = data_in[23:16]
        // sel = 3  --> data_in[24 +: 8] = data_in[31:24]
        //
        // Thus, the selected input block is copied to d_out.
        d_out = data_in[sel * WIDTH +: WIDTH];

    else

        // If sel is invalid, assign all zeros to output.
        //
        // {WIDTH{1'b0}} means repeat 1'b0 WIDTH times.
        //
        // Example:
        // WIDTH = 8  --> 8'b00000000
        // WIDTH = 4  --> 4'b0000
        d_out = {WIDTH{1'b0}};

    end

endmodule