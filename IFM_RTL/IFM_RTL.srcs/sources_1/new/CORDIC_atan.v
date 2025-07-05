`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2025 14:30:11
// Design Name: 
// Module Name: CORDIC_atan
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


module CORDIC_atan#(
    parameter ITERATIONS = 16  // Number of CORDIC iterations
)(
    input  wire        clk,
    input  wire        rst_n,
    input  wire        start,      // Start calculation
    input  wire [31:0] i_in,       // I component in Q2.30 format
    input  wire [31:0] q_in,       // Q component in Q2.30 format
    output reg  [31:0] phase_out,  // Phase output in Q2.30 format (-π to π)
    output reg         done        // Calculation complete
);

    // CORDIC angle constants in Q2.30 format
    // atan(2^-i) for i = 0 to 15
    reg [31:0] atan_table [0:15];
    
    // Internal registers
    reg signed [33:0] x, y, z;  // Extended precision for calculations
    reg [4:0] iteration;
    reg calculating;
    
    // State machine states
    localparam IDLE = 2'b00;
    localparam CALC = 2'b01;
    localparam DONE = 2'b10;
    reg [1:0] state;
    
    // Initialize CORDIC angle table
    initial begin
        // These values are atan(2^-i) * 2^30 / π (scaled to Q2.30)
        atan_table[0]  = 32'h20000000;  // atan(1) = π/4
        atan_table[1]  = 32'h12E4051E;  // atan(0.5)
        atan_table[2]  = 32'h09FB385B;  // atan(0.25)
        atan_table[3]  = 32'h051111D4;  // atan(0.125)
        atan_table[4]  = 32'h028B0D43;  // atan(0.0625)
        atan_table[5]  = 32'h0145D7E1;  // atan(0.03125)
        atan_table[6]  = 32'h00A2F61E;  // atan(0.015625)
        atan_table[7]  = 32'h00517C55;  // atan(0.0078125)
        atan_table[8]  = 32'h0028BE53;  // atan(0.00390625)
        atan_table[9]  = 32'h00145F2F;  // atan(0.001953125)
        atan_table[10] = 32'h000A2F98;  // atan(0.0009765625)
        atan_table[11] = 32'h000517CC;  // atan(0.00048828125)
        atan_table[12] = 32'h00028BE6;  // atan(0.000244140625)
        atan_table[13] = 32'h000145F3;  // atan(0.0001220703125)
        atan_table[14] = 32'h0000A2FA;  // atan(0.00006103515625)
        atan_table[15] = 32'h0000517D;  // atan(0.000030517578125)
    end
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            done <= 1'b0;
            phase_out <= 32'h0;
            iteration <= 5'h0;
            calculating <= 1'b0;
            x <= 34'h0;
            y <= 34'h0;
            z <= 34'h0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (start) begin
                        // Handle quadrant adjustment
                        if (i_in[31]) begin  // i_in < 0
                            if (q_in[31]) begin  // q_in < 0 (3rd quadrant)
                                x <= {2'b00, ~i_in + 1'b1};  // -i_in
                                y <= {2'b00, ~q_in + 1'b1};  // -q_in
                                z <= 34'h3C0000000;  // -π in Q2.30 extended
                            end else begin  // q_in >= 0 (2nd quadrant)
                                x <= {2'b00, ~i_in + 1'b1};  // -i_in
                                y <= {2'b00, ~q_in + 1'b1};  // -q_in
                                z <= 34'h040000000;  // +π in Q2.30 extended
                            end
                        end else begin  // i_in >= 0
                            x <= {2'b00, i_in};
                            y <= {2'b00, q_in};
                            z <= 34'h0;
                        end
                        iteration <= 5'h0;
                        state <= CALC;
                        calculating <= 1'b1;
                    end
                end
                
                CALC: begin
                    if (iteration < ITERATIONS) begin
                        if (y[33]) begin  // y < 0, rotate clockwise
                            x <= x - (y >>> iteration);
                            y <= y + (x >>> iteration);
                            z <= z - {2'b00, atan_table[iteration]};
                        end else begin  // y >= 0, rotate counter-clockwise
                            x <= x + (y >>> iteration);
                            y <= y - (x >>> iteration);
                            z <= z + {2'b00, atan_table[iteration]};
                        end
                        iteration <= iteration + 1'b1;
                    end else begin
                        state <= DONE;
                        calculating <= 1'b0;
                    end
                end
                
                DONE: begin
                    phase_out <= z[31:0];  // Extract Q2.30 result
                    done <= 1'b1;
                    state <= IDLE;
                end
                
                default: state <= IDLE;
            endcase
        end
    end

endmodule