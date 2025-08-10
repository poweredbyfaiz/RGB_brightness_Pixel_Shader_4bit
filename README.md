# RGB_brightness_Pixel_Shader_4bit

A compact FPGA demo that performs per-pixel brightness adjustment on 4-bit RGB channels.
This project is intentionally small and hardware-friendly so it can be demonstrated on a Basys 3 board.

## What it does
- Inputs: 4-bit Red, Green, Blue (SW switches)
- Brightness: 4-bit control (SW)
- Output: adjusted 4-bit RGB on LEDs (binary representation)
- Clamps values at the 4-bit maximum (15) to avoid overflow

## Files
- `src/pixel_shader_4bit.v` : core combinational shader logic
- `src/top_basys3.v`       : board wrapper (maps SW->shader->LED)
- `sim/tb_pixel_shader_4bit.v` : small testbench for simulation
- `constraints/basys3_short.xdc` : recommended pin mapping for Basys 3
- `docs/` : add waveform.png (Vivado screenshot) and schematic.png

## How to run 
1. Create a new RTL project in Vivado (Basys 3 board).
2. Add `src/*.v` and `sim/*.v`.
3. Add `constraints/basys3_short.xdc` to the project.
4. Simulate using the testbench to verify functionality.
5. Synthesize, implement, and generate a bitstream.
6. Program the Basys 3 board and use SW0–SW15 to drive inputs.

## Design notes 
- Design is deliberately 4-bit to fit Basys 3 I/O without external hardware.
- Combinational block — no clock required; immediate updates from switches.
- Easy to extend: replace 4-bit buses with 8-bit buses and use external IO or BRAM for full-color demos.
