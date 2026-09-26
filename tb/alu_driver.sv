class alu_driver;
 
 mailbox gen2drv;
 virtual alu_if vif;
 int num_transactions;
 
 
 function new(
 mailbox gen2drv,
 virtual alu_if vif,
 int num_transactions
 );
 
 this.gen2drv = gen2drv;
 this.vif = vif;
 this.num_transactions = num_transactions;
 
 endfunction
 
 
 task run();
 
 alu_transaction trans;
 
 repeat (num_transactions) begin
 
 gen2drv.get(trans);
 
 vif.A = trans.A;
 vif.B = trans.B;
 vif.opcode = trans.opcode;
 
 // Allow the combinational ALU to settle
 #1;
 
 // Tell the Monitor that the transaction is ready
 -> vif.transaction_done;
 
 // Give Monitor time to capture
 #1;
 
 end
 
 endtask
 
 endclass
