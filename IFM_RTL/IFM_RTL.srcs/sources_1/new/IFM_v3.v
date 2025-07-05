`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2025 14:56:22
// Design Name: 
// Module Name: IFM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Fixed IFM module for instantaneous frequency measurement
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Fixed synthesis and logic issues
// 
//////////////////////////////////////////////////////////////////////////////////

module IFM_v3(
    input clk,
    input wire signed [15:00] real_part,            //Sfix_16_15
    input wire signed [15:00] imag_part,            //Sfix_16_15
    input wire                data_valid,           //1 bit
    input wire                envelope,             //1 bit
    output reg signed [31:0]  freq2_out,            //2-delay frequency estimate
    output reg signed [31:0]  freq4_out             //4-delay frequency estimate
    );
    
    // Delay line registers
    reg signed [15:00] real_part_d1;
    reg signed [15:00] real_part_d2;
    reg signed [15:00] real_part_d3;
    reg signed [15:00] real_part_d4;
    
    reg signed [15:00] imag_part_d1;
    reg signed [15:00] imag_part_d2;
    reg signed [15:00] imag_part_d3;
    reg signed [15:00] imag_part_d4;
    
    reg envelope_d1;
    reg envelope_d2;
    reg envelope_d3;
    reg envelope_d4;
    
    // Create delay line
    always @(posedge clk) begin
        real_part_d1 <= real_part;
        real_part_d2 <= real_part_d1;
        real_part_d3 <= real_part_d2;
        real_part_d4 <= real_part_d3;
        
        imag_part_d1 <= imag_part;
        imag_part_d2 <= imag_part_d1;
        imag_part_d3 <= imag_part_d2;
        imag_part_d4 <= imag_part_d3;
        
        envelope_d1 <= envelope;
        envelope_d2 <= envelope_d1;
        envelope_d3 <= envelope_d2;
        envelope_d4 <= envelope_d3;
    end
    
    // Fixed: Added wire declarations
    wire two_delay;
    wire four_delay;
    
    assign two_delay = envelope & envelope_d1 & envelope_d2;
    assign four_delay = envelope & envelope_d1 & envelope_d2 & envelope_d3 & envelope_d4;
    
    // Create conjugate (negate imaginary part)
    wire signed [15:0] neg_imag_d2 = ~imag_part_d2 + 1;
    wire signed [15:0] neg_imag_d4 = ~imag_part_d4 + 1;
    
    // Complex multiplication results
    wire signed [31:00] mult_real_2;
    wire signed [31:00] mult_imag_2;
    wire signed [31:00] mult_real_4;
    wire signed [31:00] mult_imag_4;
       
    // Complex multipliers for correlation
    complex_mult #(.WIDTH(16)) COMPLEX_MULT_2_DELAY
    (
        .a_real(real_part),
        .a_imag(imag_part),
        .b_real(real_part_d2),
        .b_imag(neg_imag_d2),
        .result_real(mult_real_2),
        .result_imag(mult_imag_2)
    );

    complex_mult #(.WIDTH(16)) COMPLEX_MULT_4_DELAY
    (
        .a_real(real_part),
        .a_imag(imag_part),
        .b_real(real_part_d4),
        .b_imag(neg_imag_d4),
        .result_real(mult_real_4),
        .result_imag(mult_imag_4)
    );
    
    // Phase calculation outputs
    wire signed [15:00] phase2;
    wire signed [15:00] phase4;
    wire phase2_valid;
    wire phase4_valid;
        
    // CORDIC modules for phase calculation
    cordic_0 ATAN2 (
      .aclk(clk),                                        
      .s_axis_cartesian_tvalid(two_delay),  
      .s_axis_cartesian_tdata({mult_imag_2,mult_real_2}),    
      .m_axis_dout_tvalid(phase2_valid),            
      .m_axis_dout_tdata(phase2)              
    );
    
    cordic_0 ATAN4 (
      .aclk(clk),                                        
      .s_axis_cartesian_tvalid(four_delay),  
      .s_axis_cartesian_tdata({mult_imag_4,mult_real_4}),    
      .m_axis_dout_tvalid(phase4_valid),            
      .m_axis_dout_tdata(phase4)              
    );
    
    // Fixed: Made these registers and used proper clocked logic
    reg signed [39:00] freq2;   //Q14.26
    reg signed [39:00] freq4;   //Q14.26
    
    // Frequency conversion constants
    reg signed [23:00] t2_constant = 24'h02fbf2; //Q11.13
    reg signed [23:00] t4_constant = 24'h017df9; //Q11.13
    
    // Fixed: Use clocked always blocks
    always @(posedge clk) begin
        if(phase2_valid)
            freq2 <= $signed(phase2) * $signed(t2_constant); // Q3.13 * Q11.13 = Q14.26
        else
            freq2 <= freq2; // Hold previous value
    end
        
    always @(posedge clk) begin
        if(phase4_valid)
            freq4 <= $signed(phase4) * $signed(t4_constant); // Q3.13 * Q11.13 = Q14.26
        else
            freq4 <= freq4; // Hold previous value
    end
    
    // Accumulation registers
    reg signed [63:00] total_freq2;
    reg signed [63:00] total_freq4;
    
    reg [31:00] freq2_counter;
    reg [31:00] freq4_counter;
    
    // Fixed: Proper clocked logic for counters
    always @(posedge clk) begin
        if(phase2_valid)
            freq2_counter <= freq2_counter + 1;
    end
            
    always @(posedge clk) begin
        if(phase4_valid)
            freq4_counter <= freq4_counter + 1;
    end
    
    // Fixed: Proper clocked logic for accumulation        
    always @(posedge clk) begin
        if(phase2_valid)
            total_freq2 <= total_freq2 + freq2;
    end
    
    always @(posedge clk) begin
        if(phase4_valid)
            total_freq4 <= total_freq4 + freq4;
    end
    
    // Fixed: Removed conflicting initialization, added division by zero protection
    wire signed [63:00] est_freq2;   
    wire signed [63:00] est_freq4;    
    
    assign est_freq2 = (freq2_counter > 0) ? (total_freq2 / (freq2_counter << 13)) : 64'h0;
    assign est_freq4 = (freq4_counter > 0) ? (total_freq4 / (freq4_counter << 13)) : 64'h0;
    
    // Fixed: Added logic to assign separate frequency outputs
    always @(posedge clk) begin
        if(freq2_counter > 10)  // Wait for some samples for stability
            freq2_out <= est_freq2[31:0];  // Take lower 32 bits
        else
            freq2_out <= 32'h0;  // No valid estimate yet
    end
    
    always @(posedge clk) begin
        if(freq4_counter > 10)  // Wait for some samples for stability
            freq4_out <= est_freq4[31:0];  // Take lower 32 bits
        else
            freq4_out <= 32'h0;  // No valid estimate yet
    end
        
endmodule