module testdecoder;

   reg [31:0] ir;
   reg        clk;
   
   wire [3:0] op;
   wire [31:0] im;
   wire        use_im;
   wire [1:0]  br;

   decoder d(ir, clk, op, im, use_im, br);

   initial begin
      clk <= 0;
      forever #5 clk =~clk;
   end

   initial begin 
      #7 ir <= 32'b1000_0011__11_000_100__0000_0001__1111_1111;
   end

endmodule // testdecoder
