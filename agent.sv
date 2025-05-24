class my_agent extends from uvm_agent;
  `uvm_component_utils(my_agent)

  my_sequencer sqr;
  my_driver drv;
  my_monitor mon;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sqr=my_sequencer::type_id::create("sqr",this);
    drv=my_driver::type_id::create("drv",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction
endclass

  
