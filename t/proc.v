`define ADD 4'b0000
`define SUB 4'b0001
`define CMP 4'b0010
`define AND 4'b0011
`define OR 4'b0100
`define XOR 4'b0101
`define NEG 4'b0110
`define NOT 4'b0111
`define SLL 4'b1000
`define SRL 4'b1001
`define SRA 4'b1010

`define f 0
`define r 1
`define x 2
`define m 3
`define w 4

module proc(clk, n_rst, seg_out, seg_sel);

   ring_ctr # (`w) rc(r, q, clk, n_rst);
   pc p(phase, ct_taken, dr, pc, clk, n_rst);
   accessmem am(pc, address, data, wren, clk, ir, q);
   decoder d(ir, clk, op, im, use_im, br);
   alu a(op, tr, sr, clk, dr, cf, of);

   always @(posedge clk) begin
      if (phase[`f]);
      else if (phase[`r]);
      else if (phase[`x]);
      else if (phase[`m]);
      else if (phase[`w]);
   end
   

endmodule // proc
