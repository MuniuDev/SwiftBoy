//
//  GameBoyRAM.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

/*
Memory layout:
0x0000 - 0x3FFF Cartrige ROM, bank 0
    0x0000 - 0x00FF - GameBoy bios on statup, after execution its replaced with ROM
    0x0100 - 0x014F - Cartridge header info
0x4000 - 0x7FFF Cartrige ROM, other banks
0x8000 - 0x9FFF Graphics RAM
0xA000 - 0xBFFF Cartridge RAM (External)
0xC000 - 0xDFFF Internal RAM
0xE000 - 0xFDFF Internal RAM Shadow (without last 512 B)
0xFE00 - 0xFE9F Graphics: Sprite information
0xFF00 - 0xFF7F IO in memory map
0xFF80 - 0xFFFF Zero page RAM
*/

import Foundation

class GameBoyRAM {
    var memory : [UInt8]
    var bios : [UInt8]
    var rom : [UInt8]
    
    var biosMode: Bool
    
    init(bios: [UInt8], rom: [UInt8]) {
        self.memory = [UInt8](count: 65536, repeatedValue: UInt8(0))
        self.bios = bios
        //memory[0..<256] = bios[0..<256] //load bios into memory
        self.rom = rom
        biosMode = true
    }
    
    func clear() {
        for var i = 0; i<memory.count; ++i {
            memory[i] = UInt8(0)
        }
        biosMode = true
    }
    
    func write(#address: UInt16, value: UInt8) {
        if biosMode && address > 0x00FF { biosMode = false }
        
        switch address {
        case 0x0000...0x00FF where biosMode:
            bios[Int(address)] = value;
        case 0x0000...0xDFFF:
            memory[Int(address)] = value;
        case 0xE000...0xFDFF: //ram shadow
            memory[Int(address) - 0x2000] = value;
        case 0xFE00...0xFFFF:
            memory[Int(address)] = value;
        default:
            println("Write error of address: " + String(address) + ".")
        }
    }
    
    func read(#address: UInt16) -> UInt8 {
        if biosMode && address > 0x00FF { biosMode = false }
        
        switch address {
        case 0x0000...0x00FF where biosMode:
                return bios[Int(address)];
        case 0x0000...0xDFFF:
                return memory[Int(address)];
        case 0xE000...0xFDFF: //ram shadow
                return memory[Int(address) - 0x2000];
        case 0xFE00...0xFFFF:
                return memory[Int(address)];
        default:
            println("Read error of address: " + String(address) + ".")
            return UInt8(0);
        }
    }
    
    func write16(#address: UInt16, value: UInt16) {
        //little endian
        write(address: address, value: UInt8(value >> 8))
        write(address: address+1, value: UInt8(value & 0xFF))
    }
    
    func read16(#address: UInt16) -> UInt16 {
        //little endian
        var ret: UInt16;
        ret = UInt16(read(address: address) << 8);
        ret += UInt16(read(address: address+1));
        return ret;
    }
}
