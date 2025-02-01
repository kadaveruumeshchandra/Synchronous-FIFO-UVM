interface sync_fifo_if(input clk,reset);
  logic we;
  logic re;
  logic [7:0]data_in;
  logic [7:0]data_out;
  logic full;
  logic empty;

  clocking DRV@(posedge clk);
    default input #1 output #1;
    input data_out;
    input empty;
    input full;
    output we;
    output re;
    output data_in;
  endclocking

  clocking MON@(posedge clk);
    default input #1 output #1;
    input data_in;
    input we;
    input re;
    input data_out;
    input full;
    input empty;
  endclocking

  modport drv_mod(clocking DRV,input clk,reset);
  modport mon_mod(clocking MON,input clk,reset);
endinterface
