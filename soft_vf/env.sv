`ifndef ENV_SV
 `define ENV_SV

class env extends uvm_env;

   agent hard_agent;
   agent_axis hard_agent_axis;
   hard_cem_config cfg;
   scoreboard scbd;

   virtual interface hard_cem_if vif;
   `uvm_component_utils (env)

   function new(string name = "env", uvm_component parent = null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      hard_agent = agent::type_id::create("hard_agent", this);
      hard_agent_axis = agent_axis::type_id::create("hard_agent_axis", this);
      scbd = scoreboard::type_id::create("scbd", this);
      	
      if(!uvm_config_db#(hard_cem_config)::get(this, "", "hard_cem_config", cfg))
        `uvm_fatal("NOCONFIG",{"Config object must be set for: ",get_full_name(),".cfg"})
      
        /************Setting to configuration database********************/
      uvm_config_db#(hard_cem_config)::set(this, "hard_agent", "hard_cem_config", cfg);
      uvm_config_db#(hard_cem_config)::set(this, "hard_agent_axis", "hard_cem_config", cfg);
      uvm_config_db#(hard_cem_config)::set(this, "scbd", "hard_cem_config", cfg);
      /*****************************************************************/

   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      hard_agent.mon.item_collected_port.connect(scbd.item_collected_import_axil);

      //AXIS connection
      hard_agent_axis.mon.item_collected_port.connect(scbd.item_collected_import_axis);

   endfunction : connect_phase

endclass : env

`endif

