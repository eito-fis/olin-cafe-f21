`default_nettype none

module adder_input_block(a, b, p, g);

	input wire a;
	input wire b;

	output logic p;
	output logic g;

	always_comb begin
		p = a | b;
		g = a & b;
	end

endmodule

