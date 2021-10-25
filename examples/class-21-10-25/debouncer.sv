module debouncer(clk, rst, bouncy_in, debounced_out);
parameter BOUNCE_TICKS = 10;
input wire clk, rst;
input wire bouncy_in;

output logic debounced_out;

typedef enum logic [1:0] {ZERO, MZERO, ONE, MONE} state_t;
state_t state;

logic enable_counter;
logic [$clog2(BOUNCE_TICKS):0] counter;

always_comb begin
	enable_counter = (state == MZERO) || (state == MONE);
end

always_comb begin
	case(state)
		ZERO, MONE:
			debounced_out = 0;
		ONE, MZERO:
			debounced_out = 1;
		default:
			debounced_out = 1'bx;
	endcase
end

always_ff @(posedge clk) begin
	if (rst | ~enable_counter) begin
		counter <= 0;
	end
	else if (enable_counter) begin
		counter <= counter + 1;
	end
end

always_ff @(posedge clk) begin
	if (rst) begin
		state <= ZERO;
	end
	else begin
		case (state)
			ZERO:
				if (bouncy_in)
					state <= MONE;
			ONE:
				if (~bouncy_in)
					state <= MZERO;
			MZERO, MONE:
				if (counter == BOUNCE_TICKS - 1)
					state <= bouncy_in ? ONE : ZERO;
		endcase
	end
end

endmodule
