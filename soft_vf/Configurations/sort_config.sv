
class sort_config extends uvm_object;
    
    uvm_active_passive_enum is_active = UVM_ACTIVE;
		
    `uvm_object_utils_begin (sort_config)
      `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
    `uvm_object_utils_end

    
    function new(string name = "sort_config");
        super.new(name);
    endfunction 
   
endclass : sort_config
