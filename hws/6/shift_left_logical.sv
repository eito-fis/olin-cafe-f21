module shift_left_logical(in, shamt, out);

parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

input wire [N-1:0] in;            // the input number that will be shifted left. Fill in the remainder with zeros.
input wire [$clog2(N)-1:0] shamt; // the amount to shift by (think of it as a decimal number from 0 to 31). 
output logic [N-1:0] out;       

// Theoretically this is enough, but maybe this is cheating
/* always_comb begin */
/* 	out = in << shamt; */
/* end */

// Thank god for python...
mux32 OUT_BLOCK_0 (
	.in0(in[0]), .in1(0), .in2(0), .in3(0), .in4(0), .in5(0), .in6(0), .in7(0),
	.in8(0), .in9(0), .in10(0), .in11(0), .in12(0), .in13(0), .in14(0), .in15(0),
	.in16(0), .in17(0), .in18(0), .in19(0), .in20(0), .in21(0), .in22(0), .in23(0),
	.in24(0), .in25(0), .in26(0), .in27(0), .in28(0), .in29(0), .in30(0), .in31(0),
	.switch(shamt), .out(out[0])
);

mux32 OUT_BLOCK_1 (
	.in0(in[1]), .in1(in[0]), .in2(0), .in3(0), .in4(0), .in5(0), .in6(0), .in7(0),
	.in8(0), .in9(0), .in10(0), .in11(0), .in12(0), .in13(0), .in14(0), .in15(0),
	.in16(0), .in17(0), .in18(0), .in19(0), .in20(0), .in21(0), .in22(0), .in23(0),
	.in24(0), .in25(0), .in26(0), .in27(0), .in28(0), .in29(0), .in30(0), .in31(0),
	.switch(shamt), .out(out[1])
);

mux32 OUT_BLOCK_2 (
	.in0(in[2]), .in1(in[1]), .in2(in[0]), .in3(0), .in4(0), .in5(0), .in6(0),
	.in7(0), .in8(0), .in9(0), .in10(0), .in11(0), .in12(0), .in13(0), .in14(0),
	.in15(0), .in16(0), .in17(0), .in18(0), .in19(0), .in20(0), .in21(0), .in22(0),
	.in23(0), .in24(0), .in25(0), .in26(0), .in27(0), .in28(0), .in29(0), .in30(0),
	.in31(0), .switch(shamt), .out(out[2])
);

mux32 OUT_BLOCK_3 (
	.in0(in[3]), .in1(in[2]), .in2(in[1]), .in3(in[0]), .in4(0), .in5(0), .in6(0),
	.in7(0), .in8(0), .in9(0), .in10(0), .in11(0), .in12(0), .in13(0), .in14(0),
	.in15(0), .in16(0), .in17(0), .in18(0), .in19(0), .in20(0), .in21(0), .in22(0),
	.in23(0), .in24(0), .in25(0), .in26(0), .in27(0), .in28(0), .in29(0), .in30(0),
	.in31(0), .switch(shamt), .out(out[3])
);

mux32 OUT_BLOCK_4 (
	.in0(in[4]), .in1(in[3]), .in2(in[2]), .in3(in[1]), .in4(in[0]), .in5(0),
	.in6(0), .in7(0), .in8(0), .in9(0), .in10(0), .in11(0), .in12(0), .in13(0),
	.in14(0), .in15(0), .in16(0), .in17(0), .in18(0), .in19(0), .in20(0), .in21(0),
	.in22(0), .in23(0), .in24(0), .in25(0), .in26(0), .in27(0), .in28(0), .in29(0),
	.in30(0), .in31(0), .switch(shamt), .out(out[4])
);

