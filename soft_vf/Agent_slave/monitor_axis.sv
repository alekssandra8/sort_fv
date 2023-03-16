`ifndef MONITOR_AXIS_SV
`define MONITOR_AXIS_SV

class monitor_axis extends uvm_monitor;

   // control fileds
   hard_cem_config cfg;

   uvm_analysis_port #(seq_item_axis) item_collected_port;

   `uvm_component_utils_begin(monitor_axis)
   `uvm_component_utils_end

   // The virtual interface used to drive and view HDL signals.
   virtual interface hard_cem_axis_if vif;

   // current transaction
   seq_item_axis curr_it, clone_curr_it;
   // int ref_data_flag = 0;

   // coverage can go here
   // ...

   function new(string name = "monitor_axis", uvm_component parent = null);
        super.new(name,parent);      
   endfunction


   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      curr_it = seq_item_axis::type_id::create("curr_it", this);

      item_collected_port = new("item_collected_port", this);

      if (!uvm_config_db#(virtual hard_cem_axis_if)::get(this, "*", "hard_cem_axis_if", vif))
        `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})
      
   endfunction : build_phase

   task main_phase(uvm_phase phase);
      forever begin
      @(posedge vif.clk); 
		if (vif.rst)

		begin
			
         curr_it.s_axis_last_i = vif.s_axis_last_i;
         curr_it.m_axis_last_o = vif.m_axis_last_o;
         
         if(vif.monitor_valid_data_o == 1'b1) 
         begin

               // sending input data which will be used in ref model
               curr_it.s_axis_data_i = vif.s_axis_data_i;
               `uvm_info("MON_AXIS", $sformatf("DUT -> MON, AXIS_DATA_IN:%0d\n", curr_it.s_axis_data_i), UVM_HIGH);

               if(curr_it.s_axis_last_i == 1'b1) begin
                  `uvm_info("MON_AXIS", $sformatf("LAST DATA SENT! LAST_SIGNAL: %0d\n", curr_it.s_axis_last_i), UVM_HIGH);
               end

               $cast(clone_curr_it, curr_it.clone());
               item_collected_port.write(clone_curr_it);
         end
             
         curr_it.m_axis_valid_o = vif.m_axis_valid_o;

			if (vif.m_axis_valid_o == 1'b1) 
			begin
            
               `uvm_info("M VALID", $sformatf("#### VALID FLAG SIGNAL ####: %0d\n", curr_it.m_axis_valid_o), UVM_HIGH);
               // sending output data which will be compared with ref model 
               curr_it.m_axis_data_o = vif.m_axis_data_o;
               `uvm_info("MON_AXIS", $sformatf("DUT -> MON, VALID_AXIS_DATA_OUT:%0d\n", curr_it.m_axis_data_o), UVM_HIGH);

               $cast(clone_curr_it, curr_it.clone());
               item_collected_port.write(clone_curr_it);

			end 

		end
      end
   endtask : main_phase

endclass : monitor_axis


`endif