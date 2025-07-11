`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2025 15:46:49
// Design Name: 
// Module Name: ThresholdDetector_tb
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


module ThresholdDetector_tb();

    reg clk;
    reg rst_n;
    reg signed [15:0] RealPart;
    reg signed [15:0] ImagPart;
    reg DataValid;
    reg start;
    wire ThresholdCalculated;
    
//    // Instantiate DUT
//    envelope_generator dut (
//        .clk(clk),
//        .real_part(RealPart),
//        .imag_part(ImagPart),
//        .data_valid(DataValid)
//        // outputs
//    );

    TopModule_IFM DUT
    (
    .clk(clk),
    .rst_n(rst_n),             
    .RealPart(RealPart),  
    .ImagPart(ImagPart),  
    .dataValid(DataValid) 
    );
    
    ModelComposer_Top DUT2
    (
    .clk(clk),
    .RealPart(RealPart),  
    .ImagPart(ImagPart),  
    .dataValid(DataValid) 
    );
    
    
    // Clock generation: 300 MHz => 3.333 ns period
    realtime half_period = 1.66666667;
    initial begin
        clk = 0;
        forever #half_period clk = ~clk;
    end
    
    // Test variables
    integer file, status;
    integer file2, status2;
 
    // Read file and apply stimuli
    initial begin
        // Initialize inputs
        RealPart = 0;
        ImagPart = 0;
        DataValid = 0;
        start = 0;
        rst_n = 0;
        // Open data file
        file = $fopen("../../../../../SystemInputs/Fs_300_Fc_25MHz_PW_10us_PRI_100us_SNR_10dB_real.txt", "r");
        file2 = $fopen("../../../../../SystemInputs/Fs_300_Fc_25MHz_PW_10us_PRI_100us_SNR_10dB_imag.txt", "r");
//        file = $fopen("../../../../../SystemInputs/Fs_300_Fc_25MHz_PW_10us_PRI_100us_SNR_20dB_real.txt", "r");
//        file2 = $fopen("../../../../../SystemInputs/Fs_300_Fc_25MHz_PW_10us_PRI_100us_SNR_20dB_imag.txt", "r");
//        file = $fopen("../../../../../SystemInputs/Fs_300_Fc_25MHz_PW_10us_PRI_100us_SNR_40dB_real.txt", "r");
//        file2 = $fopen("../../../../../SystemInputs/Fs_300_Fc_25MHz_PW_10us_PRI_100us_SNR_40dB_imag.txt", "r");
        if (file == 0) begin
            $display("Error: Could not open input_data.txt");
            $finish;
        end
    
        // Reset sequence
        #20;
        start = 1;
        rst_n = 1;
    end
    
    always @(posedge clk) begin
        if (rst_n) begin
            if (!$feof(file)) begin
                status = $fscanf(file, "%d\n", RealPart);
                status2 = $fscanf(file2, "%d\n", ImagPart);
                DataValid <= 1;  // Validate only if 2 values read
            end
            else begin
                DataValid <= 0;
                $fclose(file);
                $fclose(file2);
                $finish;
            end
        end
        else begin
            DataValid <= 0;  // Keep invalid during reset
        end
    end
    
endmodule
