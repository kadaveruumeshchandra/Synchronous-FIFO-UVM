class my_sequence extends uvm_sequence#(my_transaction);
  `uvm_object_utils(my_sequence)

  function new(string name="my_sequence"):
    super.new(name);
  endfunction

  task body();
    my_transaction req;
    req=my_transaction::type_id::create("req"):
    repeat(10) begin
      start_item(req);
      assert(req.randomize());
      finish_item(req);
      `uvm_info(get_type_name(),req.convert2string(),UVM_LOW)
    end
  endtask
endclass
