module mux_32(in, opts, out);

  input wire [4:0] in;
	input wire [31:0] opts;

  output logic out;

	logic bot_out;
	mux_16 bot_mux(in[3:0], opts[31:16], bot_out);
	logic top_out;
	mux_16 top_mux(in[3:0], opts[15:0], top_out);

	mux_2 final_mux(in[4], {bot_out, top_out}, out);

endmodule
