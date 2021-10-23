module mux_8(in, opts, out);

  input wire [2:0] in;
	// [H, G, F, E, D, C, B, A] - [111, 110, 101, 100, 011, 010, 001, 000]
	input wire [7:0] opts;

  output logic out;

	// [H, G, F, E] - [11, 10, 01, 00]
	logic bot_out;
	mux_4 bot_mux(in[1:0], opts[7:4], bot_out);

	// [D, C, B, A] - [11, 10, 01, 00]
	logic top_out;
	mux_4 top_mux(in[1:0], opts[3:0], top_out);

	// [H | G | F | E, D | C | B | A] - [1, 0]
	mux_2 final_mux(in[2], {bot_out, top_out}, out);

endmodule
