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
        
        func getAF() -> UInt16 { return UInt16(A) << 8 + UInt16(F) }
        func getBC() -> UInt16 { return UInt16(B) << 8 + UInt16(C) }
        func getDE() -> UInt16 { return UInt16(D) << 8 + UInt16(E) }
        func getHL() -> UInt16 { return UInt16(H) << 8 + UInt16(L) }
        
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
    }
    
    var registers: GameBoyRegisters
    var memory: GameBoyRAM
    var opcodes: [OpCode]
    var clock: Int
    
    init(memory mem: GameBoyRAM) {
        registers = GameBoyRegisters()
        memory = mem;
        opcodes = generateOpCodeTable()
        clock = 0;
    }
    
    func tic() {
        let opCodeVal = memory.read(address: registers.PC)
        var opCode = opcodes[Int(opCodeVal)]
        
        if opCode.instruction != nil {
            println("Called: \"" + opCode.name + "\" of code: 0x" + String(format:"%2X", opCodeVal) + ". PC=" + String(format:"%4X",registers.PC))
            opCode.instruction!(cpu: self)
        } else {
            println("ERROR: Unimplemented instruction \"" + opCode.name + "\" of code: 0x" + String(format:"%2X", opCodeVal)
                + " and operand size: " + String(opCode.operandSize) + ".")
            exit(-1)
        }
        
    }
    
    func reset() {
        clock = 0;
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
    }
    
}

//optcodes