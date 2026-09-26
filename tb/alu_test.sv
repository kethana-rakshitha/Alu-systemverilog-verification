module alu_test;
 
 alu_if vif();
 
 alu dut (
 .A(vif.A),
 .B(vif.B),
 .opcode(vif.opcode),
 .Result(vif.Result),
 .Carry(vif.Carry),
 .Zero(vif.Zero)
 );
 
 alu_environment env;
 
 int num_transactions = 100;
 
 initial begin
 
 env = new(vif, num_transactions);
 
 env.run();
 
 $finish;
 
 end
 
 endmodule
