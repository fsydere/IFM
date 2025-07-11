// HIERARCHY
// ENDHIERARCHY

`ifndef xlConvPkgIncluded
  `define xlConvPkgIncluded 1
`endif

// synopsys translate_off
`ifndef simulating
  `define simulating 1
`endif
// synopsys translate_on


`ifndef simulating
  `define simulating 0
`endif

`ifndef xlUnsigned
 `define xlUnsigned 1
`endif

`ifndef xlSigned
 `define xlSigned 2
`endif

`ifndef xlFloat
 `define xlFloat 3
`endif

`ifndef xlWrap
 `define xlWrap 1
`endif

`ifndef xlSaturate
 `define xlSaturate 2
`endif

`ifndef xlTruncate 
 `define xlTruncate 1
`endif

`ifndef xlRound 
 `define xlRound 2
`endif

`ifndef xlRoundBanker
 `define xlRoundBanker 3
`endif

`ifndef xlAddMode 
 `define xlAddMode 1
`endif

`ifndef xlSubMode
 `define xlSubMode 2
`endif



`ifndef xlConvPkgIncluded
`include "conv_pkg.v"
`endif

// synopsys translate_off
`timescale 1 ns / 10 ps
module xlclk (clk, clr, ce);
   parameter clk_period  = 100;
   parameter additional_transport_delay = 0;
   
   output clk; 
   output clr; 
   output ce; 

   reg clk; 

   initial begin
   clk = 1'b0;
   #(200 + additional_transport_delay - (clk_period / 2.0));
   forever #(clk_period / 2.0) clk = ~(clk);
   end
           
   assign clr = 1'b0;
   assign ce = 1'b1;
endmodule
// synopsys translate_on










`ifndef xlConvPkgIncluded
`include "conv_pkg.v"
`endif


// synopsys translate_off
`timescale 1 ns / 10 ps
module xltbsource (o, clk);
  parameter o_width = 4;
  parameter o_bin_pt = 2;
  parameter o_arith = `xlSigned;
  parameter latency = 1;
  parameter inputFile = "test.dat";
  parameter periodMultiplier = 1;
  parameter reqHoldTime = 0.5;
  output[o_width - 1:0] o;
  input clk;
  reg [o_width - 1:0] tmp_o;
  
  integer period_count;  
  integer inputFilePtr, errcheck;
  integer start_up;

  
 assign sys_clk = clk;
 assign #reqHoldTime o = tmp_o;

 initial
  begin
   start_up = 1;
   period_count = 0;
   if (start_up == 1)
      begin
        inputFilePtr = $fopen(inputFile, "r");
        errcheck = $fscanf(inputFilePtr,"%b",tmp_o);
        start_up = 0;
      end
  end

 always @(posedge sys_clk)
   begin
     period_count = period_count + 1;
     if (period_count == periodMultiplier)
     begin
        period_count = 0;
        if (errcheck == 1)
     	    errcheck = $fscanf(inputFilePtr,"%b",tmp_o);
    end
   end

endmodule

// synopsys translate_on








