`default_nettype none

module adder_n(a, b, cin, out);
	parameter N = 32; // Does support changing N!

	input wire [N-1:0] a, b;
	input wire cin;

	output logic [N-1:0] out;

	wire [N-1:0] ps[0:$clog2(N) + 1]; // 6 x 32
	wire [N-1:0] gs[0:$clog2(N) + 1]; // 6 x 32

	assign ps[0][0] = 0;
	assign gs[0][0] = cin;

	generate

		genvar d;
		genvar i;
		genvar j;

		for (i = 0; i < N - 1; i = i + 1) begin
			adder_input_block input_block(
				a[i], b[i], ps[0][i + 1], gs[0][i + 1]
			);
		end

		for (d = 0; d < $clog2(N); d = d + 1) begin
			for (i = 2 ** d; i < N; i = i + 2 ** (d + 1)) begin
				for (j = 0; j < (2 ** d); j = j + 1) begin
					adder_prefix_block prefix_block(
						ps[$clog2(j + 1)][i + j], ps[d][i - 1], ps[d + 1][i + j],
						gs[$clog2(j + 1)][i + j], gs[d][i - 1], gs[d + 1][i + j]
					);
				end
			end
		end

		for (i = 0; i < N; i = i + 1) begin
			adder_output_block output_block(
				gs[$clog2(i + 1)][i], a[i], b[i], out[i]
			);
		end

	endgenerate
endmodule
