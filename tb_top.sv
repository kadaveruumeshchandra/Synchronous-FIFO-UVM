`include "interface.sv"
`include "tb_pkg.sv"
`include "design.v"
module tb_top;
  import uvm_pkg::*;
  import tb_pkg::*;

  bit clk,reset;

  sync_fifo_if vif(.clk(clk),.reset(reset));
  sync_fifo dut(.clk(clk),.reset(reset),.data_in(vif.data_in),.data_out(vif.data_out),.we(vif.we),.re(vif.re),.empty(vif.empty),.full(vif.full));

  initial begin
    uvm_config_db#(virtual sync_fifo_if)::set(uvm_root::get(),"*","vif",vif);
  end

  initial begin
    reset=1;
    clk=0;
    #10 reset=0;
  end

  always #5 clk=~clk;

  initial begin
    run_test("base_test");
  end
endmodule
