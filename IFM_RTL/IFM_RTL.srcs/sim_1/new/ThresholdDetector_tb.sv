`timescale 1ns / 1ps
//`default_nettype none
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
    
    reg signed [15:0] RealPart_10dB, ImagPart_10dB;
    reg signed [15:0] RealPart_20dB, ImagPart_20dB;
    reg signed [15:0] RealPart_40dB, ImagPart_40dB;
    
    reg DataValid_10dB, DataValid_20dB, DataValid_40dB;

    TopModule_IFM DUT_10dB (
        .clk(clk),
        .rst_n(rst_n),
        .RealPart(RealPart_10dB),
        .ImagPart(ImagPart_10dB),
        .dataValid(DataValid_10dB)
    );
    
    ModelComposer_Top MC_DUT_10dB (
        .clk(clk),
        .RealPart(RealPart_10dB),
        .ImagPart(ImagPart_10dB),
        .dataValid(DataValid_10dB)
    );
    
    TopModule_IFM DUT_20dB (
        .clk(clk),
        .rst_n(rst_n),
        .RealPart(RealPart_20dB),
        .ImagPart(ImagPart_20dB),
        .dataValid(DataValid_20dB)
    );
    
    ModelComposer_Top MC_DUT_20dB (
        .clk(clk),
        .RealPart(RealPart_20dB),
        .ImagPart(ImagPart_20dB),
        .dataValid(DataValid_20dB)
    );
    
    TopModule_IFM DUT_40dB (
        .clk(clk),
        .rst_n(rst_n),
        .RealPart(RealPart_40dB),
        .ImagPart(ImagPart_40dB),
        .dataValid(DataValid_40dB)
    );
    
    ModelComposer_Top MC_DUT_40dB (
        .clk(clk),
        .RealPart(RealPart_40dB),
        .ImagPart(ImagPart_40dB),
        .dataValid(DataValid_40dB)
    );

    // Clock generation: 300 MHz => 3.333 ns period
    realtime half_period = 1.66666667;
    initial begin
        clk = 0;
        forever #half_period clk = ~clk;
    end

    // File handles and status
    integer file_RealPart_10dB, status_RealPart_10dB;
    integer file_ImagPart_10dB, status_ImagPart_10dB;
    integer file_RealPart_20dB, status_RealPart_20dB;
    integer file_ImagPart_20dB, status_ImagPart_20dB;
    integer file_RealPart_40dB, status_RealPart_40dB;
    integer file_ImagPart_40dB, status_ImagPart_40dB;

    reg done_10dB = 0, done_20dB = 0, done_40dB = 0;

    initial begin
        // Initialize signals
        RealPart_10dB = 0; ImagPart_10dB = 0; DataValid_10dB = 0;
        RealPart_20dB = 0; ImagPart_20dB = 0; DataValid_20dB = 0;
        RealPart_40dB = 0; ImagPart_40dB = 0; DataValid_40dB = 0;

        rst_n = 0;

        // Open input files
        file_RealPart_10dB = $fopen("../../../../../System_Inputs/Fs_300MHz_Fc_25MHz_PW_10us_PRI_100us_SNR_10dB_real.txt", "r");
        file_ImagPart_10dB = $fopen("../../../../../System_Inputs/Fs_300MHz_Fc_25MHz_PW_10us_PRI_100us_SNR_10dB_imag.txt", "r");
        file_RealPart_20dB = $fopen("../../../../../System_Inputs/Fs_300MHz_Fc_25MHz_PW_10us_PRI_100us_SNR_20dB_real.txt", "r");
        file_ImagPart_20dB = $fopen("../../../../../System_Inputs/Fs_300MHz_Fc_25MHz_PW_10us_PRI_100us_SNR_20dB_imag.txt", "r");
        file_RealPart_40dB = $fopen("../../../../../System_Inputs/Fs_300MHz_Fc_25MHz_PW_10us_PRI_100us_SNR_40dB_real.txt", "r");
        file_ImagPart_40dB = $fopen("../../../../../System_Inputs/Fs_300MHz_Fc_25MHz_PW_10us_PRI_100us_SNR_40dB_imag.txt", "r");

        if (file_RealPart_10dB == 0 || file_ImagPart_10dB == 0) begin
            $display("Error: Could not open 10dB files."); $finish;
        end
        if (file_RealPart_20dB == 0 || file_ImagPart_20dB == 0) begin
            $display("Error: Could not open 20dB files."); $finish;
        end
        if (file_RealPart_40dB == 0 || file_ImagPart_40dB == 0) begin
            $display("Error: Could not open 40dB files."); $finish;
        end

        // Hold reset low, then release
        #100;
        rst_n = 1;

        // Allow DUT to settle
        #50;
    end

    // Simulation timeout (optional)
    initial begin
        #1_000_000;
        $display("Timeout: Simulation did not finish in expected time.");
        $finish;
    end

    // File reading and stimulus
    always @(posedge clk) begin
        if (rst_n) begin
            // 10dB
            if (!done_10dB && !$feof(file_RealPart_10dB)) begin
                status_RealPart_10dB = $fscanf(file_RealPart_10dB, "%d\n", RealPart_10dB);
                status_ImagPart_10dB = $fscanf(file_ImagPart_10dB, "%d\n", ImagPart_10dB);
                DataValid_10dB <= 1;
            end else if (!done_10dB) begin
                DataValid_10dB <= 0;
                $fclose(file_RealPart_10dB); $fclose(file_ImagPart_10dB);
                done_10dB <= 1;
            end

            // 20dB
            if (!done_20dB && !$feof(file_RealPart_20dB)) begin
                status_RealPart_20dB = $fscanf(file_RealPart_20dB, "%d\n", RealPart_20dB);
                status_ImagPart_20dB = $fscanf(file_ImagPart_20dB, "%d\n", ImagPart_20dB);
                DataValid_20dB <= 1;
            end else if (!done_20dB) begin
                DataValid_20dB <= 0;
                $fclose(file_RealPart_20dB); $fclose(file_ImagPart_20dB);
                done_20dB <= 1;
            end

            // 40dB
            if (!done_40dB && !$feof(file_RealPart_40dB)) begin
                status_RealPart_40dB = $fscanf(file_RealPart_40dB, "%d\n", RealPart_40dB);
                status_ImagPart_40dB = $fscanf(file_ImagPart_40dB, "%d\n", ImagPart_40dB);
                DataValid_40dB <= 1;
            end else if (!done_40dB) begin
                DataValid_40dB <= 0;
                $fclose(file_RealPart_40dB); $fclose(file_ImagPart_40dB);
                done_40dB <= 1;
            end

            if (done_10dB && done_20dB && done_40dB) begin
                $display("All input data processed. Simulation finished.");
                $finish;
            end
        end else begin
            DataValid_10dB <= 0;
            DataValid_20dB <= 0;
            DataValid_40dB <= 0;
        end
    end

endmodule
