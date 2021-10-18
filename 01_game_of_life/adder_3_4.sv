`default_nettype none

module adder_3_4(a, b, cin, out);
	input wire [2:0] a;
	input wire [2:0] b;
	input wire cin;

	output logic [3:0] out;

	logic [2:0] first_digits;

	adder_2_3 adder_first(a[1:0], b[1:0], 1'b0, first_digits);
	adder_1_2 adder_second(a[2], b[2], first_digits[2], out[3:2]);
	always_comb begin
		out[1:0] = first_digits[1:0];
	end
endmodule
