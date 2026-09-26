class alu_scoreboard;
 
 mailbox mon2scb;
 int num_transactions;
 
 int pass_count = 0;
 int fail_count = 0;
 int transaction_count = 0;
 
 
 function new(
 mailbox mon2scb,
 int num_transactions
 );
 
 this.mon2scb = mon2scb;
 this.num_transactions = num_transactions;
 
 endfunction
 
 
 task run();
 
 alu_transaction trans;
 
 logic [7:0] expected_result;
 logic expected_carry;
 logic expected_zero;
 
 
 repeat (num_transactions) begin
 
 mon2scb.get(trans);
 
 transaction_count++;
 
 expected_result = 8'b0;
 expected_carry = 1'b0;
 
 
 case (trans.opcode)
 
 // ADD
 3'b000: begin
 {expected_carry, expected_result}
 = trans.A + trans.B;
 end
 
 // SUB
 3'b001: begin
 expected_result = trans.A - trans.B;
 end
 
 // AND
 3'b010: begin
 expected_result = trans.A & trans.B;
 end
 
 // OR
 3'b011: begin
 expected_result = trans.A | trans.B;
 end
 
 // XOR
 3'b100: begin
 expected_result = trans.A ^ trans.B;
 end
 
 // NOT
 3'b101: begin
 expected_result = ~trans.A;
 end
 
 // LEFT SHIFT
 3'b110: begin
 expected_result = trans.A << 1;
 end
 
 // RIGHT SHIFT
 3'b111: begin
 expected_result = trans.A >> 1;
 end
 
 default: begin
 expected_result = 8'b0;
 end
 
 endcase
 
 
 // Calculate expected Zero flag
 expected_zero = (expected_result == 8'b0);
 
 
 // Compare Expected vs Actual
 if ((trans.Result == expected_result) &&
 (trans.Carry == expected_carry) &&
 (trans.Zero == expected_zero)) begin
 
 pass_count++;
 
 $display(
 "PASS: ID=%0d A=%0d B=%0d Opcode=%0d Expected=%0d Actual=%0d",
 transaction_count,
 trans.A,
 trans.B,
 trans.opcode,
 expected_result,
 trans.Result
 );
 
 end
 else begin
 
 fail_count++;
 
 $display(
 "FAIL: ID=%0d A=%0d B=%0d Opcode=%0d Expected=%0d Actual=%0d",
 transaction_count,
 trans.A,
 trans.B,
 trans.opcode,
 expected_result,
 trans.Result
 );
 
 end
 
 end
 
 
 // Final scoreboard summary
 $display("========================================");
 $display(" SCOREBOARD SUMMARY ");
 $display("========================================");
 $display("Total Transactions : %0d", transaction_count);
 $display("PASS : %0d", pass_count);
 $display("FAIL : %0d", fail_count);
 $display("========================================");
 
 endtask
 
 endclass
