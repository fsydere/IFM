`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2025 14:31:31
// Design Name: 
// Module Name: cordic_tb
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


module cordic_tb();
    reg         clk;
    reg         rst_n;
    reg         start;
    reg  [31:0] i_in;
    reg  [31:0] q_in;
    wire [31:0] phase_out;
    wire        done;
    
    // Instantiate DUT
    CORDIC_atan dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .i_in(i_in),
        .q_in(q_in),
        .phase_out(phase_out),
        .done(done)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Helper function to convert real to Q2.30
    function [31:0] real_to_q230;
        input real value;
        begin
            real_to_q230 = $rtoi(value * (1 << 30));
        end
    endfunction
    
    // Helper function to convert Q2.30 to real
    function real q230_to_real;
        input [31:0] value;
        begin
            if (value[31])  // negative
                q230_to_real = -($itor((~value + 1)) / (1 << 30));
            else
                q230_to_real = $itor(value) / (1 << 30);
        end
    endfunction
    
    // Test stimulus
    initial begin
        // Initialize
        rst_n = 0;
        start = 0;
        i_in = 0;
        q_in = 0;
        
        // Reset
        #20 rst_n = 1;
        #10;
        
        // Test case 1: 45 degrees (π/4)
        $display("\nTest 1: I=1.0, Q=1.0 (45 degrees)");
        i_in = real_to_q230(1.0);
        q_in = real_to_q230(1.0);
        start = 1;
        #10 start = 0;
        
        wait(done);
        $display("Phase output: %f radians (%f degrees)", 
                 q230_to_real(phase_out), 
                 q230_to_real(phase_out) * 180.0 / 3.14159265359);
        #20;
        
        // Test case 2: 90 degrees (π/2)
        $display("\nTest 2: I=0.0, Q=1.0 (90 degrees)");
        i_in = real_to_q230(0.0);
        q_in = real_to_q230(1.0);
        start = 1;
        #10 start = 0;
        
        wait(done);
        $display("Phase output: %f radians (%f degrees)", 
                 q230_to_real(phase_out), 
                 q230_to_real(phase_out) * 180.0 / 3.14159265359);
        #20;
        
        // Test case 3: -45 degrees (-π/4)
        $display("\nTest 3: I=1.0, Q=-1.0 (-45 degrees)");
        i_in = real_to_q230(1.0);
        q_in = real_to_q230(-1.0);
        start = 1;
        #10 start = 0;
        
        wait(done);
        $display("Phase output: %f radians (%f degrees)", 
                 q230_to_real(phase_out), 
                 q230_to_real(phase_out) * 180.0 / 3.14159265359);
        #20;
        
        // Test case 4: 135 degrees (3π/4)
        $display("\nTest 4: I=-1.0, Q=1.0 (135 degrees)");
        i_in = real_to_q230(-1.0);
        q_in = real_to_q230(1.0);
        start = 1;
        #10 start = 0;
        
        wait(done);
        $display("Phase output: %f radians (%f degrees)", 
                 q230_to_real(phase_out), 
                 q230_to_real(phase_out) * 180.0 / 3.14159265359);
        #20;
        
        // Test case 5: -135 degrees (-3π/4)
        $display("\nTest 5: I=-1.0, Q=-1.0 (-135 degrees)");
        i_in = real_to_q230(-1.0);
        q_in = real_to_q230(-1.0);
        start = 1;
        #10 start = 0;
        
        wait(done);
        $display("Phase output: %f radians (%f degrees)", 
                 q230_to_real(phase_out), 
                 q230_to_real(phase_out) * 180.0 / 3.14159265359);
        #20;
        
        // Test case 6: Small angle
        $display("\nTest 6: I=1.0, Q=0.1 (small angle)");
        i_in = real_to_q230(1.0);
        q_in = real_to_q230(0.1);
        start = 1;
        #10 start = 0;
        
        wait(done);
        $display("Phase output: %f radians (%f degrees)", 
                 q230_to_real(phase_out), 
                 q230_to_real(phase_out) * 180.0 / 3.14159265359);
        #20;
        
        $display("\nTestbench completed!");
        $finish;
    end
    
    // Monitor for debugging
    initial begin
        $monitor("Time=%0t: state=%d, iteration=%d, done=%b", 
                 $time, dut.state, dut.iteration, done);
    end

endmodule