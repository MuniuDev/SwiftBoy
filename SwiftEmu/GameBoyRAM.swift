//
//  GameBoyRAM.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyRAM {
    var memory : [UInt8]
    
    init() {
        memory = [UInt8](count: 65536, repeatedValue: UInt8(0))
    }
    
    func write(#address: UInt16, value: UInt8) {
        memory[Int(address)] = value
    }
    
    func read(#address: UInt16) -> UInt8 {
        return memory[Int(address)]
    }
    
    func write16(#address: UInt16, value: UInt16) {
        //little endian
        memory[Int(address)] = UInt8(value >> 8)
        memory[Int(address+1)] = UInt8(value & 0xFF)
    }
    
    func read16(#address: UInt16) -> UInt16 {
        //little endian
        var ret: UInt16;
        ret = UInt16(memory[Int(address)] << 8);
        ret += UInt16(memory[Int(address+1)]);
        return ret;
    }
}
