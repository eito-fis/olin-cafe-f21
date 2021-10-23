module slt(a, b, out);
parameter N = 32;
input wire signed [N-1:0] a, b;
output logic out;

// Using only *structural* combinational logic, make a module that computes if a is less than b!
// Note: this assumes that the two inputs are signed: aka should be interpreted as two's complement.

// Copy any other modules you use into this folder and update the Makefile accordingly.

logic [N-1:0] sub_out;
logic [N-1:0] inv_b;
logic sub_cout;
logic is_overflow;
logic final_bit;

adder_n #(.N(N)) adder_32bit_a (
	.a(a), .b(inv_b), .cin(1'b1), .out(sub_out), .cout(sub_cout)
);

always_comb begin
	inv_b = ~b;
	final_bit = sub_out[N - 1];
	is_overflow = 
		(~a[N - 1] & ~inv_b[N - 1] & sub_out[N - 1]) |
		(a[N - 1] & inv_b[N - 1] & ~sub_out[N - 1]);
	out = is_overflow ? ~final_bit : final_bit;
end

endmodule
