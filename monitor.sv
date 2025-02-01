`define MON_IF vif.mon_mod.MON
class my_monitor extends uvm_monitor;
  `uvm_component_utils(my_monitor)

  virtual sync_fifo_if vif;
  my_transaction req;

  uvm_analysis_port#(my_transaction) mon_ap;
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap=new("mon_ap",this);
    if(!uvm_config_db#(virtual sync_fifo_if)::get(this,"","vif",vif)) begin
      `uvm_fatal(get_type_name(),"VIF is not set")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      req=my_transaction::type_id::create("req"):
      @(vif.mon_mod.MON);
      req.re=`MON_IF.re;
      req.we=`MON_IF.we;
      req.data_in=`MON_IF.data_in;
      req.data_out=`MON_IF.data_out;
      req.full=`MON_IF.full;
      req.empty=`MON_IF.empty;
      `uvm_info(get_type_name(),req.convert2string(),UVM_LOW)
      mon_ap.write(req);
    end
  endtask
endclass
