module dump();
	initial begin
		$dumpfile ("seven_segments_module.vcd");
		$dumpvars (0, seven_segments);
		#1;
	end
endmodule
