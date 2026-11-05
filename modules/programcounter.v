`include "bus.vh"

module programcounter(clk, rst, stall, branch, branchpc, pc);
	input wire clk;
	input wire rst;
	input wire stall;
	input wire branch;
	input wire [`WORDSIZE-1:0] branchpc;
	output reg [`WORDSIZE-1:0] pc;

	initial
		pc <= {`WORDSIZE{1'b0}};

	always @(posedge clk or posedge rst)
		if (rst)
			pc <= {`WORDSIZE{1'b0}};
		// A resolved branch redirects even if a younger load-use hazard stalls.
		else if (branch)
			pc <= branchpc;
		else if (!stall)
			pc <= pc + 'd4;
endmodule
