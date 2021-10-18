open_project ./xilinx/01_game_of_life.xpr
add_files { main.sv conway_cell.sv decoder_1_to_2.sv decoder_2_to_4.sv decoder_3_to_8.sv led_array_driver.sv adder_1_2.sv adder_2_3.sv adder_3_4.sv }

reset_run synth_1
reset_run impl_1
launch_runs synth_1
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

close_project 
