`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2025 14:56:22
// Design Name: 
// Module Name: TopModule_IFM
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


module TopModule_IFM(
    input clk,
    input rst_n,
    input wire signed [15:0] RealPart,  //Sfix_16_15
    input wire signed [15:0] ImagPart,  //Sfix_16_15
    input wire dataValid,
    output wire signed [15:0] EstimatedFrequency,
    output wire outputValid
    );
    
    wire signed [15:00] real_part;            //Sfix_16_15
    wire signed [15:00] imag_part;            //Sfix_16_15
    wire                data_valid;           //1 bit
    wire                envelope;                     //1 bit
    
    
    envelope_generator ENVELOPE_GENERATOR
    (
        .clk                (clk),   
        .real_part          (RealPart),   
        .imag_part          (ImagPart),   
        .data_valid         (dataValid),
       
        .real_part_delayed  (real_part),   
        .imag_part_delayed  (imag_part),   
        .data_valid_delayed (data_valid),   
        .envelope           (envelope)           
    );
    
    
    IFM IFM(
       .clk                 (clk),
       .rst_n               (rst_n),
       .real_part           (real_part),            //Sfix_16_15
       .imag_part           (imag_part),            //Sfix_16_15
       .data_valid          (data_valid),           //1 bit
       .envelope            (envelope)              //1 bit
       //outputs
    );
    
//    IFM_v2 IFM(
//       .clk                 (clk),
//       .real_part           (real_part),            //Sfix_16_15
//       .imag_part           (imag_part),            //Sfix_16_15
//       .data_valid          (data_valid),           //1 bit
//       .envelope            (envelope)                      //1 bit
//    );
    
    
    
endmodule
