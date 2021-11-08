`timescale 1ns/1ps
`default_nettype none

`include "alu_types.sv"

module alu(a, b, control, result, overflow, zero, equal);
parameter N = 32; // Don't need to support other numbers, just using this as a constant.

input wire [N-1:0] a, b; // Inputs to the ALU.
input alu_control_t control; // Sets the current operation.
output logic [N-1:0] result; // Result of the selected operation.

output logic overflow; // Is high if the result of an ADD or SUB wraps around the 32 bit boundary.
output logic zero;  // Is high if the result is ever all zeros.
output logic equal; // is high if a == b.

// Use *only* structural logic and previously defined modules to implement an 
// ALU that can do all of operations defined in alu_types.sv's alu_op_code_t!

// Logical operations
logic [N-1:0] and_out;
logic [N-1:0] or_out;
logic [N-1:0] xor_out;

always_comb begin
	and_out = a & b;
	or_out = a | b;
	xor_out = a ^ b;
end

// Shift operations
logic [N-1:0] sll_out;
logic [N-1:0] srl_out;
logic [N-1:0] sra_out;

shift_left_logical #(.N(N)) SLL (.in(a), .shamt(b[4:0]), .out(sll_out));
shift_right_logical #(.N(N)) SRL (.in(a), .shamt(b[4:0]), .out(srl_out));
shift_right_arithmetic #(.N(N)) SRA (.in(a), .shamt(b[4:0]), .out(sra_out));

logic valid_shift;
logic [N-1:0] sll_valid_out;
logic [N-1:0] srl_valid_out;
logic [N-1:0] sra_valid_out;

always_comb begin
	valid_shift = ~|b[N-1:5];
	sll_valid_out = valid_shift ? sll_out : 0;
	srl_valid_out = valid_shift ? srl_out : 0;
	sra_valid_out = valid_shift ? sra_out : 0;
end

// Mathematical operations
logic [N-1:0] add_out;
logic add_carry;
logic [N-1:0] sub_out;
logic [N-1:0] sub_in;
logic sub_carry;

adder_n #(.N(N)) ADD (.a(a), .b(b), .c_in(1'b0), .sum(add_out), .c_out(add_carry));
adder_n #(.N(N)) SIN (.a(0), .b(~b), .c_in(1'b1), .sum(sub_in));
adder_n #(.N(N)) SUB (.a(a), .b(sub_in), .c_in(1'b0), .sum(sub_out), .c_out(sub_carry));

// Comparison Operations
logic [N-1:0] slt_out;
logic [N-1:0] sltu_out;

slt #(.N(N)) SLT (.a(a), .b(b), .out(slt_out));
sltu #(.N(N)) SLTU (.a(a), .b(b), .out(sltu_out));

mux16 #(.N(N)) RESULT_MUX (
	// Logical operations
	.in1(and_out), .in2(or_out), .in3(xor_out),
	// Shift operations
	.in5(sll_valid_out), .in6(srl_valid_out), .in7(sra_valid_out),
	// Mathematical operations
	.in8(add_out), .in12(sub_out),
	// Comparison Operations
	.in13(slt_out), .in15(sltu_out),
	// Undefined
	.in0(0), .in4(0), .in9(0),
	.in10(0), .in11(0), .in14(0),
	.switch(control), .out(result)
);

// Overflow calculations
logic add_overflow;
logic sub_overflow;
always_comb begin
	add_overflow = (a[N-1] ~^ b[N-1]) & (a[N-1] ^ add_out[N-1]);
	sub_overflow = (a[N-1] ^ b[N-1]) & (a[N-1] ^ sub_out[N-1]);
end

// Extra outputs
always_comb begin
	overflow = control[3] ? (control[2] ? sub_overflow : add_overflow) : 0;
	equal = &(a ~^ b);
	zero = ~|result;
end


endmodule
