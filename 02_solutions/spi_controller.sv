`include "spi_types.sv"

module spi_controller(
  clk, rst, sclk, csb, mosi, miso,
  spi_mode, i_ready, i_valid, i_data, o_ready, o_valid, o_data,
  bit_counter
);

input wire clk, rst; // default signals.

// SPI Signals
output logic sclk; // Serial clock to secondary device.
output logic csb; // chip select bar, needs to go low at the start of any SPI transaction, then go high whne done.
output logic mosi; // Main Out Secondary In (sends serial data to secondary device)
input wire miso; // Main In Secondary Out (receives serial data from secondary device)

// Control Signals
input spi_transaction_t spi_mode;
output logic i_ready;
input wire i_valid;
input wire [15:0] i_data;

input wire o_ready; // Unused for now.
output logic o_valid;
output logic [23:0] o_data;
output logic unsigned [4:0] bit_counter; // the number of the current bit being transmit

// TX : transmitting
// RX: receiving
enum logic [2:0] {S_IDLE, S_TXING, S_TX_DONE, S_RXING, S_RX_DONE, S_ERROR } state;

// Internal registers/counters
logic [15:0] tx_data;
logic [23:0] rx_data;

// Ensures csb is low during transactions
always_comb begin : csb_logic
  case(state)
    S_IDLE, S_ERROR : csb = 1;
    S_TXING, S_TX_DONE, S_RXING, S_RX_DONE: csb = 0;
    default: csb = 1;
  endcase
end

// Main out is transmission data indexed by bit counter
// Only outputs when state is in transmitting
always_comb begin : mosi_logic
  mosi = tx_data[bit_counter[4:0]] & (state == S_TXING);
end

/*
This is going to be one of our more complicated FSMs. 
We need to sample inputs on the positive edge of sclk, but 
we also want to set outputs on the negative edge of the clk (it's
  the safest time to change an output given unknown peripheral
  setup/hold times).

To do this we are going to toggle sclk every cycle. We can then test
whether we are about to be on a negative edge or a positive edge by 
checking the current value of sclk. If it's 1, we're about to go negative,
so that's a negative edge.

*/
always_ff @(posedge clk) begin : spi_controller_fsm
  if(rst) begin
    state <= S_IDLE;
    sclk <= 0;
    bit_counter <= 0;
    o_valid <= 0;
    i_ready <= 1; // Ready for input
    tx_data <= 0;
    rx_data <= 0;
    o_data <= 0;
  end else begin
    case(state)
      S_IDLE : begin
// SOLUTION START
        i_ready <= 1;
        sclk <= 0;
				// If the data is stable and ready for transmission
        if(i_valid) begin
					// Store data in tx_data and switch to transmission state
          tx_data <= i_data;
          rx_data <= 0;
          i_ready <= 0;
          o_valid <= 0;
          state <= S_TXING;
          // Initialize our bit counter based on our spi mode. By initializing to a the terminal value and then counting down, we can get away with a single == comparator (instead of comparing to different values based on spi_mode)
          case (spi_mode) 
            WRITE_16 : bit_counter <= 5'd15;
            WRITE_8 : bit_counter <= 5'd7;
            default : bit_counter <= 5'd7;
          endcase
        end
// SOLUTION END
      end
      S_TXING : begin
        sclk <= ~sclk;
        // positive edge logic
        if(~sclk) begin
// SOLUTION START
// SOLUTION END
        end else begin // negative edge logic
					// Decrement bit counter every negative edge
					// Note the CL means the output is transmission data indexed by bit
					// counter, so this iterates over all transmission data bits
          if(bit_counter != 0) begin
            bit_counter <= bit_counter - 1;
          end else begin
            state <= S_TX_DONE;
          end
        end
      end
      S_TX_DONE : begin
        // sclk <= ~sclk; //TODO@(avinash)
        // Next State Logic
				// If in write mode, go straight to idle and become ready
				// Else, move to receiving
        case (spi_mode)
          WRITE_8, WRITE_16: begin
              state <= S_IDLE;
              i_ready <= 1;
          end
          default : state <= S_RXING;
        endcase
        // Bit Counter Reset Logic
        case (spi_mode)
          WRITE_8_READ_8  : bit_counter <= 5'd7;
          WRITE_8_READ_16 : bit_counter <= 5'd15;
          WRITE_8_READ_24 : bit_counter <= 5'd23;
          default : bit_counter <= 0;
        endcase
      end
// SOLUTION START
      S_RXING : begin
        sclk <= ~sclk;
        if(~sclk) begin // positive edge logic
					// Decrement bit counter. When reaches 0, copy data to o_data, move
					// to idle and set valid when.
          if(bit_counter != 0) begin
            bit_counter <= bit_counter - 1;
          end else begin
            o_data <= rx_data;
            o_valid <= 1;
            state <= S_IDLE;
            i_ready <= 1; // This logic would have to change if we wanted to use o_ready.
          end
        end else begin // negative edge logic
					// Write secondary out to the data
          rx_data[bit_counter] <= miso;
        end
      end
// SOLUTION END
      default : state <= S_ERROR;
    endcase
  end
end

endmodule
