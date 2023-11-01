import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles

seven_segments = [63, 6, 91, 79, 102, 109, 125, 7, 127, 111, 121, 121, 121, 121, 121, 121]

@cocotb.test()
async def no_count_on_reset(dut):
    clock = Clock(dut.clk, 10, "us")
    cocotb.fork(clock.start())

    dut.rst.value = 1
    await ClockCycles(dut.clk, 50)
    dut.rst.value = 0

    assert dut.display == 63, f"Expected 63 but got {dut.display.value}";

@cocotb.test()
async def normal_count(dut):
    clock = Clock(dut.clk, 10, "us")
    cocotb.fork(clock.start())

    dut.rst.value = 1
    await ClockCycles(dut.clk, 5)
    dut.rst.value = 0

    dut.freeze.value = 0

    for i in range(10):
        await ClockCycles(dut.clk, 10)
        assert dut.display == seven_segments[i], f"Expected {seven_segments[i]} but got {dut.display.value}";

@cocotb.test()
async def count_rollover(dut):
    clock = Clock(dut.clk, 10, "us")
    cocotb.fork(clock.start())

    dut.rst.value = 1
    await ClockCycles(dut.clk, 5)
    dut.rst.value = 0

    dut.freeze.value = 0

    for i in range(30):
        await ClockCycles(dut.clk, 10)
        assert dut.display == seven_segments[i % 10], f"Expected {seven_segments[i % 10]} but got {dut.display.value}";

@cocotb.test()
async def no_count_on_freeze(dut):
    clock = Clock(dut.clk, 10, "us")
    cocotb.fork(clock.start())

    dut.rst.value = 1
    await ClockCycles(dut.clk, 5)
    dut.rst.value = 0

    dut.freeze.value = 0

    expected = 0

    for i in range(30):
        if (i >= 9):
            dut.freeze.value = 1
            expected = seven_segments[9]
        else:
            expected = seven_segments[i]

        await ClockCycles(dut.clk, 10)
        assert dut.display == expected, f"Expected {expected} but got {dut.display.value}";

