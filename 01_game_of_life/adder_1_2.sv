`default_nettype none

module adder_1_2(a, b, cin, out);
	input wire a;
	input wire b;
	input wire cin;

	output logic [1:0] out;

	logic p;
	logic g;

	always_comb begin
		p = a ^ b;
		g = a & b;

		out[0] = p ^ cin;
		out[1] = g | (p & cin);
	end
endmodule

