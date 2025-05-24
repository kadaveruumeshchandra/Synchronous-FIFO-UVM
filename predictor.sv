class sb_predictor extends uvm_subscriber#(my_transaction);
  `uvm_component_utils(sb_predictor)

  uvm_analysis_port#(my_transaction)results_ap;

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    results_ap=new9"results_ap",this);
  endfunction

  function void write(my_transaction t);
    my_transaction exp_tr;
    exp_tr=sb_calc_exp(t);
    results_ap.write(exp_tr);
  endfunction
  extern function my_transaction sb_calc_exp(my_transaction t);
endclass

function my_transaction sb_predictor::sb_calc_exp(my_transaction t);
  static bit [7:0]prev_out[$];
  my_transaction trans;
  trans=my_transaction::type_id::create("trans");
  trans.copy(t);
  if(~trans.reset) begin
    if(trans.we && ~trans.full) begin
      prev_out.push_back(trans.data_in);
    end
    if(trans.re && ~trans.empty) begin
      trans.data_out<=prev_out.pop_front();
    end
  end
  else begin
    trans.data_out<=trans.data_in;
  end
  return trans;
endfunction
      
