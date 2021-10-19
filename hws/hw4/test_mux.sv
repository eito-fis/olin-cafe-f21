`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_mux;
  logic [4:0] in;
	logic [31:0] opts;
  wire out;

	int errors = 0;

  mux_32 UUT(in, opts, out);

  initial begin

		in = 0;
		opts = 0;
    
    $display("in opts | out");
    for (int i = 0; i < 32; i = i + 1) begin

      #5 $display("%3b %32b | %1b", in, opts, out);
			assert(out === opts[i]) else begin
				$display("ERROR");
				errors = errors + 1;
			end

			opts[i] = 1;

      #5 $display("%3b %32b | %1b", in, opts, out);
			assert(out === opts[i]) else begin
				$display("ERROR");
				errors = errors + 1;
			end
      #5 $display("");

			opts[i] = 0;
			in = in + 1;

    end

		if (errors !== 0) begin
			$display("---------------------------------------------------------------");
			$display("-- FAILURE                                                   --");
			$display("---------------------------------------------------------------");
			$display(" %d failures found, try again!", errors);
		end else begin
			$display("---------------------------------------------------------------");
			$display("-- SUCCESS                                                   --");
			$display("---------------------------------------------------------------");
		end
        
    $finish;      
  end
endmodule
