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
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IFM(
    input clk,
    input wire signed [15:00] real_part,            //Sfix_16_15
    input wire signed [15:00] imag_part,            //Sfix_16_15
    input wire                data_valid,           //1 bit
    input wire                envelope,                      //1 bit
    output wire freq
    );
    
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
    
    always @(posedge clk)
    begin
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
    
    assign two_delay = envelope & envelope_d1 & envelope_d2;
    assign four_delay = envelope & envelope_d1 & envelope_d2 & envelope_d3 & envelope_d4;
    
    wire [15:0] neg_imag_d2 = ~imag_part_d2 + 1;
    wire [15:0] neg_imag_d4 = ~imag_part_d4 + 1;
    
    wire signed [31:00] mult_real_2;
    wire signed [31:00] mult_imag_2;
    wire signed [31:00] mult_real_4;
    wire signed [31:00] mult_imag_4;
       
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
    
    
    wire signed [15:00] phase2;
    wire signed [15:00] phase4;
    wire phase2_valid;
    wire phase4_valid;
        
    cordic_0 ATAN2 (
      .aclk(clk),                                        // input wire aclk
      .s_axis_cartesian_tvalid(two_delay),  // input wire s_axis_cartesian_tvalid
      .s_axis_cartesian_tdata({mult_imag_2,mult_real_2}),    // input wire [63 : 0] s_axis_cartesian_tdata
      .m_axis_dout_tvalid(phase2_valid),            // output wire m_axis_dout_tvalid
      .m_axis_dout_tdata(phase2)              // output wire [39 : 0] m_axis_dout_tdata
    );
    
    cordic_0 ATAN4 (
      .aclk(clk),                                        // input wire aclk
      .s_axis_cartesian_tvalid(four_delay),  // input wire s_axis_cartesian_tvalid
      .s_axis_cartesian_tdata({mult_imag_4,mult_real_4}),    // input wire [63 : 0] s_axis_cartesian_tdata
      .m_axis_dout_tvalid(phase4_valid),            // output wire m_axis_dout_tvalid
      .m_axis_dout_tdata(phase4)              // output wire [39 : 0] m_axis_dout_tdata
    );
    
    reg [39:00] freq2 = 0;   //Q14.26
    reg [39:00] freq4 = 0;   //Q14.26
    
    reg signed [23:00] t2_constant = 24'h02fbf2; //Q11.13
    reg signed [23:00] t4_constant = 24'h017df9; //Q11.13
    
    always @(phase2)
        freq2 = $signed(phase2) * $signed(t2_constant); // Q3.13 * Q11.13 = Q14.26
        
    always @(phase4)
        freq4 = $signed(phase4) * $signed(t4_constant); // Q3.13 * Q11.13 = Q14.26
    
    reg [63:00] total_freq2  = 0;
    reg [63:00] total_freq4  = 0;
    
    reg [63:00] freq2_counter = 0;
    reg [63:00] freq4_counter = 0;
    
    always @(posedge clk)
        if(phase2_valid)
            freq2_counter <= freq2_counter + 1;
            
    always @(posedge clk)
        if(phase4_valid)
            freq4_counter <= freq4_counter + 1;
            
    always @(phase2_valid)
        total_freq2 <= total_freq2 + freq2;
    
    always @(phase4_valid)
        total_freq4 <= total_freq4 + freq4;
    
    wire [63:00] est_freq2 = 0;   
    wire [63:00] est_freq4 = 0;    
    
    assign est_freq2 = total_freq2 / (freq2_counter<<13);
    assign est_freq4 = total_freq4 / (freq4_counter<<13);
        
endmodule
