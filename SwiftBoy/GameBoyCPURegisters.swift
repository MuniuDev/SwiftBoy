//
//  GameBoyCPURegisters.swift
//  SwiftBoy
//
//  Created by Michal Majczak on 02.10.2015.
//  Copyright © 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyRegisters {
    /*
    F - flags register:
    0x80 - Z - last result was zero
    0x40 - N - last operation did subtraction
    0x20 - H - half-carry when during operation a bit is carried from lower nimble to higher or vice versa
    0x10 - CY - carry when operation carries over 255 or under 0
    */
    static let F_ZERO: UInt8 = 0x80
    static let F_NEGATIVE: UInt8 = 0x40
    static let F_HALF_CARRY: UInt8 = 0x20
    static let F_CARRY: UInt8 = 0x10
    
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
    
    
    static func get16(regH: UInt8, _ regL: UInt8) -> UInt16 { return UInt16(regH) << 8 + UInt16(regL)}
    func getAF() -> UInt16 { return UInt16(A) << 8 + UInt16(F) }
    func getBC() -> UInt16 { return UInt16(B) << 8 + UInt16(C) }
    func getDE() -> UInt16 { return UInt16(D) << 8 + UInt16(E) }
    func getHL() -> UInt16 { return UInt16(H) << 8 + UInt16(L) }
    
    static func set16(inout regH: UInt8, inout _ regL: UInt8, value: UInt16) {
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
    
    func checkZero() -> Bool { return F & GameBoyRegisters.F_ZERO != 0 }
    func checkCarry() -> Bool { return F & GameBoyRegisters.F_CARRY != 0 }
    
    func reset() {
        A = UInt8(0)
        F = UInt8(0)
        B = UInt8(0)
        C = UInt8(0)
        D = UInt8(0)
        E = UInt8(0)
        H = UInt8(0)
        L = UInt8(0)
        PC = UInt16(0)
        SP = UInt16(0)
    }
}