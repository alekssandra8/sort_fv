`ifndef SEQ_ITEM_AXIS_SV
`define SEQ_ITEM_AXIS_SV

parameter DATA_WIDTH = 16;
parameter ADDR_WIDTH = 12;  

parameter C_S00_AXI_DATA_WIDTH = 32;
parameter C_S00_AXI_ADDR_WIDTH = 4;

class seq_item_axis extends uvm_sequence_item;

    
    //Ports of Axi Slave Bus Interface axi_stream_cont
    rand logic [DATA_WIDTH -1:0] s_axis_data_i; 
    logic s_axis_last_i;

    //Ports of Axi Master Bus Interface axi_stream_cont
    logic [DATA_WIDTH -1:0] m_axis_data_o; 
    logic m_axis_valid_o;
    logic m_axis_last_o;

	`uvm_object_utils_begin(seq_item_axis)
	   
		`uvm_field_int(s_axis_data_i, UVM_DEFAULT)
		`uvm_field_int(m_axis_data_o, UVM_DEFAULT)
		`uvm_field_int(s_axis_last_i, UVM_DEFAULT)
		`uvm_field_int(m_axis_valid_o, UVM_DEFAULT)
		`uvm_field_int(m_axis_last_o, UVM_DEFAULT)
        
		
   	`uvm_object_utils_end
	
    function new (string name = "seq_item_axis");
       super.new(name);
    endfunction 

endclass : seq_item_axis

`endif

