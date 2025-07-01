`timescale 1ns / 1ps

module threshold_detector(
    input clk,                          //300MHz
    input reset,                        //
    input wire signed [15:00] real_part,  //Sfix_16_15
    input wire signed [15:00] imag_part,  //Sfix_16_15
    output wire signed [47:00] threshold,  //Sfix_48_30
    input wire data_valid,
    output wire threshold_calculated
    );
    
    reg [15:00] noise_sample_counter = 0;
    reg [00:00] noise_sample_done = 0;
    reg [00:00] noise_sample_done_reg1 = 0;
    reg [00:00] data_valid_reg = 0;
    reg [00:00] make_avarage = 0;
    reg signed [47:00] threshold_reg = 0;
    reg threshold_calculated_reg = 0;
    
    always@(posedge clk)
    begin
        if(data_valid && noise_sample_counter != 16'd30000 - 1)
            noise_sample_counter <= noise_sample_counter + 1'b1;
        if(noise_sample_counter == 16'd30000 - 1)
            noise_sample_done <= 1'b1;  
        
        noise_sample_done_reg1 <= noise_sample_done;    
        data_valid_reg <= data_valid;
        make_avarage  <= noise_sample_done & ~noise_sample_done_reg1;
    end
    
    // Pipeline stage 1: Square calculation
    reg [31:0] square_real = 0;
    reg [31:0] square_imag = 0;
    always @(posedge clk) begin
        square_real <= real_part * real_part;
        square_imag <= imag_part * imag_part;
    end
    
    // Pipeline stage 2: Sum of squares
    reg [31:0] sum_squares = 0;
    always @(posedge clk) begin
        sum_squares <= square_real + square_imag;
    end
    
    // Controlled accumulation
    reg [47:0] total_sum = 0;  // 49-bit for overflow
    always @(posedge clk) begin
        if (data_valid_reg)
            total_sum <= total_sum + sum_squares;
    end
    
    // Pipelined division (combinational division replaced)
    always @(posedge clk) begin
        if (make_avarage)begin
            threshold_reg <= (total_sum / 30000) + 48'h0000FEC9E0FB;  // Synthesizable constant division + 4db in linear
            threshold_calculated_reg <= 1;
        end
    end
    
    assign threshold = threshold_reg;
    assign threshold_calculated = threshold_calculated_reg;
    
endmodule