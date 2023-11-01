# cocotb setup
MODULE = test
TOPLEVEL = seven_segments
VERILOG_SOURCES = seven_segments.v counter.v

include $(shell cocotb-config --makefiles)/Makefile.sim

synth_seven_segments:
	yosys -p "read_verilog seven_segments.v; proc; opt; show -colors 2 -width -signed seven_segments"

synth_counter:
	yosys -p "read_verilog counter.v; proc; opt; show -colors 2 -width -signed counter_7seg"

test_seven_segments:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s seven_segments -s dump -g2012 dump_seven_segments.v seven_segments.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_seven_segments vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
	! grep failure results.xml

test_counter:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s counter_7seg -s dump -g2012 dump_counter.v counter.v seven_segments.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_counter vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
	! grep failure results.xml

gtkwave_seven_segments:
	gtkwave seven_segments_module.vcd

gtkwave_counter:
	gtkwave seven_segments_counter.vcd

formal_seven_segments:
	sby -f seven_segments.sby

formal_counter:
	sby -f counter.sby
