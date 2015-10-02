//
//  GameBoyCPU.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyCPU {
    var registers: GameBoyRegisters
    var memory: GameBoyRAM
    var timer: GameBoyTimer
    var opcodes: [OpCode]
    var extOpcodes: [OpCode]
    var interruptMasterFlag: Bool
    
    init(memory mem: GameBoyRAM) {
        registers = GameBoyRegisters()
        memory = mem;
        opcodes = generateOpCodeTable()
        extOpcodes = generateExtOpCodeTable()
        timer = GameBoyTimer(memory: memory)
        interruptMasterFlag = false
    }
    
    func tic() {
        HandleInterrupts()
        let opCodeVal = memory.read(address: registers.PC)
        let opCode = opcodes[Int(opCodeVal)]
        
        if opCode.instruction != nil {
            //print("Called: \"" + opCode.name + "\" of code: 0x" + String(format:"%2X", opCodeVal) + ". PC=" + String(format:"%4X",registers.PC))
            opCode.instruction!(cpu: self)
        } else {
            print("ERROR: Unimplemented instruction \"" + opCode.name + "\" of code: 0x" + String(format:"%2X", opCodeVal) + " found in PC=" + String(format:"%4X", registers.PC))
            exit(-1)
        }
        
    }
    
    func HandleInterrupts() {
        if !interruptMasterFlag { return }
        let IE = memory.read(address: GameBoyRAM.IE)
        let IF = memory.read(address: GameBoyRAM.IF)
        
        if (IE & IF & GameBoyRAM.I_P10P13) != 0 { // P10-P13 terminal negative edge
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = GameBoyRAM.JMP_I_P10P13
            memory.write(address: GameBoyRAM.IF, value: IF & ~GameBoyRAM.I_P10P13)
            return
        }
        if (IE & IF & GameBoyRAM.I_SERIAL) != 0 { // Serial transfer completion
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = GameBoyRAM.JMP_I_SERIAL
            memory.write(address: GameBoyRAM.IF, value: IF & ~GameBoyRAM.I_SERIAL)
            return
        }
        if (IE & IF & GameBoyRAM.I_TIMER) != 0 { // Timer overflow
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = GameBoyRAM.JMP_I_TIMER
            memory.write(address: GameBoyRAM.IF, value: IF & ~GameBoyRAM.I_TIMER)
            return
        }
        if (IE & IF & GameBoyRAM.I_LCDC) != 0 { // LCDC interrupt
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = GameBoyRAM.JMP_I_LCDC
            memory.write(address: GameBoyRAM.IF, value: IF & ~GameBoyRAM.I_LCDC)
            return
        }
        if (IE & IF & GameBoyRAM.I_VBLANK) != 0 { // VBlank
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = GameBoyRAM.JMP_I_VBLANK
            memory.write(address: GameBoyRAM.IF, value: IF & ~GameBoyRAM.I_VBLANK)
            return
        }
    }
    
    func updateClock(cycles: UInt8) {
        timer.updateTimer(cycles)
    }
    
    func reset() {
        registers.A = UInt8(0)
        registers.F = UInt8(0)
        registers.B = UInt8(0)
        registers.C = UInt8(0)
        registers.D = UInt8(0)
        registers.E = UInt8(0)
        registers.H = UInt8(0)
        registers.L = UInt8(0)
        registers.PC = UInt16(0)
        registers.SP = UInt16(0)
        interruptMasterFlag = false
        timer.reset()
    }
    
}

//optcodes