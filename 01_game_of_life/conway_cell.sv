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

module conway_cell(clk, rst, ena, state_0, state_d, state_q, neighbors);
  input wire clk;
  input wire rst;
  input wire ena;

  input wire state_0;
  output logic state_d;
  output logic state_q;

  input wire [7:0] neighbors;

	always_ff @(posedge clk) state_q <= state_d;

	logic [1:0] sum_01;
	logic [1:0] sum_23;
	logic [1:0] sum_45;
	logic [1:0] sum_67;

	logic [2:0] sum_01_23;
	logic [2:0] sum_45_67;

	logic [3:0] total_sum;

	logic alive_2;
	logic alive_3;
	logic next_value;

	adder_1_2 adder_01(neighbors[0], neighbors[1], 1'b0, sum_01);
	adder_1_2 adder_23(neighbors[2], neighbors[3], 1'b0, sum_23);
	adder_1_2 adder_45(neighbors[4], neighbors[5], 1'b0, sum_45);
	adder_1_2 adder_67(neighbors[6], neighbors[7], 1'b0, sum_67);

	adder_2_3 adder_01_23(sum_01, sum_23, 1'b0, sum_01_23);
	adder_2_3 adder_45_67(sum_45, sum_67, 1'b0, sum_45_67);

	adder_3_4 total_adder(sum_01_23, sum_45_67, 1'b0, total_sum);

	always_comb begin
		alive_2 = ~total_sum[3] & ~total_sum[2] & total_sum[1] & ~total_sum[0];
		alive_3 = ~total_sum[3] & ~total_sum[2] & total_sum[1] & total_sum[0];
		next_value = (state_q & alive_2)  | (alive_3);
		state_d = rst ? state_0 : next_value;
	end
endmodule
