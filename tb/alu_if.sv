interface alu_if();
 
 logic [7:0] A;
 logic [7:0] B;
 logic [2:0] opcode;
 
 logic [7:0] Result;
 logic Carry;
 logic Zero;
 
 
 // Synchronization event
 // Driver triggers this after the ALU has produced the result.
 event transaction_done;
 
 endinterface
