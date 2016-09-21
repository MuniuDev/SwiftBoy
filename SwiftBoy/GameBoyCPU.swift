//
//  GameBoyCPU.swift
//  SwiftBoy
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
    var haltMode: Bool
    
    init(memory mem: GameBoyRAM) {
        registers = GameBoyRegisters()
        memory = mem;
        opcodes = generateOpCodeTable()
        extOpcodes = generateExtOpCodeTable()
        timer = GameBoyTimer(memory: memory)
        interruptMasterFlag = false
        haltMode = false
    }
    
    func tic() {
        HandleInterrupts()
        if !haltMode {
            let opCodeVal = memory.read(address: registers.PC)
            let opCode = opcodes[Int(opCodeVal)]
            
            if opCode.instruction != nil {
                //LogD("Called: \"" + opCode.name + "\" of code: 0x" + String(format:"%02X", opCodeVal) + ". PC= 0x" + String(format:"%04X",registers.PC))
                opCode.instruction!(self)
            } else {
                LogE("ERROR: Unimplemented instruction \"" + opCode.name + "\" of code: 0x" + String(format:"%02X", opCodeVal) + " found in PC=" + String(format:"%04X", registers.PC))
                exit(-1)
            }
        } else {
            updateClock(1)
        }
        
    }
    
    func HandleInterrupts() {
        let IE = memory.read(address: GameBoyRAM.IE)
        let IF = memory.read(address: GameBoyRAM.IF)
        if !interruptMasterFlag {
            if haltMode && (IE & IF) > 0{
                haltMode = false
            }
            return
        }
        
        if (IE & IF & GameBoyRAM.I_P10P13) != 0 { // P10-P13 terminal negative edge
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = GameBoyRAM.JMP_I_P10P13
            memory.write(address: GameBoyRAM.IF, value: IF & ~GameBoyRAM.I_P10P13)
            haltMode = false
            return
        }
        if (IE & IF & GameBoyRAM.I_SERIAL) != 0 { // Serial transfer completion
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = GameBoyRAM.JMP_I_SERIAL
            memory.write(address: GameBoyRAM.IF, value: IF & ~GameBoyRAM.I_SERIAL)
            haltMode = false
            return
        }
        if (IE & IF & GameBoyRAM.I_TIMER) != 0 { // Timer overflow
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = GameBoyRAM.JMP_I_TIMER
            memory.write(address: GameBoyRAM.IF, value: IF & ~GameBoyRAM.I_TIMER)
            haltMode = false
            return
        }
        if (IE & IF & GameBoyRAM.I_LCDC) != 0 { // LCDC interrupt
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = GameBoyRAM.JMP_I_LCDC
            memory.write(address: GameBoyRAM.IF, value: IF & ~GameBoyRAM.I_LCDC)
            haltMode = false
            return
        }
        if (IE & IF & GameBoyRAM.I_VBLANK) != 0 { // VBlank
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = GameBoyRAM.JMP_I_VBLANK
            memory.write(address: GameBoyRAM.IF, value: IF & ~GameBoyRAM.I_VBLANK)
            haltMode = false
            return
        }
    }
    
    func updateClock(_ cycles: UInt8) {
        timer.updateTimer(cycles)
    }
    
    func reset() {
        registers.reset()
        interruptMasterFlag = false
        haltMode = false
        timer.reset()
    }
    
}

//optcodes
