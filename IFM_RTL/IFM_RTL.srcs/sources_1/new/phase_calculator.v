module phase_calculator (
    input wire clk,
    input wire reset,
    input wire valid_in,
    input wire signed [31:0] I, // Q2.30 format (real part)
    input wire signed [31:0] Q, // Q2.30 format (imaginary part)
    output wire valid_out,
    output wire signed [31:0] phase // Q3.29 format (phase in radians)
);

// Precomputed arctan table for Cordic (Q3.29 format)
localparam signed [31:0] atan_table [0:31] = {
    32'd421657428, // i=0: atan(1)       = pi/4
    32'd248912262, // i=1: atan(1/2)
    32'd131521918, // i=2: atan(1/4)
    32'd66762565,  // i=3: atan(1/8)
    32'd33510861,  // i=4
    32'd16771765,  // i=5
    32'd8387924,   // i=6
    32'd4194309,   // i=7
    32'd2097191,   // i=8
    32'd1048596,   // i=9
    32'd524299,    // i=10
    32'd262150,    // i=11
    32'd131075,    // i=12
    32'd65538,     // i=13
    32'd32769,     // i=14
    32'd16384,     // i=15
    32'd8192,      // i=16
    32'd4096,      // i=17
    32'd2048,      // i=18
    32'd1024,      // i=19
    32'd512,       // i=20
    32'd256,       // i=21
    32'd128,       // i=22
    32'd64,        // i=23
    32'd32,        // i=24
    32'd16,        // i=25
    32'd8,         // i=26
    32'd4,         // i=27
    32'd2,         // i=28
    32'd1,         // i=29
    32'd0,         // i=30
    32'd0          // i=31
};

// Pipeline registers
reg signed [32:0] x [0:32]; // Q3.30 format (1 extra integer bit)
reg signed [32:0] y [0:32]; // Q3.30 format
reg signed [31:0] z [0:32]; // Q3.29 format (angle accumulator)
reg valid_pipe [0:32];      // Valid signal pipeline

// Pre-scaling logic (combinational)
wire signed [31:0] I_scaled, Q_scaled;
assign I_scaled = (I[31:30] == 2'b01 || I[31:30] == 2'b10 ||
                   Q[31:30] == 2'b01 || Q[31:30] == 2'b10) ? 
                  (I >>> 1) : I;
assign Q_scaled = (I[31:30] == 2'b01 || I[31:30] == 2'b10 ||
                   Q[31:30] == 2'b01 || Q[31:30] == 2'b10) ? 
                  (Q >>> 1) : Q;

// Sign-extend to Q3.30 (33 bits)
wire signed [32:0] x0 = {I_scaled[31], I_scaled};
wire signed [32:0] y0 = {Q_scaled[31], Q_scaled};

// Initialize pipeline stage 0
always @(posedge clk or posedge reset) begin
    if (reset) begin
        x[0] <= 0;
        y[0] <= 0;
        z[0] <= 0;
        valid_pipe[0] <= 0;
    end else begin
        x[0] <= x0;
        y[0] <= y0;
        z[0] <= 0;
        valid_pipe[0] <= valid_in;
    end
end

// Generate CORDIC pipeline stages using generate blocks
genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin : cordic_stage
        always @(posedge clk or posedge reset) begin
            if (reset) begin
                x[i+1] <= 0;
                y[i+1] <= 0;
                z[i+1] <= 0;
                valid_pipe[i+1] <= 0;
            end else begin
                valid_pipe[i+1] <= valid_pipe[i];
                if (y[i] >= 0) begin
                    // Rotate clockwise (toward positive x-axis)
                    x[i+1] <= x[i] + (y[i] >>> i);
                    y[i+1] <= y[i] - (x[i] >>> i);
                    z[i+1] <= z[i] - atan_table[i];
                end else begin
                    // Rotate counter-clockwise
                    x[i+1] <= x[i] - (y[i] >>> i);
                    y[i+1] <= y[i] + (x[i] >>> i);
                    z[i+1] <= z[i] + atan_table[i];
                end
            end
        end
    end
endgenerate

// Outputs
assign valid_out = valid_pipe[32];
assign phase = z[32]; // Final angle in Q3.29

endmodule