mux32 OUT_BLOCK_5 (
	.in0(in[5]), .in1(in[4]), .in2(in[3]), .in3(in[2]), .in4(in[1]), .in5(in[0]),
	.in6(0), .in7(0), .in8(0), .in9(0), .in10(0), .in11(0), .in12(0), .in13(0),
	.in14(0), .in15(0), .in16(0), .in17(0), .in18(0), .in19(0), .in20(0), .in21(0),
	.in22(0), .in23(0), .in24(0), .in25(0), .in26(0), .in27(0), .in28(0), .in29(0),
	.in30(0), .in31(0), .switch(shamt), .out(out[5])
);

mux32 OUT_BLOCK_6 (
	.in0(in[6]), .in1(in[5]), .in2(in[4]), .in3(in[3]), .in4(in[2]), .in5(in[1]),
	.in6(in[0]), .in7(0), .in8(0), .in9(0), .in10(0), .in11(0), .in12(0), .in13(0),
	.in14(0), .in15(0), .in16(0), .in17(0), .in18(0), .in19(0), .in20(0), .in21(0),
	.in22(0), .in23(0), .in24(0), .in25(0), .in26(0), .in27(0), .in28(0), .in29(0),
	.in30(0), .in31(0), .switch(shamt), .out(out[6])
);

mux32 OUT_BLOCK_7 (
	.in0(in[7]), .in1(in[6]), .in2(in[5]), .in3(in[4]), .in4(in[3]), .in5(in[2]),
	.in6(in[1]), .in7(in[0]), .in8(0), .in9(0), .in10(0), .in11(0), .in12(0),
	.in13(0), .in14(0), .in15(0), .in16(0), .in17(0), .in18(0), .in19(0), .in20(0),
	.in21(0), .in22(0), .in23(0), .in24(0), .in25(0), .in26(0), .in27(0), .in28(0),
	.in29(0), .in30(0), .in31(0), .switch(shamt), .out(out[7])
);

mux32 OUT_BLOCK_8 (
	.in0(in[8]), .in1(in[7]), .in2(in[6]), .in3(in[5]), .in4(in[4]), .in5(in[3]),
	.in6(in[2]), .in7(in[1]), .in8(in[0]), .in9(0), .in10(0), .in11(0), .in12(0),
	.in13(0), .in14(0), .in15(0), .in16(0), .in17(0), .in18(0), .in19(0), .in20(0),
	.in21(0), .in22(0), .in23(0), .in24(0), .in25(0), .in26(0), .in27(0), .in28(0),
	.in29(0), .in30(0), .in31(0), .switch(shamt), .out(out[8])
);

mux32 OUT_BLOCK_9 (
	.in0(in[9]), .in1(in[8]), .in2(in[7]), .in3(in[6]), .in4(in[5]), .in5(in[4]),
	.in6(in[3]), .in7(in[2]), .in8(in[1]), .in9(in[0]), .in10(0), .in11(0),
	.in12(0), .in13(0), .in14(0), .in15(0), .in16(0), .in17(0), .in18(0), .in19(0),
	.in20(0), .in21(0), .in22(0), .in23(0), .in24(0), .in25(0), .in26(0), .in27(0),
	.in28(0), .in29(0), .in30(0), .in31(0), .switch(shamt), .out(out[9])
);

mux32 OUT_BLOCK_10 (
	.in0(in[10]), .in1(in[9]), .in2(in[8]), .in3(in[7]), .in4(in[6]), .in5(in[5]),
	.in6(in[4]), .in7(in[3]), .in8(in[2]), .in9(in[1]), .in10(in[0]), .in11(0),
	.in12(0), .in13(0), .in14(0), .in15(0), .in16(0), .in17(0), .in18(0), .in19(0),
	.in20(0), .in21(0), .in22(0), .in23(0), .in24(0), .in25(0), .in26(0), .in27(0),
	.in28(0), .in29(0), .in30(0), .in31(0), .switch(shamt), .out(out[10])
);

