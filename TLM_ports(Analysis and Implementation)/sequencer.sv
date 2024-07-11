
class sequencer extends uvm_sequencer#(sequence_item);
  
  	`uvm_component_utils(sequencer)                                // registering the sequencer class in the factory
  
  	function new(string name = "sequencer", uvm_component parent);   // constructing the uvm component
    
    	super.new(name,parent);
    
  	endfunction
  
  
endclass
