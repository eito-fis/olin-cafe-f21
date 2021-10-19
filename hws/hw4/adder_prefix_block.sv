`default_nettype none

module adder_prefix_block(p_ik, p_kj, p_ij, g_ik, g_kj, g_ij);

	input wire p_ik;
	input wire p_kj;
	input wire g_ik;
	input wire g_kj;

	output logic p_ij;
	output logic g_ij;

	always_comb begin
		p_ij = p_ik & p_kj;
		g_ij = g_ik | (p_ik & g_kj);
	end

endmodule

