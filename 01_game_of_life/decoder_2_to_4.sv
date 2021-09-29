module decoder_2_to_4(ena, in, out);

  input wire ena;
  input wire [1:0] in;
  output logic [3:0] out;

	logic [1:0] ena_2;

	decoder_1_to_2 decoder_1(ena, in[1], ena_2[1:0]);
	decoder_1_to_2 decoder_2(ena_2[0], in[0], out[1:0]);
	decoder_1_to_2 decoder_3(ena_2[1], in[0], out[3:2]);

endmodule
