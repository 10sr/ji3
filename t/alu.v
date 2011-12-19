module alu(op, tr, sr, clk, dr, cf, of);
   input [3:0] op;
   input [31:0] tr;
   input [31:0] sr;
   input        clk;
   

   output [31:0] dr;
   output        cf;
   output        of;

   reg [31:0]    dr;
   reg           cf;
   reg           of;
   

   
   // wire [7:0]    sim8;
   
   // assign sim8 <= sim[7:0];

   always @(posedge clk) begin
      of <= 0;
      case (op)
        4'b0000: dr <= tr + sr;      // add
        4'b0001: dr <= tr - sr;      // sub
        4'b0010: dr <= tr == sr;     // cmp
        4'b0011: dr <= tr & sr;      // and
        4'b0100: dr <= tr | sr;      // or
        4'b0101: dr <= tr ^ sr;      // xor
        4'b0110: dr <= ! tr + 1;     // neg
        4'b0111: dr <= ! tr;         // not
        4'b1000: {cf, dr} <= {1'b0, tr} << (sr & 31'o0037);  // sll
        4'b1001: {cf, dr} <= {1'b0, tr} << (sr & 31'o0037);  // sla
        4'b1010: {dr, cf} <= {tr, 1'b0} >> (sr & 31'o0037);  // srl
        4'b1011: {dr, cf} <= {tr, 1'b0} >>> (sr & 31'o0037); // sra
      endcase // case (op)
   end // always @ (posedge clk)
endmodule // alu
