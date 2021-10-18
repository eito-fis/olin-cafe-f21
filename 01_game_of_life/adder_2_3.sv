`default_nettype none

module adder_2_3(a, b, cin, out);
	input wire [1:0] a;
	input wire [1:0] b;
	input wire cin;

	output logic [2:0] out;

	logic [1:0] first_digit;

	adder_1_2 adder_first(a[0], b[0], 1'b0, first_digit);
	adder_1_2 adder_second(a[1], b[1], first_digit[1], out[2:1]);
	always_comb begin
		out[0] = first_digit[0];
	end
endmodule
