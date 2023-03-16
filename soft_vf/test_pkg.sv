`ifndef TEST_PKG_SV
`define TEST_PKG_SV

package test_pkg;

	import uvm_pkg::*;      // import the UVM library   
	`include "uvm_macros.svh" // Include the UVM macros

	import agent_pkg::*;
	import agent_pkg_axis::*;
	import seq_pkg::*;
	import configurations_pkg::*;   

	`include "scoreboard.sv" 
	`include "env.sv"   
	`include "test_base.sv"
	`include "test_simple.sv"
	`include "test_simple_2.sv"  


endpackage : test_pkg

 `include "hard_cem_if.sv"

`endif


