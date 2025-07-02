`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2025 14:56:22
// Design Name: 
// Module Name: ThresholdDetector
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


module envelope_generator(
    input                     clk,                          //300MHz
    input                     reset,                        //
    input wire signed [15:00] real_part,                    //Sfix_16_15
    input wire signed [15:00] imag_part,                    //Sfix_16_15
    input wire                data_valid,

    output reg signed [15:00] real_part_delayed,            //Sfix_16_15
    output reg signed [15:00] imag_part_delayed,            //Sfix_16_15
    output reg                data_valid_delayed,           //1 bit
    output wire               envelope                      //1 bit
    );
    
    reg [15:00] noise_sample_counter = 0;
    reg [00:00] noise_sample_done = 0;
    reg [00:00] noise_sample_done_d1 = 0;
    reg [00:00] data_valid_d1 = 0;
    reg [00:00] data_valid_d2 = 0;
    reg [00:00] make_avarage = 0;
    reg signed [47:00] threshold = 0;
    reg threshold_calculated = 0;

    reg signed [15:00] real_part_d1;
    reg signed [15:00] real_part_d2;
    reg signed [15:00] imag_part_d1;
    reg signed [15:00] imag_part_d2;
    
    always@(posedge clk)
    begin
    
        if(data_valid && noise_sample_counter != 16'd30000 - 1)
            noise_sample_counter <= noise_sample_counter + 1'b1;
        if(noise_sample_counter == 16'd30000 - 1)
            noise_sample_done <= 1'b1;  
            
        data_valid_d1 <= data_valid;
        data_valid_d2 <= data_valid_d1;
        data_valid_delayed <= data_valid_d1;
        noise_sample_done_d1 <= noise_sample_done;    
        make_avarage  <= noise_sample_done & ~noise_sample_done_d1;
        
        real_part_d1 <= real_part;
        real_part_d2 <= real_part_d1;
        imag_part_d1 <= imag_part;
        imag_part_d2 <= imag_part_d1;
        real_part_delayed <= real_part_d2;
        imag_part_delayed <= imag_part_d2;
        
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
    reg [31:0] sum_squares_d1 = 0;
    always @(posedge clk) begin
        sum_squares <= square_real + square_imag;
        sum_squares_d1 <= sum_squares;
    end
    
    // Controlled accumulation
    reg [47:0] total_sum = 0;  // 49-bit for overflow
    always @(posedge clk) begin
        if (data_valid_d1)
            total_sum <= total_sum + sum_squares;
    end
    
    // Pipelined division (combinational division replaced)
    always @(posedge clk) begin
        if (make_avarage)begin
            threshold <= (total_sum * 4 / 30000);
            threshold_calculated <= 1;
        end
    end
    
    assign envelope = (sum_squares_d1 >= threshold && threshold_calculated) ? 1'b1 : 1'b0;
   
    
endmodule