mux32 OUT_BLOCK_11 (
	.in0(in[11]), .in1(in[10]), .in2(in[9]), .in3(in[8]), .in4(in[7]), .in5(in[6]),
	.in6(in[5]), .in7(in[4]), .in8(in[3]), .in9(in[2]), .in10(in[1]), .in11(in[0]),
	.in12(0), .in13(0), .in14(0), .in15(0), .in16(0), .in17(0), .in18(0), .in19(0),
	.in20(0), .in21(0), .in22(0), .in23(0), .in24(0), .in25(0), .in26(0), .in27(0),
	.in28(0), .in29(0), .in30(0), .in31(0), .switch(shamt), .out(out[11])
);

mux32 OUT_BLOCK_12 (
	.in0(in[12]), .in1(in[11]), .in2(in[10]), .in3(in[9]), .in4(in[8]), .in5(in[7]),
	.in6(in[6]), .in7(in[5]), .in8(in[4]), .in9(in[3]), .in10(in[2]), .in11(in[1]),
	.in12(in[0]), .in13(0), .in14(0), .in15(0), .in16(0), .in17(0), .in18(0),
	.in19(0), .in20(0), .in21(0), .in22(0), .in23(0), .in24(0), .in25(0), .in26(0),
	.in27(0), .in28(0), .in29(0), .in30(0), .in31(0), .switch(shamt), .out(out[12])
);

mux32 OUT_BLOCK_13 (
	.in0(in[13]), .in1(in[12]), .in2(in[11]), .in3(in[10]), .in4(in[9]),
	.in5(in[8]), .in6(in[7]), .in7(in[6]), .in8(in[5]), .in9(in[4]), .in10(in[3]),
	.in11(in[2]), .in12(in[1]), .in13(in[0]), .in14(0), .in15(0), .in16(0),
	.in17(0), .in18(0), .in19(0), .in20(0), .in21(0), .in22(0), .in23(0), .in24(0),
	.in25(0), .in26(0), .in27(0), .in28(0), .in29(0), .in30(0), .in31(0),
	.switch(shamt), .out(out[13])
);

mux32 OUT_BLOCK_14 (
	.in0(in[14]), .in1(in[13]), .in2(in[12]), .in3(in[11]), .in4(in[10]),
	.in5(in[9]), .in6(in[8]), .in7(in[7]), .in8(in[6]), .in9(in[5]), .in10(in[4]),
	.in11(in[3]), .in12(in[2]), .in13(in[1]), .in14(in[0]), .in15(0), .in16(0),
	.in17(0), .in18(0), .in19(0), .in20(0), .in21(0), .in22(0), .in23(0), .in24(0),
	.in25(0), .in26(0), .in27(0), .in28(0), .in29(0), .in30(0), .in31(0),
	.switch(shamt), .out(out[14])
);

mux32 OUT_BLOCK_15 (
	.in0(in[15]), .in1(in[14]), .in2(in[13]), .in3(in[12]), .in4(in[11]),
	.in5(in[10]), .in6(in[9]), .in7(in[8]), .in8(in[7]), .in9(in[6]), .in10(in[5]),
	.in11(in[4]), .in12(in[3]), .in13(in[2]), .in14(in[1]), .in15(in[0]), .in16(0),
	.in17(0), .in18(0), .in19(0), .in20(0), .in21(0), .in22(0), .in23(0), .in24(0),
	.in25(0), .in26(0), .in27(0), .in28(0), .in29(0), .in30(0), .in31(0),
	.switch(shamt), .out(out[15])
);

mux32 OUT_BLOCK_16 (
	.in0(in[16]), .in1(in[15]), .in2(in[14]), .in3(in[13]), .in4(in[12]),
	.in5(in[11]), .in6(in[10]), .in7(in[9]), .in8(in[8]), .in9(in[7]), .in10(in[6]),
	.in11(in[5]), .in12(in[4]), .in13(in[3]), .in14(in[2]), .in15(in[1]),
	.in16(in[0]), .in17(0), .in18(0), .in19(0), .in20(0), .in21(0), .in22(0),
	.in23(0), .in24(0), .in25(0), .in26(0), .in27(0), .in28(0), .in29(0), .in30(0),
	.in31(0), .switch(shamt), .out(out[16])
);

