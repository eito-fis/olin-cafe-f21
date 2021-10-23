module mux_4(in, opts, out);

  input wire [1:0] in;
	input wire [3:0] opts; // [D, C, B, A] - [11, 10, 01, 00]
  output logic out;

	logic bot_out;
	mux_2 bot_mux(in[0], opts[3:2], bot_out); // [D, C] - [1, 0]

	logic top_out;
	mux_2 top_mux(in[0], opts[1:0], top_out); // [B, A] - [1, 0]

	mux_2 final_mux(in[1], {bot_out, top_out}, out); // [D | C, B | A] - [1, 0]

endmodule
