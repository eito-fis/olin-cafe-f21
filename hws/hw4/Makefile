IVERILOG=iverilog -Wall -g2012 -y ./ -I ./
VVP=vvp
VIVADO=vivado -mode batch -source

.PHONY: clean submission remove_solutions

MUXS=mux2.sv mux4.sv mux8.sv mux16.sv mux32.sv
ADDERS=adder_input_block.sv adder_output_block.sv adder_prefix_block.sv

test_mux: test_mux.sv $(MUXS)
	${IVERILOG} $^ -o test_mux.bin && ${VVP} test_mux.bin

test_adder: test_adder.sv $(ADDERS) adder32.sv
	${IVERILOG} $^ -o test_adder.bin && ${VVP} test_adder.bin

test_adder_n: test_adder_n.sv $(ADDERS) adder_n.sv
	${IVERILOG} $^ -o test_adder_n.bin && ${VVP} test_adder_n.bin

clean:
	rm -f *.bin *.vcd vivado*.log vivado*.jou vivado*.str

submission: clean
	zip submission.zip Makefile *.sv README.md docs/*
