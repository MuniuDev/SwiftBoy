# SwiftBoy
Classic GameBoy emulator project written entirely in Swift. 
 
This project is currently in alpha stage but is very usable. 

Most of the games should be playable, if there are not please create an issue on github. My main focus is now on implementing sound and improving the UI for the first beta release. Any feedback is welcomed. You can see how it looks down below:

![](images/emulator.gif)

It even runs Pokemon Blue flawlessly! Checkout this [video](https://www.youtube.com/watch?v=mHkm-G8RO1c).

![](images/emulator-pokemon.png)

It is certainly ready for usage. I encourage everyone to try it yourself.


## Keymaping
- D-pad - keyboard arrows
- A - Z
- B - X
- START - Enter
- SELECT - Space Bar

## Features
### What is working
- Bootstrap
- Fast Bootstrap (no bios file required)
- 99% of CPU instructions
- 100% accuracy of CPU instructions (according to Blargg test roms)
- BG, Window and Sprite rendering in PPU (both 8x8 and 8x16)
- There seems to be no more major bugs in PPU
- Interrupts
- Tetris, Super Mario Land, Castlevania, Pokemon Red/Blue/Yellow, Zelda, Alladin, and probably many more ;)
- Raw roms (no MBC), MBC1, MBC3 and MBC5 roms (this is about 90% of games released for DMG)
- Emulation speed synchronization
- Fast OpenGL rendering with v-sync
- New better UI
- Rom loading from popup (File -> Open Rom)
- Persistent saves and RTC (files are saved in your documents folder in SwiftBoySaves folder)


### What is not working
- Sound
- MBC2, MBC6, MBC7
- STOP instruction
- Serial
- New UI lacks a lot of features
- Savestates

## Tests
This emulator is constantly tested using Blargg's GameBoy test roms. Current results can be seen below:

General CPU Instruction test:

![](images/cpu_instr_test.png)

CPU Instruction timing test:

![](images/cpu_instr_timing_test.png)

## Disclaimer
Main branch should now be stable (no rebases and force pushes), all of the developement is done on the feature branches.
