`ifndef AGENT_AXIS_SV
`define AGENT_AXIS_SV

class agent_axis extends uvm_agent;

   // components
   driver_axis drv;
   sequencer_axis seqr;
   monitor_axis mon;
   
   virtual interface hard_cem_if vif;
   
   // configuration
   hard_cem_config cfg;
     
   `uvm_component_utils_begin (agent_axis)
        `uvm_field_object(cfg, UVM_DEFAULT)
        `uvm_field_object(drv, UVM_DEFAULT)
        `uvm_field_object(seqr, UVM_DEFAULT)
        `uvm_field_object(mon, UVM_DEFAULT)
   `uvm_component_utils_end

   function new(string name = "agent_axis", uvm_component parent = null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      if(!uvm_config_db#(hard_cem_config)::get(this, "", "hard_cem_config", cfg))
        `uvm_fatal("NOCONFIG",{"Config object must be set for: ",get_full_name(),".cfg"})
      
      /************Setting to configuration database********************/
         uvm_config_db#(hard_cem_config)::set(this, "mon", "hard_cem_config", cfg);
         uvm_config_db#(hard_cem_config)::set(this, "drv_axis", "hard_cem_config", cfg);

      mon = monitor_axis::type_id::create("mon_axis", this);
      if(cfg.is_active == UVM_ACTIVE) begin
         drv = driver_axis::type_id::create("drv_axis", this);
         seqr = sequencer_axis::type_id::create("seqr_axis", this);
      end
   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(cfg.is_active == UVM_ACTIVE) begin
         drv.seq_item_port.connect(seqr.seq_item_export);
      end
   endfunction : connect_phase

endclass : agent_axis

`endif
