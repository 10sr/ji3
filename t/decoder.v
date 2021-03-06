`define f 0
`define r 1
`define x 2
`define m 3
`define w 4

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

`define B 2'b10
`define BCC 2'b01

module decoder(ir, phase, clk, op, im, use_im, br, ra1, ra2, load_en, wren_mem, wren_reg, cr_taken);
   input [31:0] ir;
   input        clk;
   input [`w:0] phase;

   output [3:0] op;
   output [31:0] im;
   output        use_im;        // use im instead of sr for alu
   output [1:0]  br;
   output [2:0]  ra1, ra2;
   output        load_en;
   output        wren_mem;
   output        wren_reg;
   output        cr_taken;

   reg [3:0]     op;
   reg [31:0]    im;
   reg           use_im;
   reg [1:0]     br;
   reg           load_en;
   reg           wren_mem;
   reg           wren_reg;
   reg           cr_taken;
   reg [2:0]    ra1, ra2;

   reg           _wren_mem, _wren_reg, _cr_taken;

   // assign ra1 = ir[21:19];
   // assign ra2 = ir[18:16];

   always @(posedge clk) begin
      if(phase[`f])
        begin
           ra1 <= ir[21:19];
           ra2 <= ir[18:16];
           case(ir[31:24])
             8'b1000_1011:          // zLD
               begin
                  op <= `LD;
                  im <= 0;
                  use_im <= 0;
                  br <= 2'b00;
                  load_en <= 1;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
               end
             8'b1000_1001:          // zST
               begin
                  op <= `ST;
                  im <= 0;
                  use_im <= 0;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 1;
                  _wren_reg <= 0;
                  _cr_taken <= 0;
               end
             8'b0110_0110:          // zLIL
               begin
                  op <= `LIL;
                  im <= ir[15:8];
                  use_im <= 1;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
               end
             8'b1000_1001:          // zMOV rg2 <- rg1, dr <- sr
               begin
                  op <= `MOV;
                  im <= 0;
                  use_im <= 0;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
               end
             8'b0000_0001:          // zADD
               begin
                  op <= `ADD;
                  im <= 0;
                  use_im <= 0;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
               end
             8'b0010_1001:          // zSUB
               begin
                  op <= `SUB;
                  im <= 0;
                  use_im <= 0;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
               end
             8'b0011_1001:          // zCMP
               begin
                  op <= `CMP;
                  im <= 0;
                  use_im <= 0;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
               end
             8'b0010_0001:          // zAND
               begin
                  op <= `AND;
                  im <= 0;
                  use_im <= 0;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
               end
             8'b0000_1001:          // zOR
               begin
                  op <= `OR;
                  im <= 0;
                  use_im <= 0;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
               end
             8'b0011_0001:          // zXOR
               begin
                  op <= `XOR;
                  im <= 0;
                  use_im <= 0;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
               end
             8'b1000_0011:          // immediate
               begin
                  im <= ir[15:8];
                  use_im <= 1;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
                  case (ir[23:19])
                    8'b11_000: op <= `ADD;
                    8'b11_101: op <= `SUB;
                    8'b11_111: op <= `CMP;
                    8'b11_100: op <= `AND;
                    8'b11_001: op <= `OR;
                    8'b11_110: op <= `XOR;
                  endcase // case (ir[23:19])
               end
             8'b1111_0111:          // zNEG or zNOT
               begin
                  im <= 0;
                  use_im <= 0;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
                  case (ir[23:19])
                    8'b11_011: op <= `NEG;
                    8'b11_010: op <= `NOT;
                  endcase // case (ir[23:19])
               end
             8'b1100_0001:          // shift
               begin
                  im <= ir[15:8];
                  use_im <= 1;
                  br <= 2'b00;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 1;
                  _cr_taken <= 0;
                  case (ir[23:19])
                    8'b11_100: op <= `SLL;
                    8'b11_101: op <= `SRL;
                    8'b11_111: op <= `SRA;
                  endcase // case (ir[23:19])
               end
             8'b1001_0000:          // jmp
               begin
                  op <= `ADD;
                  im <= ir[15:8] + 3;
                  use_im <= 1;
                  load_en <= 0;
                  _wren_mem <= 0;
                  _wren_reg <= 0;
                  _cr_taken <= 1;
                  case (ir[23:20])
                    4'b1110: br <= `B;
                    4'b0111: br <= `BCC;
                  endcase
               end
             8'b1111_0100:          // zHLT
               op <= `HLT;
           endcase // case (ir[31:24] )
        end // if (phase[`r])
      else if(phase[`x]) begin
         wren_mem <= _wren_mem;
         wren_reg <= 0;
         cr_taken <= 0;
      end
      else if(phase[`m]) begin
         wren_mem <= 0;
         wren_reg <= _wren_reg;
         cr_taken <= _cr_taken;
      end else begin
         wren_mem <= 0;
         wren_reg <= 0;
         cr_taken <= 0;
      end
   end // always @ (posedge clk)

endmodule // decoder

