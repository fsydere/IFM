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
        
    cordic_0 ATAN2 (
      .s_axis_cartesian_tvalid(two_delay),  // input wire s_axis_cartesian_tvalid
      .s_axis_cartesian_tdata({mult_imag_2,mult_real_2}),    // input wire [63 : 0] s_axis_cartesian_tdata
      .m_axis_dout_tvalid(),            // output wire m_axis_dout_tvalid
      .m_axis_dout_tdata()              // output wire [47 : 0] m_axis_dout_tdata
    );
    
    
endmodule
