/*
  Outputs a pulse generator with a period of "ticks".
  out should go high for one cycle ever "ticks" clocks.
*/
module pulse_generator(clk, rst, ena, ticks, out);

parameter N = 8;
input wire clk, rst, ena;
input wire [N-1:0] ticks;
output logic out;

logic [N-1:0] counter;
logic counter_comparator;

always_comb begin
	counter_comparator = counter == ticks - 1;
end

always_ff @(posedge clk) begin
	if (rst || out) begin
		counter <= 0;
		out <= 0;
	end
	else if (ena) begin
		if (counter_comparator) begin
			out <= 1;
		end
		else begin
			counter <= counter + 1;
		end
	end
end

endmodule
