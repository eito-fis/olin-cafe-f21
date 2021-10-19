# HW 4

## MUX 32
To implement the 32:1 mux, I used a divide and conquer strategy. I noticed that a 4:1
mux could be implemented using 2 2:1 muxes, one for each bit in the input. Similarly, a
8:1 mux could be implemented using a 2:1 mux and a 4:1, and so on so forth. At each
iteration, the most significant bit of the input is used to drive a 2:1 mux which
chooses one of two muxes of one size less (`num options / 2`) that handle the rest of the
input.

To test the mux I used a relatively simple approach. I iterated over all possible input
values, and tested an output of 0 or 1. For example, when input = 8 I first
tested that the output was 0 when the 8th option was 0, and then tested that the output
was 1 when the 8th option was 1. This method does not adequately cover all cases - for
example, if we were reading 0s offset by one we would never detect it, since the rest of
the bitstring is also 0s. A complementary approach would be to test with randomized
bitstrings against verilog's indexing, but I ran out of time.

To run tests: `make test_mux`

## ADDER 32
I implemented a prefix adder two ways. To start, I hardcoded a 32 bit prefix adder (See
figure 5.7 on page 242 for my reference). I initially defined the 3 base modules: the
starting prefix module, the middle prefix module, and the output module. Then, I
manually defined each of the 5 layers of prefix calculations. For these, I used a single
for loop to identify where each 'block' of prefixes started, but then had to hardcode
the individual units within the block, as the layer each unit pulled from varied. To
test, I used a random approach similar to the test_multiplier example.

I also implemented an arbitrary size prefix adder. While writing the 32 bit adder, I
noticed that the start and end of each block could be defined by the current depth
(starts at `2 ** depth` and contains `2 ** (depth + 1)` bits). I also noticed that the layer
from which a unit pulls from could be defined by the offset within the block
(`$clog2(offset + 1)`). The first pattern allowed me to write a for loop to produce all
layers at once, and the second pattern allowed me to write a for loop to produce all
units within a block. Together, I got a triple for loop that compactly produces the
required layers for any valid N. The tests for the N bit adder are the same as the 32
bit adder, but with 64 bits.

To run tests: `make test_adder` or `make test_adder_n`
