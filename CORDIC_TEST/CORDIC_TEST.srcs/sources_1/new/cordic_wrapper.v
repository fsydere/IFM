`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2025 11:14:15
// Design Name: 
// Module Name: cordic_wrapper
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


module cordic_wrapper(
    input wire aclk,                             
    input wire s_axis_cartesian_tvalid,          
    input wire [31 : 0] s_axis_cartesian_tdata,  
    output wire m_axis_dout_tvalid,              
    output wire [15 : 0] m_axis_dout_tdata      
);

cordic_0 CORDIC_10Q8 (
  .aclk(aclk),                                       
  .s_axis_cartesian_tvalid(s_axis_cartesian_tvalid), 
  .s_axis_cartesian_tdata(s_axis_cartesian_tdata),   
  .m_axis_dout_tvalid(m_axis_dout_tvalid),           
  .m_axis_dout_tdata(m_axis_dout_tdata)              
);

endmodule
