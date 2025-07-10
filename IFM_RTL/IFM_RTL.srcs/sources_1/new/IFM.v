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
    output reg       [79:00]  est_freq_2_delay,
    output reg                est_freq_2_delay_valid,
    output reg       [79:00]  est_freq_4_delay,
    output reg                est_freq_4_delay_valid
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
    
    reg two_delay_valid;
    reg four_delay_valid;
    
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
            
            two_delay_valid <= 0;
            four_delay_valid <= 0;
            
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
            
            two_delay_valid   <= envelope & envelope_d1 & envelope_d2;
            four_delay_valid  <= envelope & envelope_d1 & envelope_d2 & envelope_d3 & envelope_d4;
            
            neg_imag_d2 <= ~imag_part_d2 + 1;
            neg_imag_d4 <= ~imag_part_d4 + 1;
            
        end
    end
     
    wire signed [31:00] mult_real_2_delay;
    wire signed [31:00] mult_imag_2_delay;
    wire signed [31:00] mult_real_4_delay;
    wire signed [31:00] mult_imag_4_delay;
    wire mult_out_valid_2_delay;
    wire mult_out_valid_4_delay;
    
    complex_mult #(.WIDTH(16)) COMPLEX_MULT_2_TAP
    (
        .clk(clk),
        .rst_n(rst_n),
        .a_real(real_part_d1),
        .a_imag(imag_part_d1),
        .b_real(real_part_d3),
        .b_imag(neg_imag_d2),
        .valid_in(two_delay_valid),
        .result_real(mult_real_2_delay),
        .result_imag(mult_imag_2_delay),
        .valid_out(mult_out_valid_2_delay)
    );

    complex_mult #(.WIDTH(16)) COMPLEX_MULT_4_TAP
    (
        .clk(clk),
        .rst_n(rst_n),
        .a_real(real_part_d1),
        .a_imag(imag_part_d1),
        .b_real(real_part_d5),
        .b_imag(neg_imag_d4),
        .valid_in(four_delay_valid),
        .result_real(mult_real_4_delay),
        .result_imag(mult_imag_4_delay),
        .valid_out(mult_out_valid_4_delay)
    );
    
    //***************************************************************
    // Delta Phase
    //***************************************************************
    
    wire [15 : 0] delta_phase_2_delay; // signed Q3.13, fix_16_13
    wire [15 : 0] delta_phase_4_delay; // signed Q3.13, fix_16_13
    wire          delta_phase_2_delay_valid;
    wire          delta_phase_4_delay_valid;
    
    cordic_0 DELTA_PHASE_2_TAP (
      .aclk(clk),                                                      
      .s_axis_cartesian_tvalid(mult_out_valid_2_delay),                   
      .s_axis_cartesian_tdata({mult_imag_2_delay,mult_real_2_delay}),       
      .m_axis_dout_tvalid(delta_phase_2_delay_valid),            
      .m_axis_dout_tdata(delta_phase_2_delay)              
    );
    
    cordic_0 DELTA_PHASE_4_TAP (
      .aclk(clk),                                                      
      .s_axis_cartesian_tvalid(mult_out_valid_4_delay),                  
      .s_axis_cartesian_tdata({mult_imag_4_delay,mult_real_4_delay}),        
      .m_axis_dout_tvalid(delta_phase_4_delay_valid),                                           
      .m_axis_dout_tdata(delta_phase_4_delay)              
    );
    
    //***************************************************************
    // Instantaneous Frequency
    //***************************************************************
    
    reg signed [23:00] t2_constant = 24'h02fbf2; 
    reg signed [23:00] t4_constant = 24'h017df9;
    reg signed [39:00] inst_freq_2_delay; 
    reg signed [39:00] inst_freq_4_delay;
    reg inst_freq_2_delay_valid;
    reg inst_freq_2_delay_valid_d1;
    wire inst_freq_2_delay_valid_neg_edge;
    reg inst_freq_4_delay_valid;
    reg inst_freq_4_delay_valid_d1;
    wire inst_freq_4_delay_valid_neg_edge;
    wire divide_valid_2_delay;
    wire divide_valid_4_delay;
    
    always @(posedge clk)
    begin
        if(!rst_n)
        begin
            t2_constant <= 24'h02fbf2;  //Q11.13  Fs/2*pi*delay_size
            t4_constant <= 24'h017df9;  //Q11.13  Fs/2*pi*delay_size
            inst_freq_2_delay <= 0;       //Q14.26
            inst_freq_4_delay <= 0;       //Q14.26
        end
        else begin
            inst_freq_2_delay <= $signed(delta_phase_2_delay) * $signed(t2_constant);
            inst_freq_4_delay <= $signed(delta_phase_4_delay) * $signed(t4_constant);
            
            inst_freq_2_delay_valid <= delta_phase_2_delay_valid;
            inst_freq_4_delay_valid <= delta_phase_4_delay_valid;
            
            inst_freq_2_delay_valid_d1 <= inst_freq_2_delay_valid;
            inst_freq_4_delay_valid_d1 <= inst_freq_4_delay_valid;
        end
    end
    
    assign inst_freq_2_delay_valid_neg_edge = inst_freq_2_delay_valid_d1 & ~inst_freq_2_delay_valid;
    assign inst_freq_4_delay_valid_neg_edge = inst_freq_4_delay_valid_d1 & ~inst_freq_4_delay_valid;
    
    
    //***************************************************************
    // Average Frequency Detection
    //***************************************************************
    
    reg [15:00] avg_2_delay_counter;
    reg signed [63:00] total_2_delay; //Q28.26
    
    reg [15:00] avg_4_delay_counter;
    reg signed [63:00] total_4_delay; //Q28.26
    
    always @(posedge clk)
    begin
        if(!rst_n)
        begin
            avg_2_delay_counter <= 0;       //Q14.26
            avg_4_delay_counter <= 0;       //Q14.26
            total_2_delay <= 0;
            total_4_delay <= 0;
        end
        else begin
            
            if(inst_freq_2_delay_valid)
            begin
                avg_2_delay_counter <= avg_2_delay_counter + 1;       //Q14.26
                total_2_delay <= total_2_delay + inst_freq_2_delay;
            end
            else
            begin
                avg_2_delay_counter <= 0;
                total_2_delay <= 0;
            end
            
            if(inst_freq_4_delay_valid)
            begin
                avg_4_delay_counter <= avg_4_delay_counter + 1;       //Q14.26
                total_4_delay <= total_4_delay + inst_freq_4_delay;
            end
            else
            begin
                avg_4_delay_counter <= 0;
                total_4_delay <= 0;
            end   
        end
    end
    
    wire [79 : 0] avg_freq_2_delay;
    wire avg_freq_2_delay_valid;
    
    assign divide_valid_2_delay = inst_freq_2_delay_valid_neg_edge & (avg_2_delay_counter > 2);
    assign divide_valid_4_delay = inst_freq_4_delay_valid_neg_edge & (avg_2_delay_counter > 4);
    
    div_gen_0 AVG_2_TAP  (
      .aclk(clk),                                      // input wire aclk
      .s_axis_divisor_tvalid(divide_valid_2_delay),    // input wire s_axis_divisor_tvalid
      .s_axis_divisor_tready(),    // output wire s_axis_divisor_tready
      .s_axis_divisor_tdata(avg_2_delay_counter),      // input wire [15 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(divide_valid_2_delay),  // input wire s_axis_dividend_tvalid
      .s_axis_dividend_tready(),  // output wire s_axis_dividend_tready
      .s_axis_dividend_tdata(total_2_delay),    // input wire [63 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(avg_freq_2_delay_valid),          // output wire m_axis_dout_tvalid
      .m_axis_dout_tdata(avg_freq_2_delay)            // output wire [79 : 0] m_axis_dout_tdata  sfix_80_42
    );
    
    wire [79 : 0] avg_freq_4_delay;
    wire avg_freq_4_delay_valid;
    
    div_gen_0 AVG_4_TAP  (
      .aclk(clk),                                      // input wire aclk
      .s_axis_divisor_tvalid(divide_valid_4_delay),    // input wire s_axis_divisor_tvalid
      .s_axis_divisor_tready(),    // output wire s_axis_divisor_tready
      .s_axis_divisor_tdata(avg_4_delay_counter),      // input wire [15 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(divide_valid_4_delay),  // input wire s_axis_dividend_tvalid
      .s_axis_dividend_tready(),  // output wire s_axis_dividend_tready
      .s_axis_dividend_tdata(total_4_delay),    // input wire [63 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(avg_freq_4_delay_valid),          // output wire m_axis_dout_tvalid
      .m_axis_dout_tdata(avg_freq_4_delay)            // output wire [79 : 0] m_axis_dout_tdata  sfix_80_42
    );
        
    always @(posedge clk)
    begin
        if(avg_freq_2_delay_valid)begin
            est_freq_2_delay <= avg_freq_2_delay;
        end
        if(avg_freq_4_delay_valid)begin
            est_freq_4_delay <= avg_freq_4_delay;
        end
        
        est_freq_4_delay_valid <= avg_freq_4_delay_valid;
        est_freq_2_delay_valid <= avg_freq_2_delay_valid;
    end

endmodule
