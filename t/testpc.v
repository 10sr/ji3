`define f 0
`define w 4

module testpc;
   reg clk;
   reg n_rst;
   reg [2:0] phase;
   reg ct_taken;
   reg [31:0] dr;
   wire [31:0] pc;

   pc pc1(phase, ct_taken, dr, pc, clk, n_rst);

   initial begin
      clk <= 0;
      ct_taken <= 0;
      phase <= `f;
      dr <= 0;
      n_rst <= 1;
      
      forever #5 clk = ~clk;
   end

   initial begin
      # 8 n_rst = 0;
      # 13 n_rst = 1;
      // # 1000 $finish;
   end

endmodule // testpc

