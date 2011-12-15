module testalu;

   reg [3:0] op, [31:0] tr, [31:0] sr, [31:0] dr, cf;
   
   alu a(op, tr, sr, dr, cf);
   
   initial begin
      #10 op <= 3'b0000; tr <= 32; sr <= 21;
      #10 op <= 3'b0001;
      #10 op <= 3'b0010;
      #10 op <= 3'b0011;
      #10 op <= 3'b0100;
      #10 op <= 3'b0101;
      #10 op <= 3'b0110;
      #10 op <= 3'b0111;
      #10 op <= 3'b1000; sr <= 3;
      #10 op <= 3'b1001;
      #10 op <= 3'b1010;
      #10 op <= 3'b1011;
   end // initial begin
endmodule // testalu
