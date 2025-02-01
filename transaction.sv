class my_transaction extends uvm_sequence_item;
  `uvm_object_utils(my_transaction)
  rand bit [7:0]data_in;
  rand bit we;
  rand bit re;
  bit [7:0]data_out;
  bit reset;
  bit full;
  bit empty;

  constraint we_re{we==~re;}

  function new(string name="my_transaction");
    super.new(name);
  endfunction

  virtual function void do_copy(uvm_object rhs);
    my_transaction tr;
    $cast(tr,rhs);
    super.do_copy(rhs);
    we=tr.we;
    re=tr.re;
    data_in=tr.data_in;
    data_out=tr.data_out;
    full=tr.full;
    empty=tr.empty;
    reset=tr.reset;
  endfunction

  function string convert2string;
    string s;
    s=$sformatf("we:%0b re:%0b data_in:%0b data_out:%0b full:%0d empty:%0d",we,re,data_in,data_out,full,empty);
    return s;
  endfunction

  virtual function bit do_compare(uvm_object rhs,uvm_comparer comparer);
    bit res;
    my_transaction _pkt;
    $cast(_pkt,rhs);
    super.do_compare(_pkt,comparer);
    res=super.do_compare(_pkt,comparer) & (we==_pkt.we) & (re==_pkt.re) & (data_in==_pkt.data_in) & (data_out==_pkt.data_out) & (full==_pkt.full) & (empty==_pkt.empty);
    return res;
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_int("re",re,$bits(re),UVM_HEX);
    printer.print_int("we",we,$bits(we),UVM_HEX);
    printer.print_int("data_in",data_in,$bits(data_in),UVM_HEX);
    printer.print_int("data_out",data_out,$bits(data_out),UVM_HEX);
    printer.print_int("full",full,$bits(full),UVM_HEX);
    printer.print_int("empty",empty,$bits(empty),UVM_HEX);
  endfunction
endclass
