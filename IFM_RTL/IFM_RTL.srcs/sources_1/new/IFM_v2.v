`timescale 1ns / 1ps

module IFM_v2(
    input clk,
    input reset,
    input wire signed [15:00] real_part,     // Sfix_16_15
    input wire signed [15:00] imag_part,     // Sfix_16_15
    input wire data_valid,                   // 1 bit
    input wire envelope,                     // 1 bit
    output wire [63:0] freq2,               // 2-tap frequency estimate
    output wire [63:0] freq4                // 4-tap frequency estimate
    );
    
    // CORDIC latency (22 cycles)
    parameter CORDIC_LATENCY = 22;
    
    // Input pipeline registers
    reg signed [15:00] real_part_d1, real_part_d2, real_part_d3, real_part_d4;
    reg signed [15:00] imag_part_d1, imag_part_d2, imag_part_d3, imag_part_d4;
    reg envelope_d1, envelope_d2, envelope_d3, envelope_d4;
    
    always @(posedge clk) begin
        // Real data pipeline
        real_part_d1 <= real_part;
        real_part_d2 <= real_part_d1;
        real_part_d3 <= real_part_d2;
        real_part_d4 <= real_part_d3;
        
        // Imaginary data pipeline
        imag_part_d1 <= imag_part;
        imag_part_d2 <= imag_part_d1;
        imag_part_d3 <= imag_part_d2;
        imag_part_d4 <= imag_part_d3;
        
        // Envelope pipeline
        envelope_d1 <= envelope;
        envelope_d2 <= envelope_d1;
        envelope_d3 <= envelope_d2;
        envelope_d4 <= envelope_d3;
    end
    
    // Valid signal generation
    reg two_delay, four_delay;
    always @(posedge clk) begin
        two_delay  <= envelope & envelope_d1 & envelope_d2;
        four_delay <= envelope & envelope_d1 & envelope_d2 & envelope_d3 & envelope_d4;
    end
    
    // Correct 2's complement negation
    wire signed [15:0] neg_imag_d2 = -imag_part_d2;
    wire signed [15:0] neg_imag_d4 = -imag_part_d4;
    
    // Complex multiplier outputs
    wire signed [31:00] mult_real_2, mult_imag_2;
    wire signed [31:00] mult_real_4, mult_imag_4;
    
    // Multiplier pipeline registers (3 stages)
    reg [3:0] mult2_valid_pipe = 0;
    reg [3:0] mult4_valid_pipe = 0;
    
    complex_mult #(.WIDTH(16)) COMPLEX_MULT_2_DELAY (
        .clk(clk),
        .a_real(real_part),
        .a_imag(imag_part),
        .b_real(real_part_d2),
        .b_imag(neg_imag_d2),
        .result_real(mult_real_2),
        .result_imag(mult_imag_2)
    );

    complex_mult #(.WIDTH(16)) COMPLEX_MULT_4_DELAY (
        .clk(clk),
        .a_real(real_part),
        .a_imag(imag_part),
        .b_real(real_part_d4),
        .b_imag(neg_imag_d4),
        .result_real(mult_real_4),
        .result_imag(mult_imag_4)
    );
    
    // Multiplier valid pipeline
    always @(posedge clk) begin
        mult2_valid_pipe <= {mult2_valid_pipe[2:0], two_delay};
        mult4_valid_pipe <= {mult4_valid_pipe[2:0], four_delay};
    end
    
    // CORDIC inputs
    reg [63:0] cordic_in2, cordic_in4;
    reg cordic_in2_valid, cordic_in4_valid;
    
    always @(posedge clk) begin
        cordic_in2 <= {mult_imag_2, mult_real_2};
        cordic_in4 <= {mult_imag_4, mult_real_4};
        cordic_in2_valid <= mult2_valid_pipe[3];
        cordic_in4_valid <= mult4_valid_pipe[3];
    end
    
    // CORDIC outputs
    wire [39:0] phase2, phase4;
    wire phase2_valid, phase4_valid;
    
    cordic_0 ATAN2 (
        .aclk(clk),
        .s_axis_cartesian_tvalid(cordic_in2_valid),
        .s_axis_cartesian_tdata(cordic_in2),
        .m_axis_dout_tvalid(phase2_valid),
        .m_axis_dout_tdata(phase2)
    );
    
    cordic_0 ATAN4 (
        .aclk(clk),
        .s_axis_cartesian_tvalid(cordic_in4_valid),
        .s_axis_cartesian_tdata(cordic_in4),
        .m_axis_dout_tvalid(phase4_valid),
        .m_axis_dout_tdata(phase4)
    );
    
    // Phase to frequency conversion
    localparam signed [23:00] t2_constant = 24'sh02fbf2;  // Q11.13
    localparam signed [23:00] t4_constant = 24'sh017df9;  // Q11.13
    
    // Phase valid pipeline (22 stages)
    reg [CORDIC_LATENCY-1:0] phase2_valid_pipe = 0;
    reg [CORDIC_LATENCY-1:0] phase4_valid_pipe = 0;
    
    always @(posedge clk) begin
        phase2_valid_pipe <= {phase2_valid_pipe[CORDIC_LATENCY-2:0], phase2_valid};
        phase4_valid_pipe <= {phase4_valid_pipe[CORDIC_LATENCY-2:0], phase4_valid};
    end
    
    // Frequency calculation
    reg signed [63:0] freq2_calc, freq4_calc;
    always @(posedge clk) begin
        if (phase2_valid) 
            freq2_calc <= $signed(phase2) * t2_constant;
        if (phase4_valid)
            freq4_calc <= $signed(phase4) * t4_constant;
    end
    
    // Accumulation registers
    reg [63:0] total_freq2 = 0, total_freq4 = 0;
    reg [63:0] count2 = 0, count4 = 0;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            total_freq2 <= 0;
            total_freq4 <= 0;
            count2 <= 0;
            count4 <= 0;
        end else begin
            if (phase2_valid_pipe[CORDIC_LATENCY-1]) begin
                total_freq2 <= total_freq2 + freq2_calc;
                count2 <= count2 + 1;
            end
            
            if (phase4_valid_pipe[CORDIC_LATENCY-1]) begin
                total_freq4 <= total_freq4 + freq4_calc;
                count4 <= count4 + 1;
            end
        end
    end
    
    // Frequency estimation outputs
    wire [63:0] freq2_out = (count2 != 0) ? total_freq2 / count2 : 0;
    wire [63:0] freq4_out = (count4 != 0) ? total_freq4 / count4 : 0;
    
    // Output synchronization
    reg [63:0] freq2_reg = 0, freq4_reg = 0;
    always @(posedge clk) begin
        freq2_reg <= freq2_out;
        freq4_reg <= freq4_out;
    end
    
    assign freq2 = freq2_reg;
    assign freq4 = freq4_reg;

endmodule

// Pipelined complex multiplier
module complex_mult #(
    parameter WIDTH = 16
)(
    input clk,
    input signed [WIDTH-1:0] a_real,
    input signed [WIDTH-1:0] a_imag,
    input signed [WIDTH-1:0] b_real,
    input signed [WIDTH-1:0] b_imag,
    output reg signed [2*WIDTH-1:0] result_real,
    output reg signed [2*WIDTH-1:0] result_imag
);
    // Pipeline registers (3 stages)
    reg signed [WIDTH-1:0] ar, ai, br, bi;
    reg signed [2*WIDTH-1:0] p1, p2, p3, p4;
    reg signed [2*WIDTH-1:0] sum_r, sum_i;
    
    always @(posedge clk) begin
        // Stage 1: Input registration
        ar <= a_real;
        ai <= a_imag;
        br <= b_real;
        bi <= b_imag;
        
        // Stage 2: Partial products
        p1 <= ar * br;
        p2 <= ai * bi;
        p3 <= ar * bi;
        p4 <= ai * br;
        
        // Stage 3: Final sums
        sum_r <= p1 - p2;
        sum_i <= p3 + p4;
        
        // Stage 4: Output
        result_real <= sum_r;
        result_imag <= sum_i;
    end
endmodule