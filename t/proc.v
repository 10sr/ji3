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

   input clk;
   input n_rst;
   output [63:0] seg_out;
   output [7:0] seg_sel;

   wire [`w;0] phase;           // phase signal
   wire r;                      // ring_ctr reset
   wire [31:0] pc;              // program counter
   wire ct_taken;               // if write dr to pc
   wire [7:0] ad_mem;          // memory: address to write or read memory from
   wire [31:0] data_mem;       // memory: data to write to memory
   wire wren_mem;               // memory: write enable of memory
   wire [31:0] ir;              // ir
   wire [31:0] q_mem;           // memory: read data from ad_memory
   wire [2:0] ra1, ra2;         // register: read address
   wire [31:0] rd1, rd2;        // register: read data
   wire [2:0] wa;              // register: write address
   wire [31:0] wd;              // register: write data
   wire we;              // register: write enable
   wire [3:0] op;               // operand used by alu
   wire [31:0] tr, sr;          // alu input
   wire [31:0] dr;              // result of alu
   wire cf, of;

   reg r, ct_taken, wren_mem, we;

   ring_ctr # (`w) rc(r, phase, clk, n_rst);
   pc p(phase, ct_taken, dr, pc, clk, n_rst);
   accessmem am(pc, ad_mem, data_mem, wren_mem, clk, ir, q_mem);
   decoder d(ir, clk, op, im, use_im, br, ra1, ra2);
   register_file r(ra1, ra2, wa, rd1, rd2, wd, we, clk);
   alu a(op, tr, sr, clk, dr, cf, of);

   assign tr = rd1;
   assign sr = use_im ? im : rd2;
   assign wd = ? dr : q_mem

   always @(posedge clk or negedge n_rst) begin
      if(n_rst == 0)
        begin
           ct_taken <= 0;
           wren_mem <= 0;
           we <= 0;
           r = 0;
        end
      else if (phase[`f]);
      else if (phase[`r]);
      else if (phase[`x]);
      
      else if (phase[`m]);
      else if (phase[`w]);
   end
   

endmodule // proc
