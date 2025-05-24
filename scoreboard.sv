class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)

  sb_predictor prd;
  sb_comparator cmp;

  uvm_analysis_export#(my_transaction)axp_in;

  function new(string name,uvm_component parent);
    super.new(name,parent);
    axp_in=new("axp_in",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    prd=sb_predictor::type_id::create("prd",this);
    cmp=sb_comparator::type_id::create("cmp",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    axp_in.connect(prd.analysis_export);
    axp_in.connect(cmp.axp_out);
    prd.results_ap.connect(cmp.axp_in);
  endfunction
endclass
