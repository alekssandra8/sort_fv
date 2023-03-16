`ifndef SIMPLE_SEQ_AXIS_SV
 `define SIMPLE_SEQ_AXIS_SV

class simple_seq_axis extends base_seq_axis;

   `uvm_object_utils (simple_seq_axis)

   reg [15:0] mem_content [0 : 24] = '{1, 2, 0, 4, 3,
                                       1, 7, 8, 9, 10,
                                       11, 12, 13, 14, 15,
                                       16, 17, 18, 19, 20,
                                       21, 22, 23, 24, 25};

  
   function new(string name = "simple_seq_axis");
      super.new(name);
      
   endfunction

   virtual task body();
      for (int i = 0; i < 15; i++) begin

        `uvm_do_with(req, {req.s_axis_data_i == mem_content[i];})

      end

   endtask : body

endclass : simple_seq_axis

`endif

