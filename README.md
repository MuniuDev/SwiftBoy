# SwiftEmu
Classic GameBoy emulator project written entirely in Swift. 
 
This project is currently under developement and is not yet ready. 

There is still a lot to do, but this project reached the state of what I call: "Cool, I can see the results of my work". Now it's possible to run through all of the bootstrap instructions, display Nintendo logo and play some Tetris or Super Mario Land. You can see how it looks down below:

![](images/emulator.gif)

It still is not ready, as there are some bugs here and there, but it certainly is becoming more and more usefull.

## Features
### What is working
- Bootstrap
- Fast Bootstrap (no bios file required)
- 99% of CPU instructions
- 100% accuracy of CPU instructions (according to Blargg test roms)
- BG, Window and Sprite rendering in PPU
- Interrupts
- Tetris, Super Mario Land
- Raw roms (no MBC) and MBC1 roms
- Emulation speed synchronization

### What is not working
- Sound
- Rest of the memory bank controllers
- STOP instruction
- Some glitches left in PPU
- V-sync
- Serial
- No other games were tested yet

## Tests
This emulator is constantly tested using Blargg's GameBoy test roms. Current results can be seen below:

General CPU Instruction test:

![](images/cpu_instr_test.png)

CPU Instruction timing test:

![](images/cpu_instr_timing_test.png)

## Disclaimer
As this is my first project in Swift it may contain ugly piecies of code, but trust me, I'm working on it.
I currentely decided to push to the master branch, to be able to easily track progress. When this project reaches usable state I will switch to feature branch scheme.
