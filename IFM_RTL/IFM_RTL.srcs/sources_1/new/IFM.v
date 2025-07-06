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
    input rst_n,
    input wire signed [15:00] real_part,            //Sfix_16_15
    input wire signed [15:00] imag_part,            //Sfix_16_15
    input wire                data_valid,           //1 bit
    input wire                envelope,                      //1 bit
    output reg       [79:00]  est_freq_2_tap,
    output wire               est_freq_2_tap_valid,
    output reg       [79:00]  est_freq_4_tap,
    output wire               est_freq_4_tap_valid
    );
    
    reg signed [15:00] real_part_d1;
    reg signed [15:00] real_part_d2;
    reg signed [15:00] real_part_d3;
    reg signed [15:00] real_part_d4;
    reg signed [15:00] real_part_d5;
    
    reg signed [15:00] imag_part_d1;
    reg signed [15:00] imag_part_d2;
    reg signed [15:00] imag_part_d3;
    reg signed [15:00] imag_part_d4;
    reg signed [15:00] imag_part_d5;
    
    reg envelope_d1;
    reg envelope_d2;
    reg envelope_d3;
    reg envelope_d4;
    
    reg two_tap_valid;
    reg four_tap_valid;
    
    reg [15:0] neg_imag_d2;
    reg [15:0] neg_imag_d4;
    
    always @(posedge clk)
    begin
        if(!rst_n)
        begin
            real_part_d1 <= 0;
            real_part_d2 <= 0;
            real_part_d3 <= 0;
            real_part_d4 <= 0;
            real_part_d5 <= 0;
            
            imag_part_d1 <= 0;
            imag_part_d2 <= 0;
            imag_part_d3 <= 0;
            imag_part_d4 <= 0;
            imag_part_d4 <= 0;
            
            envelope_d1 <= 0;
            envelope_d2 <= 0;
            envelope_d3 <= 0;
            
            two_tap_valid <= 0;
            four_tap_valid <= 0;
            
            neg_imag_d2 <= 0;
            neg_imag_d4 <= 0;
        end
        else begin
            real_part_d1 <= real_part;
            real_part_d2 <= real_part_d1;
            real_part_d3 <= real_part_d2;
            real_part_d4 <= real_part_d3;
            real_part_d5 <= real_part_d4;
            
            imag_part_d1 <= imag_part;
            imag_part_d2 <= imag_part_d1;
            imag_part_d3 <= imag_part_d2;
            imag_part_d4 <= imag_part_d3;
            imag_part_d5 <= imag_part_d4;
            
            envelope_d1 <= envelope;
            envelope_d2 <= envelope_d1;
            envelope_d3 <= envelope_d2;
            envelope_d4 <= envelope_d3;
            
            two_tap_valid   <= envelope & envelope_d1 & envelope_d2;
            four_tap_valid  <= envelope & envelope_d1 & envelope_d2 & envelope_d3 & envelope_d4;
            
            neg_imag_d2 <= ~imag_part_d2 + 1;
            neg_imag_d4 <= ~imag_part_d4 + 1;
        end
    end
     
    wire signed [31:00] mult_real_2_tap;
    wire signed [31:00] mult_imag_2_tap;
    wire signed [31:00] mult_real_4_tap;
    wire signed [31:00] mult_imag_4_tap;
    wire mult_out_valid_2_tap;
    wire mult_out_valid_4_tap;
    
    complex_mult #(.WIDTH(16)) COMPLEX_MULT_2_TAP
    (
        .clk(clk),
        .rst_n(rst_n),
        .a_real(real_part_d1),
        .a_imag(imag_part_d1),
        .b_real(real_part_d3),
        .b_imag(neg_imag_d2),
        .valid_in(two_tap_valid),
        .result_real(mult_real_2_tap),
        .result_imag(mult_imag_2_tap),
        .valid_out(mult_out_valid_2_tap)
    );

    complex_mult #(.WIDTH(16)) COMPLEX_MULT_4_TAP
    (
        .clk(clk),
        .rst_n(rst_n),
        .a_real(real_part_d1),
        .a_imag(imag_part_d1),
        .b_real(real_part_d5),
        .b_imag(neg_imag_d4),
        .valid_in(four_tap_valid),
        .result_real(mult_real_4_tap),
        .result_imag(mult_imag_4_tap),
        .valid_out(mult_out_valid_4_tap)
    );
    
    //***************************************************************
    // Delta Phase
    //***************************************************************
    
    wire [15 : 0] delta_phase_2_tap; // signed Q3.13, fix_16_13
    wire [15 : 0] delta_phase_4_tap; // signed Q3.13, fix_16_13
    wire          delta_phase_2_tap_valid;
    wire          delta_phase_4_tap_valid;
    
    cordic_0 DELTA_PHASE_2_TAP (
      .aclk(clk),                                                      
      .s_axis_cartesian_tvalid(mult_out_valid_2_tap),                   
      .s_axis_cartesian_tdata({mult_imag_2_tap,mult_real_2_tap}),       
      .m_axis_dout_tvalid(delta_phase_2_tap_valid),            
      .m_axis_dout_tdata(delta_phase_2_tap)              
    );
    
    cordic_0 DELTA_PHASE_4_TAP (
      .aclk(clk),                                                      
      .s_axis_cartesian_tvalid(mult_out_valid_4_tap),                  
      .s_axis_cartesian_tdata({mult_imag_4_tap,mult_real_4_tap}),        
      .m_axis_dout_tvalid(delta_phase_4_tap_valid),                                           
      .m_axis_dout_tdata(delta_phase_4_tap)              
    );
    
    //***************************************************************
    // Instantaneous Frequency
    //***************************************************************
    
    reg signed [23:00] t2_constant = 24'h02fbf2; 
    reg signed [23:00] t4_constant = 24'h017df9;
    reg signed [39:00] inst_freq_2_tap; 
    reg signed [39:00] inst_freq_4_tap;
    reg inst_freq_2_tap_valid;
    reg inst_freq_2_tap_valid_d1;
    wire inst_freq_2_tap_valid_neg_edge;
    reg inst_freq_4_tap_valid;
    reg inst_freq_4_tap_valid_d1;
    wire inst_freq_4_tap_valid_neg_edge;
    
    
    always @(posedge clk)
    begin
        if(!rst_n)
        begin
            t2_constant <= 24'h02fbf2;  //Q11.13  Fs/2*pi*tap_size
            t4_constant <= 24'h017df9;  //Q11.13  Fs/2*pi*tap_size
            inst_freq_2_tap <= 0;       //Q14.26
            inst_freq_4_tap <= 0;       //Q14.26
        end
        else begin
            inst_freq_2_tap <= $signed(delta_phase_2_tap) * $signed(t2_constant);
            inst_freq_4_tap <= $signed(delta_phase_4_tap) * $signed(t4_constant);
            
            inst_freq_2_tap_valid <= delta_phase_2_tap_valid;
            inst_freq_4_tap_valid <= delta_phase_4_tap_valid;
            
            inst_freq_2_tap_valid_d1 <= inst_freq_2_tap_valid;
            inst_freq_4_tap_valid_d1 <= inst_freq_4_tap_valid;
        end
    end
    
    assign inst_freq_2_tap_valid_neg_edge = inst_freq_2_tap_valid_d1 & ~inst_freq_2_tap_valid;
    assign inst_freq_4_tap_valid_neg_edge = inst_freq_4_tap_valid_d1 & ~inst_freq_4_tap_valid;
    
    //***************************************************************
    // Average Frequency Detection
    //***************************************************************
    
    reg [15:00] avg_2_tap_counter;
    reg signed [63:00] total_2_tap; //Q28.26
    
    reg [15:00] avg_4_tap_counter;
    reg signed [63:00] total_4_tap; //Q28.26
    
    always @(posedge clk)
    begin
        if(!rst_n)
        begin
            avg_2_tap_counter <= 0;       //Q14.26
            avg_4_tap_counter <= 0;       //Q14.26
            total_2_tap <= 0;
            total_4_tap <= 0;
        end
        else begin
            
            if(inst_freq_2_tap_valid)
            begin
                avg_2_tap_counter <= avg_2_tap_counter + 1;       //Q14.26
                total_2_tap <= total_2_tap + inst_freq_2_tap;
            end
            else
            begin
                avg_2_tap_counter <= 0;
                total_2_tap <= 0;
            end
            
            if(inst_freq_4_tap_valid)
            begin
                avg_4_tap_counter <= avg_4_tap_counter + 1;       //Q14.26
                total_4_tap <= total_4_tap + inst_freq_4_tap;
            end
            else
            begin
                avg_4_tap_counter <= 0;
                total_4_tap <= 0;
            end   
        end
    end
    
    wire [79 : 0] avg_freq_2_tap;
    wire avg_freq_2_tap_valid;
    
    div_gen_0 AVG_2_TAP  (
      .aclk(clk),                                      // input wire aclk
      .s_axis_divisor_tvalid(inst_freq_2_tap_valid_neg_edge),    // input wire s_axis_divisor_tvalid
      .s_axis_divisor_tready(),    // output wire s_axis_divisor_tready
      .s_axis_divisor_tdata(avg_2_tap_counter),      // input wire [15 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(inst_freq_2_tap_valid_neg_edge),  // input wire s_axis_dividend_tvalid
      .s_axis_dividend_tready(),  // output wire s_axis_dividend_tready
      .s_axis_dividend_tdata(total_2_tap),    // input wire [63 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(avg_freq_2_tap_valid),          // output wire m_axis_dout_tvalid
      .m_axis_dout_tdata(avg_freq_2_tap)            // output wire [79 : 0] m_axis_dout_tdata  fix_80_42
    );
    
    wire [79 : 0] avg_freq_4_tap;
    wire avg_freq_4_tap_valid;
    
    div_gen_0 AVG_4_TAP  (
      .aclk(clk),                                      // input wire aclk
      .s_axis_divisor_tvalid(inst_freq_4_tap_valid_neg_edge),    // input wire s_axis_divisor_tvalid
      .s_axis_divisor_tready(),    // output wire s_axis_divisor_tready
      .s_axis_divisor_tdata(avg_4_tap_counter),      // input wire [15 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(inst_freq_4_tap_valid_neg_edge),  // input wire s_axis_dividend_tvalid
      .s_axis_dividend_tready(),  // output wire s_axis_dividend_tready
      .s_axis_dividend_tdata(total_4_tap),    // input wire [63 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(avg_freq_4_tap_valid),          // output wire m_axis_dout_tvalid
      .m_axis_dout_tdata(avg_freq_4_tap)            // output wire [79 : 0] m_axis_dout_tdata  fix_80_42
    );
    
    assign est_freq_2_tap_valid = avg_freq_2_tap_valid;
    assign est_freq_4_tap_valid = avg_freq_4_tap_valid;
    
    always @(posedge clk)
    begin
        if(avg_freq_2_tap_valid)
            est_freq_2_tap <= avg_freq_2_tap;
        if(avg_freq_4_tap_valid)
            est_freq_4_tap <= avg_freq_4_tap;
    end

endmodule
