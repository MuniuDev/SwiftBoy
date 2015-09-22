//
//  GameBoyCPU.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyCPU {
    class GameBoyRegisters {
        //pair AF
        var A : UInt8 = 0
        var F : UInt8 = 0
        //pair BC
        var B : UInt8 = 0
        var C : UInt8 = 0
        //pair DE
        var D : UInt8 = 0
        var E : UInt8 = 0
        //pair HL
        var H : UInt8 = 0
        var L : UInt8 = 0
        
        var PC : UInt16 = 0
        var SP : UInt16 = 0
        
    
        func get16(regH: UInt8, _ regL: UInt8) -> UInt16 { return UInt16(regH) << 8 + UInt16(regL)}
        func getAF() -> UInt16 { return UInt16(A) << 8 + UInt16(F) }
        func getBC() -> UInt16 { return UInt16(B) << 8 + UInt16(C) }
        func getDE() -> UInt16 { return UInt16(D) << 8 + UInt16(E) }
        func getHL() -> UInt16 { return UInt16(H) << 8 + UInt16(L) }
        
        func set16(inout regH: UInt8, inout _ regL: UInt8, value: UInt16) {
            regH = UInt8(value >> 8)
            regL = UInt8(value & 0xFF)
        }
        func setAF(value: UInt16) {
            A = UInt8(value >> 8)
            F = UInt8(value & 0xFF)
        }
        func setBC(value: UInt16) {
            B = UInt8(value >> 8)
            C = UInt8(value & 0xFF)
        }
        func setDE(value: UInt16) {
            D = UInt8(value >> 8)
            E = UInt8(value & 0xFF)
        }
        func setHL(value: UInt16) {
            H = UInt8(value >> 8)
            L = UInt8(value & 0xFF)
        }
        
        func checkZero() -> Bool { return F & F_ZERO != 0 }
        func checkCarry() -> Bool { return F & F_CARRY != 0 }
    }
    
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
        let IE = memory.read(address: memory.IE)
        let IF = memory.read(address: memory.IF)
        
        if (IE & IF & memory.I_P10P13) != 0 { // P10-P13 terminal negative edge
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = memory.JMP_I_P10P13
            memory.write(address: memory.IF, value: IF & ~memory.I_P10P13)
            return
        }
        if (IE & IF & memory.I_SERIAL) != 0 { // Serial transfer completion
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = memory.JMP_I_SERIAL
            memory.write(address: memory.IF, value: IF & ~memory.I_SERIAL)
            return
        }
        if (IE & IF & memory.I_TIMER) != 0 { // Timer overflow
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = memory.JMP_I_TIMER
            memory.write(address: memory.IF, value: IF & ~memory.I_TIMER)
            return
        }
        if (IE & IF & memory.I_LCDC) != 0 { // LCDC interrupt
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = memory.JMP_I_LCDC
            memory.write(address: memory.IF, value: IF & ~memory.I_LCDC)
            return
        }
        if (IE & IF & memory.I_VBLANK) != 0 { // VBlank
            memory.write16(address: registers.SP-2, value: registers.PC)
            registers.SP -= 2;
            interruptMasterFlag = false
            registers.PC = memory.JMP_I_VBLANK
            memory.write(address: memory.IF, value: IF & ~memory.I_VBLANK)
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