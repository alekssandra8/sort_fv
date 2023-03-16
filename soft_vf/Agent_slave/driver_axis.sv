`ifndef DRIVER_AXIS_SV
`define DRIVER_AXIS_SV

class driver_axis extends uvm_driver#(seq_item_axis);

   `uvm_component_utils(driver_axis)
   
   virtual interface hard_cem_axis_if vif;

   int first_transaction = 1;
   int first_row = 1;


   int num_of_tr = 0;
   hard_cem_config cfg;
   
   function new(string name = "driver_axis", uvm_component parent = null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if (!uvm_config_db#(virtual hard_cem_axis_if)::get(this, "*", "hard_cem_axis_if", vif))
        `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"})


      if(!uvm_config_db#(hard_cem_config)::get(this, "", "hard_cem_config", cfg))
        `uvm_fatal("NOCONFIG",{"Config object must be set for: ",get_full_name(),".cfg"})

   endfunction : build_phase

   task main_phase(uvm_phase phase);
   
      forever begin
		@(posedge vif.clk);	 
		if (vif.rst)
		begin

         vif.s_axis_last_i <= 1'b0;
         // First data will be on the bus before IP is ready
         if (first_transaction) begin

            seq_item_port.get_next_item(req);  //uzme jedan seq item 
            // `uvm_info(get_type_name(), $sformatf("Driver AXIS sending FIRST TRANSACTION...\n%s", req.sprint()), UVM_LOW)
            seq_item_port.item_done();
            vif.s_axis_data_i <= req.s_axis_data_i;
            num_of_tr++;

            first_transaction = 0;            
         end
         
         if(vif.s_axis_ready_o == 1'b1) begin
            
            seq_item_port.get_next_item(req);  //uzme jedan seq item 
            // `uvm_info(get_type_name(), $sformatf("Driver AXIS sending...\n%s", req.sprint()), UVM_LOW)
            seq_item_port.item_done();

            // Stimulate new data
            vif.s_axis_data_i <= req.s_axis_data_i;
            num_of_tr++;

            // Generate axis last signal
            if (!first_row) begin

               if(num_of_tr == cfg.colsize) begin
                  // Data transfer done, regular case
                  num_of_tr = 0;
                  vif.s_axis_last_i <= 1'b1;
               end
            end else begin

               if(num_of_tr == 2*(cfg.colsize)) begin
                  // Data transfer done, first row case
                  num_of_tr = 0;
                  vif.s_axis_last_i <= 1'b1;
                  first_row = 0;
               end
            end


         end

		end
      end
   endtask : main_phase

endclass : driver_axis

`endif


