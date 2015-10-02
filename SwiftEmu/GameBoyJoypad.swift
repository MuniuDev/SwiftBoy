//
//  GameBoyJoypad.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 27.09.2015.
//  Copyright © 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyJoypad {
    
    static let BTN_UP: UInt8 = 0x40
    static let BTN_DOWN: UInt8 = 0x80
    static let BTN_LEFT: UInt8 = 0x20
    static let BTN_RIGHT: UInt8 = 0x10
    
    static let BTN_A: UInt8 = 0x01
    static let BTN_B: UInt8 = 0x02
    static let BTN_START: UInt8 = 0x08
    static let BTN_SELECT: UInt8 = 0x04
    
    var state: UInt8
    var mask: UInt8
    var memory: GameBoyRAM?
    
    init() {
        state = 0xFF
        mask = 0x00
    }
    
    func registerRAM(ram: GameBoyRAM) {
        memory = ram
    }
    
    func setRow(mask: UInt8) {
        self.mask = mask & 0x30
    }
    
    func getKeyValue() -> UInt8 {
        if mask == 0x10 {
            return (state & 0x0F)
        } else if mask == 0x20 {
            return ((state >> 4) & 0x0F)
        }
        return 0xFF
    }
    
    func pressButton(flag: UInt8) {
        state &= ~flag
        memory?.requestInterrupt(GameBoyRAM.I_P10P13)
    }
    
    func releaseButton(flag: UInt8) {
        state |= flag
    }
}