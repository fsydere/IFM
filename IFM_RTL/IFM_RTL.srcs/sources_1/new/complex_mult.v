`timescale 1ns / 1ps

module complex_mult #(
    parameter WIDTH = 16
)(
    input clk,
    input rst_n,
    input signed [WIDTH-1:0] a_real,
    input signed [WIDTH-1:0] a_imag,
    input signed [WIDTH-1:0] b_real,
    input signed [WIDTH-1:0] b_imag,
    input valid_in,
    output reg signed [2*WIDTH:0] result_real,
    output reg signed [2*WIDTH:0] result_imag,
    output reg valid_out
);

    // Stage 1: Multiplication stage
    reg signed [2*WIDTH-1:0] mult_ar_br_reg;
    reg signed [2*WIDTH-1:0] mult_ai_bi_reg;
    reg signed [2*WIDTH-1:0] mult_ar_bi_reg;
    reg signed [2*WIDTH-1:0] mult_ai_br_reg;
    reg valid_stage1;
    
    // Stage 1: Perform all four multiplications
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mult_ar_br_reg <= 0;
            mult_ai_bi_reg <= 0;
            mult_ar_bi_reg <= 0;
            mult_ai_br_reg <= 0;
            valid_stage1 <= 1'b0;
        end else begin
            mult_ar_br_reg <= a_real * b_real;
            mult_ai_bi_reg <= a_imag * b_imag;
            mult_ar_bi_reg <= a_real * b_imag;
            mult_ai_br_reg <= a_imag * b_real;
            valid_stage1 <= valid_in;
        end
    end
    
    // Stage 2: Addition/Subtraction stage
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result_real <= 0;
            result_imag <= 0;
            valid_out <= 1'b0;
        end else begin
            // Complex multiplication: (a + jb)(c + jd) = (ac - bd) + j(ad + bc)
            result_real <= mult_ar_br_reg - mult_ai_bi_reg;
            result_imag <= mult_ar_bi_reg + mult_ai_br_reg;
            valid_out <= valid_stage1;
        end
    end

endmodule