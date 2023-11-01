`default_nettype none
`timescale 1ns/1ns

module counter_7seg(
	input wire clk,
	input wire rst,
	input wire freeze,
	output wire [6:0] display
);

	reg [19:0] counter;
	reg [3:0] digit;

	initial begin
		$dumpfile ("seven_segments_counter.vcd");
		$dumpvars (0, counter_7seg);
		#1;
	end

	`ifdef COCOTB_SIM
		localparam MAX_COUNT = 8'h09;
	`else
		localparam MAX_COUNT = 20'h00009;
	`endif


	always @(posedge clk or posedge rst) begin
		if (rst) begin
			counter <= 20'h0000;
			digit <= 4'b0;
		end else begin
			if (!freeze) begin
				if (counter < MAX_COUNT) begin
					counter <= counter + 1'b1;
				end else begin
					counter <= 20'h00000;

					if (digit >= 9) begin
						digit <= 4'b0;
					end else begin
						digit <= digit + 1'b1;
					end
				end;
			end;
		end;

	end;

	// Instantiate seven segments module
	seven_segments seven_segments(.binary(digit), .display(display));

	`ifdef FORMAL
		reg past_valid = 0;
		initial assume(rst);
		initial assume(counter ==0);

		always @(posedge clk) begin

			if (!rst && past_valid) begin
				_counteroutput0_: cover(display == 7'b0111111);
				_counteroutput1_: cover(display == 7'b0000110 && $past(counter) == 0);
				_counteroutput2_: cover(display == 7'b1011011 && $past(counter) == 1);
				_counteroutput3_: cover(display == 7'b1001111 && $past(counter) == 2);
				_counteroutput4_: cover(display == 7'b1100110 && $past(counter) == 3);
				_counteroutput5_: cover(display == 7'b1101101 && $past(counter) == 4);
				_counteroutput6_: cover(display == 7'b1111101 && $past(counter) == 5);
				_counteroutput7_: cover(display == 7'b0000111 && $past(counter) == 6);
				_counteroutput8_: cover(display == 7'b0111111 && $past(counter) == 7);
				_counteroutput9_: cover(display == 7'b1101111 && $past(counter) == 8);
			end;
			
			past_valid <= 1;
		end;
	`endif

endmodule
