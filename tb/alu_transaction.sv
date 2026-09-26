class alu_transaction;
 
 // Random stimulus
 rand logic [7:0] A;
 rand logic [7:0] B;
 rand logic [2:0] opcode;
 
 // DUT response
 logic [7:0] Result;
 logic Carry;
 logic Zero;
 
 // Legal opcode range
 constraint valid_opcode {
 opcode inside {[0:7]};
 }
 
 // Give more importance to boundary values
 constraint interesting_values {
 
 A dist {
 8'd0 := 10,
 8'd255 := 10,
 [8'd1:8'd254] :/ 80
 };
 
 B dist {
 8'd0 := 10,
 8'd255 := 10,
 [8'd1:8'd254] :/ 80
 };
 }
 
 endclass
