`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.07.2025 21:37:31
// Design Name: 
// Module Name: ModelComposer_Top
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


module ModelComposer_Top(
    input clk,
    input wire signed [15:0]    RealPart,  //Sfix_16_15
    input wire signed [15:0]    ImagPart,  //Sfix_16_15
    input wire                  dataValid,
    output wire                 estimated_frequency_2_delay_valid,
    output wire signed [81 : 0] estimated_frequency_2_delay,  //Sfix_81_18
    output wire                 estimated_frequency_4_delay_valid,
    output wire signed [81 : 0] estimated_frequency_4_delay   //Sfix_81_18
    );
    
    IFM_0 MC_IFM (
      .datavalid(dataValid),                                                    // input wire [0 : 0] datavalid
      .imagpart(ImagPart),                                                      // input wire [15 : 0] imagpart
      .realpart(RealPart),                                                      // input wire [15 : 0] realpart
      .clk(clk),                                                                // input wire clk
      .estimated_frequency_2_delay(estimated_frequency_2_delay),                // output wire [81 : 0] estimated_frequency_2_delay
      .estimated_frequency_4_delay(estimated_frequency_4_delay),                // output wire [81 : 0] estimated_frequency_4_delay
      .estimated_frequency_2_delay_valid(estimated_frequency_2_delay_valid),    // output wire [0 : 0] estimated_frequency_2_delay_valid
      .estimated_frequency_4_delay_valid(estimated_frequency_4_delay_valid)     // output wire [0 : 0] estimated_frequency_4_delay_valid
    );
endmodule
