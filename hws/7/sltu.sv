module sltu(a, b, out);

parameter N = 32;
input wire [N-1:0] a, b;
output logic out;

logic [N-1:0] not_b;
always_comb not_b = ~b;
wire c_out;
wire [N:0] difference; 

adder_n #(.N(N + 1)) SUBTRACTOR(
  .a({1'b0, a}), .b({1'b1, not_b}), .c_in(1'b1),
  .c_out(c_out), .sum(difference[N:0])
);
always_comb out = difference[N];

endmodule


