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

/* ALU_AND  = 4'b0001, */
/* ALU_OR   = 4'b0010, */
/* ALU_XOR  = 4'b0011, */
/* ALU_SLL  = 4'b0101, */
/* ALU_SRL  = 4'b0110, */
/* ALU_SRA  = 4'b0111, */
/* ALU_ADD  = 4'b1000, */
/* ALU_SUB  = 4'b1100, */
/* ALU_SLT  = 4'b1101, */
/* ALU_SLTU = 4'b1111 */

logic [N-1:0] and_out;
logic [N-1:0] or_out;
logic [N-1:0] xor_out;
logic [N-1:0] sll_out;
logic [N-1:0] srl_out;
logic [N-1:0] sra_out;
logic [N-1:0] add_out;
logic add_carry;
logic [N-1:0] sub_out;
logic sub_carry;
logic [N-1:0] slt_out;
logic [N-1:0] sltu_out;

always_comb begin
	and_out = a & b;
	or_out = a | b;
	xor_out = a ^ b;
end

adder_n #(.N(N)) ADD (.a(a), .b(b), .c_in(1'b0), .sum(add_out), .c_out(add_carry));
adder_n #(.N(N)) SUB (.a(a), .b(~b), .c_in(1'b1), .sum(sub_out), .c_out(sub_carry));



endmodule
