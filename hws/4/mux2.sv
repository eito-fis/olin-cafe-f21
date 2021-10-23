module mux_2(in, opts, out);

	input wire in;
	input wire [1:0] opts;
	output logic out;

	always_comb begin
		out = in ? opts[1] : opts[0];
	end

endmodule
