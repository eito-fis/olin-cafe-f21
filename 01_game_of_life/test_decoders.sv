`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_decoders;
  logic ena;
  logic [2:0] in;
  wire [7:0] out;

  decoder_3_to_8 UUT(ena, in, out);

  /* logic input_1_2; */
  /* wire [1:0] output_1_2; */
  /* decoder_1_to_2 UUT_1_2( */
	  /* .ena(ena), */
	  /* .in(input_1_2), */
	  /* .out(output_1_2) */
  /* ); */

  /* initial begin: testing_1_2_decoder */
  /*   ena = 1; */
  /*   $display("ena in | out"); */
  /*   for (int i = 0; i < 2; i = i + 1) begin */
  /*     input_1_2 = i[0]; */
  /*     #1 $display("%1b %1b | %2b", ena, input_1_2, output_1_2); */
  /*   end */

  /*   ena = 0; */
  /*   for (int i = 0; i < 2; i = i + 1) begin */
  /*     input_1_2 = i[0]; */
  /*     #1 $display("%1b %1b | %2b", ena, input_1_2, output_1_2); */
  /*   end */
  /* end */

  /* logic [1:0] input_2_4; */
  /* wire [3:0] output_2_4; */
  /* decoder_2_to_4 UUT_2_4( */
	  /* .ena(ena), */
	  /* .in(input_2_4), */
	  /* .out(output_2_4) */
  /* ); */

  /* initial begin: testing_2_4_decoder */
  /*   // Collect waveforms */
  /*   $dumpfile("decoders.vcd"); */
  /*   $dumpvars(0, UUT_2_4); */
  /*   ena = 1; */
  /*   $display("ena in | out"); */
  /*   for (int i = 0; i < 4; i = i + 1) begin */
  /*     input_2_4 = i[1:0]; */
  /*     #5 $display("%1b %2b | %4b", ena, input_2_4, output_2_4); */
  /*   end */

  /*   ena = 0; */
  /*   for (int i = 0; i < 4; i = i + 1) begin */
  /*     input_2_4 = i[1:0]; */
  /*     #5 $display("%1b %2b | %4b", ena, input_2_4, output_2_4); */
  /*   end */
  /* end */

  initial begin
    
    ena = 1;
    $display("ena in | out");
    for (int i = 0; i < 8; i = i + 1) begin
      in = i[2:0];
      #50 $display("%1b %2b | %4b", ena, in, out);
    end

    ena = 0;
    for (int i = 0; i < 8; i = i + 1) begin
      in = i[2:0];
      #50 $display("%1b %2b | %4b", ena, in, out);
    end
        
    $finish;      
  end
endmodule
