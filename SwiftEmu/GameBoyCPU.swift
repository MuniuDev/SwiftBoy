//
//  GameBoyCPU.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyCPU {
    struct GameBoyRegistes {
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
    }
    
    var registers: GameBoyRegistes
    var memory: GameBoyRAM
    var opcodes: [OpCode]
    
    init(memory mem: GameBoyRAM) {
        registers = GameBoyRegistes()
        memory = mem;
        opcodes = generateOpCodeTable()
    }
    
    func tic() {
        let opCodeVal = memory.read(address: registers.PC)
        var opCode = opcodes[Int(opCodeVal)]
        
        if opCode.instruction != nil {
            opCode.instruction!(cpu: self)
            registers.PC++
        } else {
            println("ERROR: Unimplemented function \"" + opCode.name + "\" of code: 0x" + String(format:"%2X", opCodeVal)
                + " and operand size: " + String(opCode.operandSize) + ".")
            exit(-1)
        }
        
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
    }
    
}

//optcodes