`ifndef VERIF_TOP_SV
 `define VERIF_TOP_SV
 
 module verif_top;

   import uvm_pkg::*;     // import the UVM library
   `include "uvm_macros.svh" // Include the UVM macros

   import test_pkg::*;

   logic clk;
   logic rst;
    
   // interface
	my_ram_if sort_vif_master (clk, reset);
	my_ram_if sort_vif_slave (clk, reset);

   sort_top DUT(
			.clk (clk),
			.reset (rst),
			// for slave 
			.en1 (sort_vif_slave.en1),
			.w_en (sort_vif_slave.w_en1),
			.w_data1 (sort_vif_slave.w_data1),
			.r_data1 (sort_vif_slave.r_data1),
			.addr1 (sort_vif_slave.addr1),
			.r_data2 (sort_vif_slave.r_data2),
			.addr2 (sort_vif_slave.r_data2),
			
			.tready (sort_vif_slave.tready),
			.tvalid (sort_vif_slave.tvalid),
			.tlast (sort_vif_slave.tlast),
			.tdata (sort_vif_slave.tdata),
			.oready (sort_vif_slave.oready),
			.ovalid (sort_vif_slave.ovalid),
			.olast (sort_vif_slave.olast),
			.odata (sort_vif_slave.odata),
			
			// for master
			.en1 (sort_vif_master.en1),
			.w_en1 (sort_vif_master.w_en1),
			.w_data1 (sort_vif_master.w_data1),
			.r_data1 (sort_vif_master.r_data1),
			.addr1 (sort_vif_slave.addr1),
			.r_data2 (sort_vif_master.r_data2),
			.addr2 (sort_vif_master.r_data2),
			
			.tready (sort_vif_master.tready),
			.tvalid (sort_vif_master.tvalid),
			.tlast (sort_vif_master.tlast),
			.tdata (sort_vif_master.tdata),
			.oready (sort_vif_master.oready),
			.ovalid (sort_vif_master.ovalid),
			.olast (sort_vif_master.olast),
			.odata (sort_vif_master.odata)
            );
                           

   // run test
   initial begin   
   
	  uvm_config_db#(virtual sort_vif_slave)::set(null, "*", "sort_vif_slave", sort_vif_slave);
      uvm_config_db#(virtual sort_vif_master)::set(null, "*", "sort_vif_master", sort_vif_master);
	  run_test();
   end
    
   // clock and reset init.
   initial begin
      clk <= 1;
      rst <= 0;
      #500 rst <= 1;
	  //dodati potrebnu inicijalizaciju
   end

   // clock generation
   always #30 clk = ~clk;
   
endmodule : verif_top

`endif

