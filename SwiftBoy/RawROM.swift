//
//  RawMBC.swift
//  SwiftBoy
//
//  Created by Michal Majczak on 24.02.2016.
//  Copyright © 2016 Michal Majczak. All rights reserved.
//

import Foundation

// This class represents raw rom cartridge type (No MBC)
class RawRom : IMemoryBankController {
    var rom: [UInt8]
    
    init(rom: [UInt8]) {
        self.rom = [UInt8](repeating: UInt8(0), count: 0xC000)
        self.rom[0...0x7FFF] = rom[0...0x7FFF]
    }
    
    func write(address: UInt16, value: UInt8) {
        if address < 0x8000 { return }
        rom[Int(address)] = value
    }
    
    func read(address: UInt16) -> UInt8 {
        return rom[Int(address)]
    }
    
    func getDMAData(address: UInt16, size: UInt16) -> [UInt8] {
        var ret = [UInt8](repeating: UInt8(0), count: Int(size))
        ret[0..<Int(size)] = rom[ Int(address)..<Int(address + size)]
        return ret
    }
}