mux32 OUT_BLOCK_17 (
	.in0(in[17]), .in1(in[16]), .in2(in[15]), .in3(in[14]), .in4(in[13]),
	.in5(in[12]), .in6(in[11]), .in7(in[10]), .in8(in[9]), .in9(in[8]),
	.in10(in[7]), .in11(in[6]), .in12(in[5]), .in13(in[4]), .in14(in[3]),
	.in15(in[2]), .in16(in[1]), .in17(in[0]), .in18(0), .in19(0), .in20(0),
	.in21(0), .in22(0), .in23(0), .in24(0), .in25(0), .in26(0), .in27(0), .in28(0),
	.in29(0), .in30(0), .in31(0), .switch(shamt), .out(out[17])
);

mux32 OUT_BLOCK_18 (
	.in0(in[18]), .in1(in[17]), .in2(in[16]), .in3(in[15]), .in4(in[14]),
	.in5(in[13]), .in6(in[12]), .in7(in[11]), .in8(in[10]), .in9(in[9]),
	.in10(in[8]), .in11(in[7]), .in12(in[6]), .in13(in[5]), .in14(in[4]),
	.in15(in[3]), .in16(in[2]), .in17(in[1]), .in18(in[0]), .in19(0), .in20(0),
	.in21(0), .in22(0), .in23(0), .in24(0), .in25(0), .in26(0), .in27(0), .in28(0),
	.in29(0), .in30(0), .in31(0), .switch(shamt), .out(out[18])
);

mux32 OUT_BLOCK_19 (
	.in0(in[19]), .in1(in[18]), .in2(in[17]), .in3(in[16]), .in4(in[15]),
	.in5(in[14]), .in6(in[13]), .in7(in[12]), .in8(in[11]), .in9(in[10]),
	.in10(in[9]), .in11(in[8]), .in12(in[7]), .in13(in[6]), .in14(in[5]),
	.in15(in[4]), .in16(in[3]), .in17(in[2]), .in18(in[1]), .in19(in[0]), .in20(0),
	.in21(0), .in22(0), .in23(0), .in24(0), .in25(0), .in26(0), .in27(0), .in28(0),
	.in29(0), .in30(0), .in31(0), .switch(shamt), .out(out[19])
);

mux32 OUT_BLOCK_20 (
	.in0(in[20]), .in1(in[19]), .in2(in[18]), .in3(in[17]), .in4(in[16]),
	.in5(in[15]), .in6(in[14]), .in7(in[13]), .in8(in[12]), .in9(in[11]),
	.in10(in[10]), .in11(in[9]), .in12(in[8]), .in13(in[7]), .in14(in[6]),
	.in15(in[5]), .in16(in[4]), .in17(in[3]), .in18(in[2]), .in19(in[1]),
	.in20(in[0]), .in21(0), .in22(0), .in23(0), .in24(0), .in25(0), .in26(0),
	.in27(0), .in28(0), .in29(0), .in30(0), .in31(0), .switch(shamt), .out(out[20])
);

mux32 OUT_BLOCK_21 (
	.in0(in[21]), .in1(in[20]), .in2(in[19]), .in3(in[18]), .in4(in[17]),
	.in5(in[16]), .in6(in[15]), .in7(in[14]), .in8(in[13]), .in9(in[12]),
	.in10(in[11]), .in11(in[10]), .in12(in[9]), .in13(in[8]), .in14(in[7]),
	.in15(in[6]), .in16(in[5]), .in17(in[4]), .in18(in[3]), .in19(in[2]),
	.in20(in[1]), .in21(in[0]), .in22(0), .in23(0), .in24(0), .in25(0), .in26(0),
	.in27(0), .in28(0), .in29(0), .in30(0), .in31(0), .switch(shamt), .out(out[21])
);

