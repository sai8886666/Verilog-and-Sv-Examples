

class sequence1 extends uvm_sequence#(sequence_item);
  
  	`uvm_object_utils(sequence1)                // registering the seq class in the factory

  	function new(string name = "sequence1");    // construcing the uvm object
    
    		super.new(name);
    
  	endfunction
  
  
  	task body();
		req = sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
	endtask

endclass
