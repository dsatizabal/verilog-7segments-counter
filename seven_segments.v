`default_nettype none
`timescale 1ns/1ns

/*
      --- 1 ---
     |         |
     6         2
     |         |
      --- 7 ---
     |         |
     5         3
     |         |
      --- 4 ---
*/

module seven_segments(
	input wire [3:0] binary,
	output reg [6:0] display
);

	`ifdef COCOTB_SIM
		initial begin
			$dumpfile ("seven_segments_module.vcd");
			$dumpvars (0, seven_segments);
			#1;
		end
	`endif

	always @(*) begin
		case (binary)
			//                    7654321
			4'b0000: display = 7'b0111111;
			4'b0001: display = 7'b0000110;
			4'b0010: display = 7'b1011011;
			4'b0011: display = 7'b1001111;
			4'b0100: display = 7'b1100110;
			4'b0101: display = 7'b1101101;
			4'b0110: display = 7'b1111101;
			4'b0111: display = 7'b0000111;
			4'b1000: display = 7'b1111111;
			4'b1001: display = 7'b1101111;
			default: display = 7'b1111001;
		endcase;
	end;

	`ifdef FORMAL
		always @(*) begin
			_output0_: cover(display == 7'b0111111);
			_output1_: cover(display == 7'b0000110);
			_output2_: cover(display == 7'b1011011);
			_output3_: cover(display == 7'b1001111);
			_output4_: cover(display == 7'b1100110);
			_output5_: cover(display == 7'b1101101);
			_output6_: cover(display == 7'b1111101);
			_output7_: cover(display == 7'b0000111);
			_output8_: cover(display == 7'b0111111);
			_output9_: cover(display == 7'b1101111);
			// _outputE_: cover(display == 7'b1111001); // Only
			// pases when seven_segments is being tested alone
		end;
	`endif

endmodule
