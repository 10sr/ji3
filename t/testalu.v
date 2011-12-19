module testalu;

   reg [3:0] op;
   reg [31:0] tr;
   reg [31:0] sr;
   reg        clk;

   wire [31:0] dr;
   wire        cf;
   wire        of;
   
   
   alu a(op, tr, sr, clk, dr, cf, of);

   initial begin
      clk <= 0;
      forever #5 clk = ~clk;
   end
   
   
   initial begin
      #8 op <= 4'b0000; tr <= 32; sr <= 21;
      #10 op <= 4'b0001;
      #10 op <= 4'b0010;
      #10 op <= 4'b0011;
      #10 op <= 4'b0100;
      #10 op <= 4'b0101;
      #10 op <= 4'b0110;
      #10 op <= 4'b0111;
      #10 op <= 4'b1000; sr <= 3;
      #10 op <= 4'b1001;
      #10 op <= 4'b1010;
      #10 op <= 4'b1011;
   end // initial begin
endmodule // testalu
