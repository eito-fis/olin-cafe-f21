`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_adder;
	parameter N = 32;

	int errors = 0;
	logic [N-1:0] a, b;
	logic cin;
	wire [N-1:0] out;

	logic [N-1:0] correct_out;

	always_comb begin
		cin = 0;
		correct_out = a + b;
	end

  adder32 #(.N(N)) UUT(
		.a(a), .b(b), .cin(cin), .out(out)
	);

  initial begin
		$dumpfile("adder32.vcd");
		$dumpvars(0, UUT);
    
    $display("in opts | out");
    for (int i = 0; i < 1000; i = i + 1) begin

			a = $random();
			b = $random();
      #5 $display("Testing %d + %d...", a, b);
      #5 $display("%d | %d", out, correct_out);
			assert(out === correct_out) else begin
				$display("ERROR");
				errors = errors + 1;
			end

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
