`default_nettype none // Overrides default behaviour (in a good way)

module led_array_driver(ena, x, cells, rows, cols);
  // Module I/O and parameters
  parameter N=5; // Size of Conway Cell Grid.
  parameter ROWS=N;
  parameter COLS=N;

  // I/O declarations
  input wire ena;
  input wire [$clog2(N):0] x;
  input wire [N*N-1:0] cells;
  output logic [N-1:0] rows;
  output logic [N-1:0] cols;

  // You can check parameters with the $error macro within initial blocks.
  initial begin
    if ((N <= 0) || (N > 8)) begin
      $error("N must be within 0 and 8.");
    end
    if (ROWS != COLS) begin
      $error("Non square led arrays are not supported. (%dx%d)", ROWS, COLS);
    end
    if (ROWS < N) begin
      $error("ROWS/COLS must be >= than the size of the Conway Grid.");
    end
  end

  wire [N-1:0] x_decoded;
  decoder_3_to_8 COL_DECODER(ena, x, x_decoded);

	always_comb begin
		cols = x_decoded;	
		/* rows[0] = ~| (cells[24:20] & cols[4:0]); */
		/* rows[1] = ~| (cells[19:15] & cols[4:0]); */
		/* rows[2] = ~| (cells[14:10] & cols[4:0]); */
		/* rows[3] = ~| (cells[9:5] & cols[4:0]); */
		/* rows[4] = ~| (cells[4:0] & cols[4:0]); */

		/* rows[0] = ~(cols[0] & cells[15]) | (cols[1] & cells[16]) | (cols[2] & cells[17]) | (cols[3] & cells[18]) | (cols[4] & cells[19]); */
		/* rows[1] = ~(cols[0] & cells[15]) | (cols[1] & cells[16]) | (cols[2] & cells[17]) | (cols[3] & cells[18]) | (cols[4] & cells[19]); */
		/* rows[2] = ~(cols[0] & cells[10]) | (cols[1] & cells[11]) | (cols[2] & cells[12]) | (cols[3] & cells[13]) | (cols[4] & cells[14]); */
		/* rows[3] = ~(cols[0] & cells[5]) | (cols[1] & cells[6]) | (cols[2] & cells[7]) | (cols[3] & cells[8]) | (cols[4] & cells[9]); */
		/* rows[4] = ~(cols[0] & cells[0]) | (cols[1] & cells[1]) | (cols[2] & cells[2]) | (cols[3] & cells[3]) | (cols[4] & cells[4]); */
	end

	generate
		genvar i;
		for (i = 0; i < N; i = i + 1) begin
			always_comb
				rows[N - i - 1] = ~| (cells[(i + 1) * N - 1 : i * N] & cols[N - 1 : 0]);
		end
	endgenerate
  
endmodule

`default_nettype wire // reengages default behaviour, needed when using 
                      // other designs that expect it.
