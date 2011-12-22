module ring_ctr (r, q, clk, n_rst);
   parameter N = 32;
   input  r, clk, n_rst;
   output [N - 1 : 0] q;
   
   reg [N-1:0]        q;
   always @(posedge clk or negedge n_rst) begin
	  if (n_rst == 0)
        q <= 1;
      else if (r == 1 || q[N-1] == 1)
		q <= 1;
	  else // if(clk == 1)
		q <= q << 1;
	  // endif
   end // always
endmodule // ring_ctr
