module decoder_3_to_8(ena, in, out);

  input wire ena;
  input wire [2:0] in;
  output logic [7:0] out;

	logic [1:0] ena_2;

	decoder_1_to_2 decoder_1(ena, in[2], ena_2[1:0]);
	decoder_2_to_4 decoder_2(ena_2[0], in[1:0], out[3:0]);
	decoder_2_to_4 decoder_3(ena_2[1], in[1:0], out[7:4]);

endmodule
