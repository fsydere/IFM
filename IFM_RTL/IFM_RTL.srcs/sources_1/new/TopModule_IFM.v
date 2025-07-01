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
    input wire signed [15:0] RealPart,  //Sfix_16_15
    input wire signed [15:0] ImagPart,  //Sfix_16_15
    input wire dataValid,
    output wire signed [15:0] EstimatedFrequency,
    output wire outputValid
    );
    
    ThresholdDetector THRESHOLD_DETECTOR
    (
    
    );
    
    EnvelopeDetector ENVELOPE_DETECTOR(
    
    );
    
    IFM IFM(
    
    );
    
    
    
endmodule