`ifndef xlConvPkgIncluded
`include "conv_pkg.v"
`endif


// synopsys translate_off
`timescale 1 ns / 10 ps
module xltbsink (i, clk);
  parameter i_width = 4;
  parameter i_bin_pt = 2;
  parameter i_arith = `xlSigned;
  parameter latency = 1;
  parameter inputFile = "test";
  parameter outputFile = "";
  parameter periodMultiplier = 1;

  input[i_width - 1:0] i;
  input clk;
  reg [i_width - 1:0] simulink_i;
  wire [i_width - 1:0] i_minus_one;
  
  integer period_count;
  integer inputFilePtr, errcheck, end_file;
  reg test_valid, test_data_valid;

  integer sample_count, valid_count, dntcare_count, error_reported;
  integer found_error, error_count;

  initial
  begin
   period_count = 0;
   sample_count = 0;
   valid_count = 0;
   dntcare_count = 0;
   error_reported = 0;
   found_error = 0;
   error_count = 0;
   inputFilePtr = $fopen(inputFile, "r");
   errcheck = $fscanf(inputFilePtr,"%b",simulink_i);
   end_file = $feof(inputFilePtr);
  end // initial begin

  assign sys_clk = clk;
  assign i_minus_one = i; 

 always @(posedge clk)
   begin
     period_count = period_count + 1;
     if (period_count == periodMultiplier)
     begin
       period_count = 0;
       if (end_file == 0)
        begin
         sample_count = sample_count + 1;

         if (sample_count == 1)
          begin
            $display("  ");  
            $display("Beginning comparisons for instance %s", inputFile);
          end

         test_valid = ^simulink_i;
         if ((test_valid == 'b0) || (test_valid == 'b1)) //Simulink Data is valid
          begin
           valid_count = valid_count + 1;
	     test_data_valid = ^i_minus_one;
	     if ((test_data_valid == 'b0) || (test_data_valid == 'b1)) //VHDL Data is valid
	       begin
		  if (simulink_i != i_minus_one)
		    begin
		       $display("  ");  
		       $display("** Data mismatch on instance %s at time %d ns.",inputFile,$stime);
		       $display("** Simulink Result: %b ( %d )",simulink_i,simulink_i);
		       $display("**  Verilog Result: %b ( %d )",i_minus_one, i_minus_one);
		       found_error = 1;
		       error_count = error_count + 1;
		    end
	       end // if ((test_data_valid == 'b0) || (test_data_valid == 'b1))
	     else
	       begin
		  $display("  ");  
		  $display("** Data mismatch on instance %s at time %d ns.",inputFile,$stime);
		  $display("** Simulink Result: %b ( %d )",simulink_i,simulink_i);
		  $display("**  Verilog Result: %b ( %d )",i_minus_one, i_minus_one);
		  found_error = 1;
		  error_count = error_count + 1;
	       end // else: !if((test_data_valid == 'b0) || (test_data_valid == 'b1))
         end
         else
            begin
             dntcare_count = dntcare_count + 1;
           end       
     	errcheck = $fscanf(inputFilePtr,"%b",simulink_i);
      end_file = $feof(inputFilePtr);
       end
       if ( end_file!= 0)
         begin
           if (error_reported == 0)
              begin
                $display("  ");
                $display("** Simulation summary for instance %s",inputFile);
                $display("   Samples Processed: %d",sample_count);
                $display("             Checked: %d",valid_count);
                $display("             Ignored: %d",dntcare_count);
                if (found_error == 1)
                  if (error_count ==1)
                     $display("  There was 1 mismatch in the test.");
                  else
                     begin
                         $display("  There were %d mismatches in the test.",error_count);
                         $display("ERROR: There were %d mismatches in the test.",error_count);
                     end
                else
                  $display("  Test completed with no errors.");
              end
           error_reported = 1;
         end
    end
   end

endmodule

// synopsys translate_on








`timescale 1 ns / 10 ps
// Generated from Simulink block 
module ifm_tb (

);
  wire [16-1:0] realpart_net;
  wire [82-1:0] estimated_frequency_2_delay_net;
  wire [16-1:0] imagpart_net;
  wire [1-1:0] estimated_frequency_4_delay_valid_net;
  wire [1-1:0] estimated_frequency_2_delay_valid_net;
  wire [1-1:0] datavalid_net;
  wire clk_net;
  wire [82-1:0] estimated_frequency_4_delay_net;
  xlclk #(
    .clk_period(3.333333)
  )
  clk_driver (
    .clk(clk_net)
  );
  xltbsource #(
    .o_arith(`xlUnsigned),
    .o_bin_pt(0),
    .o_width(1),
    .inputFile("ifm_modelcomposer_ifm_datavalid.dat"),
    .periodMultiplier(1)
  )
  datavalid_driver (
    .clk(clk_net),
    .o(datavalid_net)
  );
  xltbsource #(
    .o_arith(`xlSigned),
    .o_bin_pt(15),
    .o_width(16),
    .inputFile("ifm_modelcomposer_ifm_imagpart.dat"),
    .periodMultiplier(1)
  )
  imagpart_driver (
    .clk(clk_net),
    .o(imagpart_net)
  );
  xltbsource #(
    .o_arith(`xlSigned),
    .o_bin_pt(15),
    .o_width(16),
    .inputFile("ifm_modelcomposer_ifm_realpart.dat"),
    .periodMultiplier(1)
  )
  realpart_driver (
    .clk(clk_net),
    .o(realpart_net)
  );
  xltbsink #(
    .i_arith(`xlSigned),
    .i_bin_pt(18),
    .i_width(82),
    .inputFile("ifm_modelcomposer_ifm_estimated_frequency_2_delay.dat"),
    .periodMultiplier(1)
  )
  estimated_frequency_2_delay_load (
    .i(estimated_frequency_2_delay_net),
    .clk(clk_net)
  );
  xltbsink #(
    .i_arith(`xlUnsigned),
    .i_bin_pt(0),
    .i_width(1),
    .inputFile("ifm_modelcomposer_ifm_estimated_frequency_2_delay_valid.dat"),
    .periodMultiplier(1)
  )
  estimated_frequency_2_delay_valid_load (
    .i(estimated_frequency_2_delay_valid_net),
    .clk(clk_net)
  );
  xltbsink #(
    .i_arith(`xlSigned),
    .i_bin_pt(18),
    .i_width(82),
    .inputFile("ifm_modelcomposer_ifm_estimated_frequency_4_delay.dat"),
    .periodMultiplier(1)
  )
  estimated_frequency_4_delay_load (
    .i(estimated_frequency_4_delay_net),
    .clk(clk_net)
  );
  xltbsink #(
    .i_arith(`xlUnsigned),
    .i_bin_pt(0),
    .i_width(1),
    .inputFile("ifm_modelcomposer_ifm_estimated_frequency_4_delay_valid.dat"),
    .periodMultiplier(1)
  )
  estimated_frequency_4_delay_valid_load (
    .i(estimated_frequency_4_delay_valid_net),
    .clk(clk_net)
  );
  ifm sysgen_dut (
    .datavalid(datavalid_net),
    .imagpart(imagpart_net),
    .realpart(realpart_net),
    .clk(clk_net),
    .estimated_frequency_2_delay(estimated_frequency_2_delay_net),
    .estimated_frequency_2_delay_valid(estimated_frequency_2_delay_valid_net),
    .estimated_frequency_4_delay(estimated_frequency_4_delay_net),
    .estimated_frequency_4_delay_valid(estimated_frequency_4_delay_valid_net)
  );
endmodule
