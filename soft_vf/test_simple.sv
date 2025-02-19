`ifndef TEST_SIMPLE_SV
`define TEST_SIMPLE_SV

class test_simple extends test_base;

   `uvm_component_utils(test_simple)

   simple_seq hard_cem_simple_seq;
   simple_seq_axis hard_cem_axis_seq;

   function new(string name = "test_simple", uvm_component parent = null);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      hard_cem_simple_seq = simple_seq::type_id::create("hard_cem_simple_seq");
      hard_cem_axis_seq = simple_seq_axis::type_id::create("hard_cem_axis_seq");
   endfunction : build_phase

   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      fork

         hard_cem_simple_seq.start(hard_env.hard_agent.seqr);
         hard_cem_axis_seq.start(hard_env.hard_agent_axis.seqr);

      join_any
      phase.drop_objection(this);
   endtask : main_phase

endclass

`endif