`ifndef SIMPLE_SEQ_SV
 `define SIMPLE_SEQ_SV

class simple_seq extends base_seq;

   `uvm_object_utils (simple_seq)
  
   logic [31 : 0] COLSIZE = 5;
   logic [31 : 0] ROWSIZE = 3; 

   // // Matrix multiplier core's address map
   // int COL_REG_ADDR_C = 0;
   // int ROW_REG_ADDR_C = 4;
   // int CMD_REG_ADDR_C = 8;
   // int STATUS_REG_ADDR_C = 12;

   function new(string name = "simple_seq");
      super.new(name);
      
   endfunction

   virtual task body();
   
        //Load template to BRAM ////p_sequencer.cfg.tmpl_cols * p_sequencer.cfg.tmpl_rows
        
        //Sending COLSIZE
        `uvm_do_with(req, {req.s00_axi_awaddr == 4'b0000; req.s00_axi_wdata == COLSIZE;})
                     
        //Sending ROWSIZE
        `uvm_do_with(req, {req.s00_axi_awaddr == 4'b0100; req.s00_axi_wdata == ROWSIZE;})
        
        /****************************************************************/

         //Sending start bit
        `uvm_do_with(req, {req.s00_axi_awaddr == 4'b1000; req.s00_axi_wdata == 1;})
        //Disabling start bit
        `uvm_do_with(req, {req.s00_axi_awaddr == 4'b1000; req.s00_axi_wdata == 0;})

        /****************************************************************/        

   endtask : body

endclass : simple_seq

`endif

