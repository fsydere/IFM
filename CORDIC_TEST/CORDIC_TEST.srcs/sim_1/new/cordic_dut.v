`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2025 11:16:08
// Design Name: 
// Module Name: cordic_dut
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


module cordic_dut();

reg             aclk;                             
reg             s_axis_cartesian_tvalid;          
reg [31 : 0]    s_axis_cartesian_tdata;  
wire            m_axis_dout_tvalid;     
wire [15 : 0]   m_axis_dout_tdata;


always
    #5 aclk = ~aclk;
    
initial begin
    aclk = 0;
    s_axis_cartesian_tvalid = 0;
    s_axis_cartesian_tdata = 0;
    #100;
    s_axis_cartesian_tvalid = 1;
    s_axis_cartesian_tdata = 32'h00B5_0040;
    #10;
    s_axis_cartesian_tvalid = 1;
    s_axis_cartesian_tdata = 32'h0040_00B5;
    #10;
    s_axis_cartesian_tvalid = 0;
    s_axis_cartesian_tdata = 0;
    #1000;
    $finish;
end


cordic_wrapper DUT(
    .aclk                           (aclk                    ),                             
    .s_axis_cartesian_tvalid        (s_axis_cartesian_tvalid ),          
    .s_axis_cartesian_tdata         (s_axis_cartesian_tdata  ),  
    .m_axis_dout_tvalid             (m_axis_dout_tvalid      ),              
    .m_axis_dout_tdata              (m_axis_dout_tdata       )      
);

endmodule
