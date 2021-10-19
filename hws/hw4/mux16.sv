module mux_16(in, opts, out);

  input wire [3:0] in;
	input wire [15:0] opts;

  output logic out;

	logic bot_out;
	mux_8 bot_mux(in[2:0], opts[15:8], bot_out);
	logic top_out;
	mux_8 top_mux(in[2:0], opts[7:0], top_out);

	mux_2 final_mux(in[3], {bot_out, top_out}, out);

endmodule
