`ifndef SEQ_PKG_SV
`define SEQ_PKG_SV

package seq_pkg;

	import uvm_pkg::*;      // import the UVM library
	`include "uvm_macros.svh" // Include the UVM macros
	import agent_pkg::seq_item;
	import agent_pkg::sequencer;
	`include "base_seq.sv"
	`include "simple_seq.sv"
	
	import agent_pkg_axis::seq_item_axis;
	import agent_pkg_axis::sequencer_axis;
	`include "base_seq_axis.sv"
	`include "simple_seq_axis.sv"

endpackage : seq_pkg
`endif
