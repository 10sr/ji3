`define f 0
`define r 1
`define x 2
`define m 3
`define w 4

// module register(phase, ra1, ra2, wa, sr, tr, wd, clk, n_rst);
//    parameter N = 32;
   
//    input  [`w:0]     	phase;   	// フェーズ信号.
//    input                clk;    	// クロック と リセット
//    input                n_rst;

//    input                ra1;
//    input                ra2;
//    input                wa;
//    output               sr;
//    output               tr;
   
//    reg [N-1:0]          sr;
//    reg [N-1:0]          tr;
//    reg                  we;

//    register_file rf(rg1, rg2, wa);

//    always @(posedge clk or negedge n_rst) begin
// 	  if (n_rst == 0)
// 	    pc <= 0;
// 	  else if (phase[`r] == 1)
// 		pc <= pc + 4;
// 	  else if (phase[`w] == 1  &&  ct_taken == 1)
// 		pc <= dr;
//    end // always
// endmodule

module  register_file(ra1, ra2, wa, rd1, rd2, wd, we, clk);
	input  [ 2:0] ra1, ra2, wa;	// アドレス (番号)
	output [31:0] rd1, rd2;    	// 読み出しデータ
	input  [31:0] wd;         	// 書き込みデータ
	input  we;                  	// ライト・イネーブル
	input  clk;

	reg [31:0] rf [0:7];        	// 32-bit x 8-word レジスタ・ファイル本体
	always @(posedge clk) begin
	    if (we == 1) 
	        rf[wa] <= wd;        	// 書き込み
	end

	assign  rd1 = rf[ra1];  	// 読み出し
	assign  rd2 = rf[ra2];  	// 読み出し

endmodule
