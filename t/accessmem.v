`define f 0
`define r 1
`define x 2
`define m 3
`define w 4

module accessmem(pc, address, data, wren, clk, ir, q);
   input [7:0] pc;
   input [7:0]  address;
   input [31:0] data;
   input        wren;
   input        clk;
   
   output [31:0] ir;
   output [31:0] q;

   mem m(pc, address, clk, 0, data, 0, wren, ir, q);

endmodule // accessmem
