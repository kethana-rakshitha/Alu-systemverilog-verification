module alu #(parameter WIDTH = 8) (
 
 input logic [WIDTH-1:0] A,
 input logic [WIDTH-1:0] B,
 input logic [2:0] opcode,
 
 output logic [WIDTH-1:0] Result,
 output logic Carry,
 output logic Zero
 
 );
 
 always_comb begin
 
 // Default values
 Result = '0;
 Carry = 1'b0;
 
 case (opcode)
 
 3'b000: begin
 {Carry, Result} = A + B;
 end
 
 3'b001: begin
 Result = A - B;
 end
 
 3'b010: begin
 Result = A & B;
 end
 
 3'b011: begin
 Result = A | B;
 end
 
 3'b100: begin
 Result = A ^ B;
 end
 
 3'b101: begin
 Result = ~A;
 end
 
 3'b110: begin
 Result = A << 1;
 end
 
 3'b111: begin
 Result = A >> 1;
 end
 
 endcase
 
 Zero = (Result == '0);
 
 end
 
 endmodule
