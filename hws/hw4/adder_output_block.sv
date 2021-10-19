`default_nettype none

module adder_output_block(carry, a, b, out);

	input wire carry;
	input wire a;
	input wire b;

	output logic out;

	always_comb begin
		out = carry ^ (a ^ b);
	end

endmodule

