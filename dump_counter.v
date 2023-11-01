module dump();
	initial begin
		$dumpfile ("seven_segments_counter.vcd");
		$dumpvars (0, counter_7seg);
		#1;
	end
endmodule
