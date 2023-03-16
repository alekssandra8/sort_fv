`ifndef SEQUENCER_AXIS_SV
`define SEQUENCER_AXIS_SV

class sequencer_axis extends uvm_sequencer#(seq_item_axis);

   `uvm_component_utils(sequencer_axis)

   function new(string name = "sequencer_axis", uvm_component parent = null);
      super.new(name,parent);
   endfunction
   
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
  endfunction

endclass : sequencer_axis

`endif


