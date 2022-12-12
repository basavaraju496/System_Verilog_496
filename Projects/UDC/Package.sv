`define CLK_PERIOD 4
`define END_SIMULATION  300

`include"0_dut.v"

`include"1_transaction.sv"

`include"2_generator.sv"

`include"0_interface.sv"

`include"3_driver.sv"

`include"4.3_ip_monitor.sv"

`include"5_output_monitor.sv"


`include"6_scoreboard.sv"


`include"10_Coverage.sv"

`include"7_environment.sv"

`include"8_test.sv"

`include"9_top.sv"
