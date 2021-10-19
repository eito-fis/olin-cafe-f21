`default_nettype none

module adder32(a, b, cin, out);
	parameter N = 32; // Doesn't actually support changing N

	input wire [N-1:0] a, b;
	input wire cin;

	output logic [N-1:0] out;

	wire ps_0[N-1:0];
	wire gs_0[N-1:0];

	wire ps_1[N-1:0];
	wire gs_1[N-1:0];

	wire ps_2[N-1:0];
	wire gs_2[N-1:0];

	wire ps_3[N-1:0];
	wire gs_3[N-1:0];

	wire ps_4[N-1:0];
	wire gs_4[N-1:0];

	wire ps_5[N-1:0];
	wire gs_5[N-1:0];

	assign ps_0[0] = 0;
	assign gs_0[0] = cin;

	generate

		genvar i;

		for (i = 0; i < N - 1; i = i + 1) begin
			adder_input_block input_block(a[i], b[i], ps_0[i + 1], gs_0[i + 1]);
		end

		for (i = 1; i < N; i = i + 2) begin
			adder_prefix_block prefix_block(
				ps_0[i], ps_0[i - 1], ps_1[i],
				gs_0[i], gs_0[i - 1], gs_1[i]
			);
		end

		for (i = 2; i < N; i = i + 4) begin
			adder_prefix_block prefix_block_1(
				ps_0[i], ps_1[i - 1], ps_2[i],
				gs_0[i], gs_1[i - 1], gs_2[i]
			);
			adder_prefix_block prefix_block_2(
				ps_1[i + 1], ps_1[i - 1], ps_2[i + 1],
				gs_1[i + 1], gs_1[i - 1], gs_2[i + 1]
			);
		end

		for (i = 4; i < N; i = i + 8) begin
			adder_prefix_block prefix_block_1(
				ps_0[i], ps_2[i - 1], ps_3[i],
				gs_0[i], gs_2[i - 1], gs_3[i]
			);
			adder_prefix_block prefix_block_2(
				ps_1[i + 1], ps_2[i - 1], ps_3[i + 1],
				gs_1[i + 1], gs_2[i - 1], gs_3[i + 1]
			);
			adder_prefix_block prefix_block_3(
				ps_2[i + 2], ps_2[i - 1], ps_3[i + 2],
				gs_2[i + 2], gs_2[i - 1], gs_3[i + 2]
			);
			adder_prefix_block prefix_block_4(
				ps_2[i + 3], ps_2[i - 1], ps_3[i + 3],
				gs_2[i + 3], gs_2[i - 1], gs_3[i + 3]
			);
		end

		for (i = 8; i < N; i = i + 16) begin
			adder_prefix_block prefix_block_1(
				ps_0[i], ps_3[i - 1], ps_4[i],
				gs_0[i], gs_3[i - 1], gs_4[i]
			);
			adder_prefix_block prefix_block_2(
				ps_1[i + 1], ps_3[i - 1], ps_4[i + 1],
				gs_1[i + 1], gs_3[i - 1], gs_4[i + 1]
			);
			adder_prefix_block prefix_block_3(
				ps_2[i + 2], ps_3[i - 1], ps_4[i + 2],
				gs_2[i + 2], gs_3[i - 1], gs_4[i + 2]
			);
			adder_prefix_block prefix_block_4(
				ps_2[i + 3], ps_3[i - 1], ps_4[i + 3],
				gs_2[i + 3], gs_3[i - 1], gs_4[i + 3]
			);
			adder_prefix_block prefix_block_5(
				ps_3[i + 4], ps_3[i - 1], ps_4[i + 4],
				gs_3[i + 4], gs_3[i - 1], gs_4[i + 4]
			);
			adder_prefix_block prefix_block_6(
				ps_3[i + 5], ps_3[i - 1], ps_4[i + 5],
				gs_3[i + 5], gs_3[i - 1], gs_4[i + 5]
			);
			adder_prefix_block prefix_block_7(
				ps_3[i + 6], ps_3[i - 1], ps_4[i + 6],
				gs_3[i + 6], gs_3[i - 1], gs_4[i + 6]
			);
			adder_prefix_block prefix_block_8(
				ps_3[i + 7], ps_3[i - 1], ps_4[i + 7],
				gs_3[i + 7], gs_3[i - 1], gs_4[i + 7]
			);
		end

		for (i = 16; i < N; i = i + 32) begin
			adder_prefix_block prefix_block_1(
				ps_0[i], ps_4[i - 1], ps_5[i],
				gs_0[i], gs_4[i - 1], gs_5[i]
			);
			adder_prefix_block prefix_block_2(
				ps_1[i + 1], ps_4[i - 1], ps_5[i + 1],
				gs_1[i + 1], gs_4[i - 1], gs_5[i + 1]
			);
			adder_prefix_block prefix_block_3(
				ps_2[i + 2], ps_4[i - 1], ps_5[i + 2],
				gs_2[i + 2], gs_4[i - 1], gs_5[i + 2]
			);
			adder_prefix_block prefix_block_4(
				ps_2[i + 3], ps_4[i - 1], ps_5[i + 3],
				gs_2[i + 3], gs_4[i - 1], gs_5[i + 3]
			);
			adder_prefix_block prefix_block_5(
				ps_3[i + 4], ps_4[i - 1], ps_5[i + 4],
				gs_3[i + 4], gs_4[i - 1], gs_5[i + 4]
			);
			adder_prefix_block prefix_block_6(
				ps_3[i + 5], ps_4[i - 1], ps_5[i + 5],
				gs_3[i + 5], gs_4[i - 1], gs_5[i + 5]
			);
			adder_prefix_block prefix_block_7(
				ps_3[i + 6], ps_4[i - 1], ps_5[i + 6],
				gs_3[i + 6], gs_4[i - 1], gs_5[i + 6]
			);
			adder_prefix_block prefix_block_8(
				ps_3[i + 7], ps_4[i - 1], ps_5[i + 7],
				gs_3[i + 7], gs_4[i - 1], gs_5[i + 7]
			);
			adder_prefix_block prefix_block_9(
				ps_4[i + 8], ps_4[i - 1], ps_5[i + 8],
				gs_4[i + 8], gs_4[i - 1], gs_5[i + 8]
			);
			adder_prefix_block prefix_block_10(
				ps_4[i + 9], ps_4[i - 1], ps_5[i + 9],
				gs_4[i + 9], gs_4[i - 1], gs_5[i + 9]
			);
			adder_prefix_block prefix_block_11(
				ps_4[i + 10], ps_4[i - 1], ps_5[i + 10],
				gs_4[i + 10], gs_4[i - 1], gs_5[i + 10]
			);
			adder_prefix_block prefix_block_12(
				ps_4[i + 11], ps_4[i - 1], ps_5[i + 11],
				gs_4[i + 11], gs_4[i - 1], gs_5[i + 11]
			);
			adder_prefix_block prefix_block_13(
				ps_4[i + 12], ps_4[i - 1], ps_5[i + 12],
				gs_4[i + 12], gs_4[i - 1], gs_5[i + 12]
			);
			adder_prefix_block prefix_block_14(
				ps_4[i + 13], ps_4[i - 1], ps_5[i + 13],
				gs_4[i + 13], gs_4[i - 1], gs_5[i + 13]
			);
			adder_prefix_block prefix_block_15(
				ps_4[i + 14], ps_4[i - 1], ps_5[i + 14],
				gs_4[i + 14], gs_4[i - 1], gs_5[i + 14]
			);
			adder_prefix_block prefix_block_16(
				ps_4[i + 15], ps_4[i - 1], ps_5[i + 15],
				gs_4[i + 15], gs_4[i - 1], gs_5[i + 15]
			);
		end

		for (i = 0; i < N; i = i + 1) begin
			if ($clog2(i + 1) == 0) begin // 0
				adder_output_block output_block_0(gs_0[i], a[i], b[i], out[i]);
			end
			else if ($clog2(i + 1) == 1) begin // 1
				adder_output_block output_block_1(gs_1[i], a[i], b[i], out[i]);
			end
			else if ($clog2(i + 1) == 2) begin // 2 - 3
				adder_output_block output_block_2(gs_2[i], a[i], b[i], out[i]);
			end
			else if ($clog2(i + 1) == 3) begin // 4 - 7
				adder_output_block output_block_3(gs_3[i], a[i], b[i], out[i]);
			end
			else if ($clog2(i + 1) == 4) begin // 8 - 15
				adder_output_block output_block_4(gs_4[i], a[i], b[i], out[i]);
			end
			else if ($clog2(i + 1) == 5) begin // 16 - 31
				adder_output_block output_block_5(gs_5[i], a[i], b[i], out[i]);
			end
		end

	endgenerate
endmodule

