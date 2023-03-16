`ifndef TEST_BASE_SV
`define TEST_BASE_SV

class test_base extends uvm_test;

   sort_env env;
   sort_config cfg;

   `uvm_component_utils(test_base)

   function new(string name = "test_base", uvm_component parent = null);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      cfg = sort_config::type_id::create("cfg"); 
      uvm_config_db#(sort_config)::set(this, "env", "sort_config", cfg);      
      env = sort_env::type_id::create("env", this);      
   endfunction : build_phase

   function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology();
   endfunction : end_of_elaboration_phase

endclass : test_base

`endif

