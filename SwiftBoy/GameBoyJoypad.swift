//
//  GameBoyJoypad.swift
//  SwiftBoy
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
    var memory: GameBoyRAM?
    
    init() {
        state = 0xFF
    }
    
    func registerRAM(_ ram: GameBoyRAM) {
        memory = ram
    }
    
    func getKeyValue(_ mask: UInt8) -> UInt8 {
        switch mask & 0x30 {
        case 0x10:
            return 0xD0 | (state & 0x0F)
        case 0x20:
            return 0xE0 | ((state >> 4) & 0x0F)
        default:
            return 0xFF
        }
    }
    
    func pressButton(_ flag: UInt8) {
        if(state & flag != 0) {
            state &= ~flag
            memory?.requestInterrupt(GameBoyRAM.I_P10P13)
        }
    }
    
    func releaseButton(_ flag: UInt8) {
        state |= flag
    }
}
