class alu_generator;
 
 mailbox gen2drv;
 int num_transactions;
 
 function new(mailbox gen2drv, int num_transactions);
 
 this.gen2drv = gen2drv;
 this.num_transactions = num_transactions;
 
 endfunction
 
 
 task run();
 
 alu_transaction trans;
 
 repeat (num_transactions) begin
 
 trans = new();
 
 assert(trans.randomize())
 else $fatal("Randomization failed");
 
 gen2drv.put(trans);
 
 end
 
 endtask
 
 endclass
