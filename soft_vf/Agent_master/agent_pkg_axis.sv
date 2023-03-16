`ifndef AGENT_PKG_AXIS
`define AGENT_PKG_AXIS

package agent_pkg_axis;
 
   import uvm_pkg::*;
   `include "uvm_macros.svh"

   //////////////////////////////////////////////////////////
   // include Agent components : driver,monitor,sequencer
   /////////////////////////////////////////////////////////
   import configurations_pkg::*;   
   
   
   `include "seq_item_axis.sv"
   `include "sequencer_axis.sv"
   `include "driver_axis.sv"
   `include "monitor_axis.sv"
   `include "agent_axis.sv"
   

endpackage

`endif




