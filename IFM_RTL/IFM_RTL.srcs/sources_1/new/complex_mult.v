`timescale 1ns / 1ps
// Combinational version (single cycle, no pipeline)
module complex_mult #(
    parameter WIDTH = 16
)(
    input signed [WIDTH-1:0] a_real,
    input signed [WIDTH-1:0] a_imag,
    input signed [WIDTH-1:0] b_real,
    input signed [WIDTH-1:0] b_imag,
    output signed [2*WIDTH:0] result_real,
    output signed [2*WIDTH:0] result_imag
 );

    // Intermediate multiplication results
    wire signed [2*WIDTH-1:0] mult_ar_br = a_real * b_real;
    wire signed [2*WIDTH-1:0] mult_ai_bi = a_imag * b_imag;
    wire signed [2*WIDTH-1:0] mult_ar_bi = a_real * b_imag;
    wire signed [2*WIDTH-1:0] mult_ai_br = a_imag * b_real;
    
    // Complex multiplication: (a + jb)(c + jd) = (ac - bd) + j(ad + bc)
    assign result_real = mult_ar_br - mult_ai_bi;
    assign result_imag = mult_ar_bi + mult_ai_br;

endmodule