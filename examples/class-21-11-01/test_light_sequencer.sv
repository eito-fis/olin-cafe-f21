`timescale 1ns / 1ps
`default_nettype none

module test_light_sequencer;

parameter CLK_HZ = 12_000_000;
parameter CLK_PERIOD_NS = (1_000_000_000/CLK_HZ); // Approximation.

logic clk, rst;
logic [1:0] buttons;
wire [2:0] rgb;

wire debounced_out;

debouncer #(.BOUNCE_TICKS(4)) UUT (
  .clk(clk), .rst(rst), .bouncy_in(bouncy_in), 
  .debounced_out(debounced_out)
);

always #(CLK_PERIOD_NS/2) clk = ~clk;

int bounces, delay;
task bounce_button();
  bounces = ($urandom % 20) + 10;
  $display("starting a bounce sequence %d", bounces);
  for(int i = 0; i < bounces; i = i + 1) begin
    delay = ($urandom % 15) + 1;
    $display("bouncing with delay %d", delay);
    #(delay) buttons[1] = $urandom;
  end
endtask


initial begin
  $dumpfile("light_sequencer.vcd");
  $dumpvars(0, UUT);

  // Initialize all of our variables
  clk = 0;
  rst = 1;

  buttons[0] = 1;
  buttons[1] = 0;

  // Reset over
  repeat (2) @(negedge clk);
  buttons[0] = 0;

<<<<<<< HEAD:examples/class-21-10-25/test_debouncer.sv
  // simulation of a bounce!
  bounces = ($urandom % 20) + 100;
  $display("starting a bounce sequence %d", bounces);
  for(int i = 0; i < bounces; i = i + 1) begin
    delay = ($urandom % 15) + 1;
    $display("bouncing with delay %d", delay);
    #(delay) bouncy_in = $urandom;
  end
	bouncy_in = 1;
=======
  for(int i = 0; i < 5; i = i + 1) begin
    $display("On test number %2d", i);
    bounce_button();
    buttons[1] = 1;
>>>>>>> upstream/main:examples/class-21-11-01/test_light_sequencer.sv

    repeat (250) @(posedge clk);

<<<<<<< HEAD:examples/class-21-10-25/test_debouncer.sv
=======
    bounce_button();
    buttons[1] = 0;

    repeat (250) @(posedge clk);
  end

>>>>>>> upstream/main:examples/class-21-11-01/test_light_sequencer.sv
  $finish;

end

// Put a timeout to make sure the simulation doesn't run forever.
initial begin
  repeat (1000) @(posedge clk);
  $display("Test timed out. Check your FSM logic, or increase MAX_CYCLES");
  $finish;
end

endmodule
