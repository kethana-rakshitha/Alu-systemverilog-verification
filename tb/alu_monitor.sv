class alu_monitor;
 
 mailbox mon2scb;
 virtual alu_if vif;
 int num_transactions;
 
 
 // =========================================================
 // Functional Coverage
 // =========================================================
 
 covergroup alu_coverage with function sample(
 logic [7:0] A,
 logic [7:0] B,
 logic [2:0] opcode
 );
 
 // Opcode coverage
 coverpoint opcode {
 
 bins ADD = {3'b000};
 bins SUB = {3'b001};
 bins AND_OP = {3'b010};
 bins OR_OP = {3'b011};
 bins XOR_OP = {3'b100};
 bins NOT_OP = {3'b101};
 bins LSHIFT = {3'b110};
 bins RSHIFT = {3'b111};
 
 }
 
 
 // A value coverage
 coverpoint A {
 
 bins ZERO = {8'd0};
 bins MAX = {8'd255};
 bins OTHER = {[8'd1:8'd254]};
 
 }
 
 
 // B value coverage
 coverpoint B {
 
 bins ZERO = {8'd0};
 bins MAX = {8'd255};
 bins OTHER = {[8'd1:8'd254]};
 
 }
 
 endgroup
 
 
 // =========================================================
 // Constructor
 // =========================================================
 
 function new(
 mailbox mon2scb,
 virtual alu_if vif,
 int num_transactions
 );
 
 this.mon2scb = mon2scb;
 this.vif = vif;
 this.num_transactions = num_transactions;
 
 alu_coverage = new();
 
 endfunction
 
 
 // =========================================================
 // Monitor
 // =========================================================
 
 task run();
 
 alu_transaction trans;
 
 
 repeat (num_transactions) begin
 
 // Wait until Driver tells us that the
 // current transaction is ready.
 @(vif.transaction_done);
 
 
 // Create transaction object
 trans = new();
 
 
 // Capture DUT inputs
 trans.A = vif.A;
 trans.B = vif.B;
 trans.opcode = vif.opcode;
 
 
 // Capture DUT outputs
 trans.Result = vif.Result;
 trans.Carry = vif.Carry;
 trans.Zero = vif.Zero;
 
 
 // =================================================
 // Immediate Assertion
 // =================================================
 
 assert (
 ((trans.Result == 8'b0) &&
 (trans.Zero == 1'b1))
 ||
 ((trans.Result != 8'b0) &&
 (trans.Zero == 1'b0))
 )
 else
 $error(
 "ASSERTION FAILED: Zero flag incorrect. Result=%0d Zero=%0d",
 trans.Result,
 trans.Zero
 );
 
 
 // =================================================
 // Functional Coverage Sampling
 // =================================================
 
 alu_coverage.sample(
 trans.A,
 trans.B,
 trans.opcode
 );
 
 
 // =================================================
 // Send transaction to Scoreboard
 // =================================================
 
 mon2scb.put(trans);
 
 end
 
 endtask
 
 endclass
