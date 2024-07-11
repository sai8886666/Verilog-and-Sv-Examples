
  `include"interface.sv"

//  `include"assertion.sv"

package pkg;
  
  `include"uvm_macros.svh"
  
  import uvm_pkg::*;
  


  `include"sequence_item.sv"
  
  `include"sequence.sv"
  
  `include"sequencer.sv"
  
  `include"driver.sv"
  
  `include"input_monitor.sv"
  
  `include"output_monitor.sv"
  
  `include"active_agent.sv"
  
  `include"passive_agent.sv"
  
  `include"scoreboard.sv"
  
 // `include"coverage.sv"
  
  `include"environment.sv"
  
  `include"test.sv"
endpackage
