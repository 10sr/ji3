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

module decoder(ir, clk);
   inut [31:0] ir;
   input clk;

   reg [3:0] op;
   reg [31:0] tr;
   reg [31:0] sr;

   wire [31:0] dr;
   wire        cf;
   wire        of;
   
   alu a(op, tr, sr, clk, dr, cf, of);
   
   always @(posedge clk) begin
      case(ir[31:24] )
        8'b1000_1011:          // zLD
          
        8'b1000_1001:          // zST
        
        8'b0110_0110:          // zLIL
        
        8'b1000_1001:          // zMOV
        
        8'b0000_0001:          // zADD
          begin
             op <= `ADD;
             
        8'b0010_1001:          // zSUB
        8'b0011_1001:          // zCMP
        8'b0010_0001:          // zAND
        8'b0000_1001:          // zOR
        8'b0011_0001:          // zXOR
        
        8'b1000_0011:          // immediate
        
        8'b1111_0111:          // zNEG or ZNOT
        
        8'b1100_0001:          // shift
        
        8'b1001_0000:          // jmp
        8'b1111_0100:          // zHLT
   end

   function 
   
endmodule // decoder

