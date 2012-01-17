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
`define MOV 4'b1011
`define LD 4'b1100
`define ST 4'b1101
`define LIL 4'b1110
`define HLT 4'b1111

// CMP does not work at all.

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
        `LIL: dr <= sr;
        4'b1000: {cf, dr} <= {1'b0, tr} << (sr & 31'o0037);  // sll, sla
        4'b1001: {dr, cf} <= {tr, 1'b0} >> (sr & 31'o0037);  // srl
        4'b1010: {dr, cf} <= {tr, 1'b0} >>> (sr & 31'o0037); // sra
      endcase // case (op)
   end // always @ (posedge clk)
endmodule // alu