mux32 OUT_BLOCK_22 (
	.in0(in[22]), .in1(in[21]), .in2(in[20]), .in3(in[19]), .in4(in[18]),
	.in5(in[17]), .in6(in[16]), .in7(in[15]), .in8(in[14]), .in9(in[13]),
	.in10(in[12]), .in11(in[11]), .in12(in[10]), .in13(in[9]), .in14(in[8]),
	.in15(in[7]), .in16(in[6]), .in17(in[5]), .in18(in[4]), .in19(in[3]),
	.in20(in[2]), .in21(in[1]), .in22(in[0]), .in23(0), .in24(0), .in25(0),
	.in26(0), .in27(0), .in28(0), .in29(0), .in30(0), .in31(0), .switch(shamt),
	.out(out[22])
);

mux32 OUT_BLOCK_23 (
	.in0(in[23]), .in1(in[22]), .in2(in[21]), .in3(in[20]), .in4(in[19]),
	.in5(in[18]), .in6(in[17]), .in7(in[16]), .in8(in[15]), .in9(in[14]),
	.in10(in[13]), .in11(in[12]), .in12(in[11]), .in13(in[10]), .in14(in[9]),
	.in15(in[8]), .in16(in[7]), .in17(in[6]), .in18(in[5]), .in19(in[4]),
	.in20(in[3]), .in21(in[2]), .in22(in[1]), .in23(in[0]), .in24(0), .in25(0),
	.in26(0), .in27(0), .in28(0), .in29(0), .in30(0), .in31(0), .switch(shamt),
	.out(out[23])
);

mux32 OUT_BLOCK_24 (
	.in0(in[24]), .in1(in[23]), .in2(in[22]), .in3(in[21]), .in4(in[20]),
	.in5(in[19]), .in6(in[18]), .in7(in[17]), .in8(in[16]), .in9(in[15]),
	.in10(in[14]), .in11(in[13]), .in12(in[12]), .in13(in[11]), .in14(in[10]),
	.in15(in[9]), .in16(in[8]), .in17(in[7]), .in18(in[6]), .in19(in[5]),
	.in20(in[4]), .in21(in[3]), .in22(in[2]), .in23(in[1]), .in24(in[0]), .in25(0),
	.in26(0), .in27(0), .in28(0), .in29(0), .in30(0), .in31(0), .switch(shamt),
	.out(out[24])
);

mux32 OUT_BLOCK_25 (
	.in0(in[25]), .in1(in[24]), .in2(in[23]), .in3(in[22]), .in4(in[21]),
	.in5(in[20]), .in6(in[19]), .in7(in[18]), .in8(in[17]), .in9(in[16]),
	.in10(in[15]), .in11(in[14]), .in12(in[13]), .in13(in[12]), .in14(in[11]),
	.in15(in[10]), .in16(in[9]), .in17(in[8]), .in18(in[7]), .in19(in[6]),
	.in20(in[5]), .in21(in[4]), .in22(in[3]), .in23(in[2]), .in24(in[1]),
	.in25(in[0]), .in26(0), .in27(0), .in28(0), .in29(0), .in30(0), .in31(0),
	.switch(shamt), .out(out[25])
);

mux32 OUT_BLOCK_26 (
	.in0(in[26]), .in1(in[25]), .in2(in[24]), .in3(in[23]), .in4(in[22]),
	.in5(in[21]), .in6(in[20]), .in7(in[19]), .in8(in[18]), .in9(in[17]),
	.in10(in[16]), .in11(in[15]), .in12(in[14]), .in13(in[13]), .in14(in[12]),
	.in15(in[11]), .in16(in[10]), .in17(in[9]), .in18(in[8]), .in19(in[7]),
	.in20(in[6]), .in21(in[5]), .in22(in[4]), .in23(in[3]), .in24(in[2]),
	.in25(in[1]), .in26(in[0]), .in27(0), .in28(0), .in29(0), .in30(0), .in31(0),
	.switch(shamt), .out(out[26])
);

