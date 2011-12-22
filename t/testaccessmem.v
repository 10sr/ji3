module testaccessmem;

   reg [7:0] pc;
   reg [7:0] address;
   reg [31:0] data;
   reg wren;
   reg clk;

   wire [31:0] ir;
   wire [31:0] q;

   accessmem am(pc, address, data, wren, clk, ir, q);

   initial begin
      clk <= 0;
      forever #5 clk = ~clk;
   end

   initial begin
      #3 pc <= 8'b0000_0000;
      address <= 8'b0000_0001;
      data <= 32'h1111_1111;
      wren <= 0;
      #20 wren <= 1;
   end
endmodule // testaccessmem


