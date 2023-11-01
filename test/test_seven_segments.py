import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test(dut):
    dut.binary.value = 0;
    await Timer(1, units="us");
    assert dut.display == 63, f"Expected 63 but got {dut.display.value}";

    dut.binary.value = 1;
    await Timer(1, units="us");
    assert dut.display == 6, f"Expected 6 but got {dut.display.value}";

    dut.binary.value = 2;
    await Timer(1, units="us");
    assert dut.display == 91, f"Expected 91 but got {dut.display.value}";

    dut.binary.value = 3;
    await Timer(1, units="us");
    assert dut.display == 79, f"Expected 79 but got {dut.display.value}";

    dut.binary.value = 4;
    await Timer(1, units="us");
    assert dut.display == 102, f"Expected 102 but got {dut.display.value}";

    dut.binary.value = 5;
    await Timer(1, units="us");
    assert dut.display == 109, f"Expected 109 but got {dut.display.value}";

    dut.binary.value = 6;
    await Timer(1, units="us");
    assert dut.display == 125, f"Expected 125 but got {dut.display.value}";

    dut.binary.value = 7;
    await Timer(1, units="us");
    assert dut.display == 7, f"Expected 7 but got {dut.display.value}";

    dut.binary.value = 8;
    await Timer(1, units="us");
    assert dut.display == 127, f"Expected 127 but got {dut.display.value}";

    dut.binary.value = 9;
    await Timer(1, units="us");
    assert dut.display == 111, f"Expected 111 but got {dut.display.value}";

    dut.binary.value = 10;
    await Timer(1, units="us");
    assert dut.display == 121, f"Expected 121 but got {dut.display.value}";

    dut.binary.value = 11;
    await Timer(1, units="us");
    assert dut.display == 121, f"Expected 121 but got {dut.display.value}";

    dut.binary.value = 12;
    await Timer(1, units="us");
    assert dut.display == 121, f"Expected 121 but got {dut.display.value}";
