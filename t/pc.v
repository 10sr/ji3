`define f 0
`define r 1
`define x 2
`define m 3
`define w 4

module pc(phase, ct_taken, dr, pc, clk, n_rst);
   // parameter N = 32;

   input  [`w:0]     	phase;   	// フェーズ信号.
   input                ct_taken;	// 分岐成立．zB, zJR などでも 1
   input [31:0]        dr;
   input                clk;    	// クロック と リセット
   input                n_rst;
   
   output [7:0]       pc;
   
   reg [7:0]          pc;
   always @(posedge clk or negedge n_rst) begin
	  if (n_rst == 0)
	  pc <= 0;
	  else if (phase[`f] == 1)
		pc <= pc + 1;
	  else if (phase[`w] == 1  &&  ct_taken == 1)
		pc <= dr[7:0];
   end // always
endmodule
