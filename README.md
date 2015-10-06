# SwiftEmu
Classic GameBoy emulator project written entirely in Swift. 
 
This project is currently under heavy developement and is not yet ready. 

There is still a lot to do, but this project reached the state of what I call: "Cool, I can see the results of my work". Now it's possible to run through all of the bootstrap instructions, display Nintendo logo and play some Tetris. You can see how it looks down below:

![](emulator.gif)

It still is not ready, as there are some bugs in Tetris I need to address (e.g. score is not counting) but it certainly is becoming more and more usefull. As of right now no other games were tested.

## Features
### What is working
- Bootstrap
- 99% of CPU instructions
- Most of the PPU features
- Interrupt mechanism
- Tetris

### What is not working
- Sound
- Memory bank controllers of any sort
- STOP and HALT instructions
- Window mode in PPU
- V-sync
- Some interrupts


## Disclaimer
As this is my first project in Swift it may contain ugly piecies of code, but trust me, I'm working on it.
I currentely decided to push to the master branch, to be able to easily track progress. When this project reaches usable state I will switch to feature branch scheme.