mux32 OUT_BLOCK_27 (
	.in0(in[27]), .in1(in[26]), .in2(in[25]), .in3(in[24]), .in4(in[23]),
	.in5(in[22]), .in6(in[21]), .in7(in[20]), .in8(in[19]), .in9(in[18]),
	.in10(in[17]), .in11(in[16]), .in12(in[15]), .in13(in[14]), .in14(in[13]),
	.in15(in[12]), .in16(in[11]), .in17(in[10]), .in18(in[9]), .in19(in[8]),
	.in20(in[7]), .in21(in[6]), .in22(in[5]), .in23(in[4]), .in24(in[3]),
	.in25(in[2]), .in26(in[1]), .in27(in[0]), .in28(0), .in29(0), .in30(0),
	.in31(0), .switch(shamt), .out(out[27])
);

mux32 OUT_BLOCK_28 (
	.in0(in[28]), .in1(in[27]), .in2(in[26]), .in3(in[25]), .in4(in[24]),
	.in5(in[23]), .in6(in[22]), .in7(in[21]), .in8(in[20]), .in9(in[19]),
	.in10(in[18]), .in11(in[17]), .in12(in[16]), .in13(in[15]), .in14(in[14]),
	.in15(in[13]), .in16(in[12]), .in17(in[11]), .in18(in[10]), .in19(in[9]),
	.in20(in[8]), .in21(in[7]), .in22(in[6]), .in23(in[5]), .in24(in[4]),
	.in25(in[3]), .in26(in[2]), .in27(in[1]), .in28(in[0]), .in29(0), .in30(0),
	.in31(0), .switch(shamt), .out(out[28])
);

mux32 OUT_BLOCK_29 (
	.in0(in[29]), .in1(in[28]), .in2(in[27]), .in3(in[26]), .in4(in[25]),
	.in5(in[24]), .in6(in[23]), .in7(in[22]), .in8(in[21]), .in9(in[20]),
	.in10(in[19]), .in11(in[18]), .in12(in[17]), .in13(in[16]), .in14(in[15]),
	.in15(in[14]), .in16(in[13]), .in17(in[12]), .in18(in[11]), .in19(in[10]),
	.in20(in[9]), .in21(in[8]), .in22(in[7]), .in23(in[6]), .in24(in[5]),
	.in25(in[4]), .in26(in[3]), .in27(in[2]), .in28(in[1]), .in29(in[0]), .in30(0),
	.in31(0), .switch(shamt), .out(out[29])
);

mux32 OUT_BLOCK_30 (
	.in0(in[30]), .in1(in[29]), .in2(in[28]), .in3(in[27]), .in4(in[26]),
	.in5(in[25]), .in6(in[24]), .in7(in[23]), .in8(in[22]), .in9(in[21]),
	.in10(in[20]), .in11(in[19]), .in12(in[18]), .in13(in[17]), .in14(in[16]),
	.in15(in[15]), .in16(in[14]), .in17(in[13]), .in18(in[12]), .in19(in[11]),
	.in20(in[10]), .in21(in[9]), .in22(in[8]), .in23(in[7]), .in24(in[6]),
	.in25(in[5]), .in26(in[4]), .in27(in[3]), .in28(in[2]), .in29(in[1]),
	.in30(in[0]), .in31(0), .switch(shamt), .out(out[30])
);

mux32 OUT_BLOCK_31 (
	.in0(in[31]), .in1(in[30]), .in2(in[29]), .in3(in[28]), .in4(in[27]),
	.in5(in[26]), .in6(in[25]), .in7(in[24]), .in8(in[23]), .in9(in[22]),
	.in10(in[21]), .in11(in[20]), .in12(in[19]), .in13(in[18]), .in14(in[17]),
	.in15(in[16]), .in16(in[15]), .in17(in[14]), .in18(in[13]), .in19(in[12]),
	.in20(in[11]), .in21(in[10]), .in22(in[9]), .in23(in[8]), .in24(in[7]),
	.in25(in[6]), .in26(in[5]), .in27(in[4]), .in28(in[3]), .in29(in[2]),
	.in30(in[1]), .in31(in[0]), .switch(shamt), .out(out[31])
);

endmodule
