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
    // I/O registers
    let P1: UInt16 = 0xFF00     // Ports P15-P10 (keypad)
    let SB: UInt16 = 0xFF01     // Serial transfer data
    let SC: UInt16 = 0xFF02     // Serial control
    let DIV: UInt16 = 0xFF04    // Divider
    let TIMA: UInt16 = 0xFF05   // Timer
    let TMA: UInt16 = 0xFF06    // Modulo timer
    let TAC: UInt16 = 0xFF07    // Timer control
    let IF: UInt16 = 0xFF0F     // Interrupt request flag
    let IE: UInt16 = 0xFFFF     // Interrupt enable flag
    
    // video registers
    let LCDC: UInt16 = 0xFF40   // LCDC control
    let STAT: UInt16 = 0xFF41   // LCDC status
    let SCY: UInt16 = 0xFF42    // Scroll Y
    let SCX: UInt16 = 0xFF43    // Scroll X
    let LY: UInt16 = 0xFF44     // LCDC y coordinate
    let LYC: UInt16 = 0xFF45    // LCDC y coordinate compare LYC==LY
    let DMA: UInt16 = 0xFF46    // DMA transfer register
    let BGP: UInt16 = 0xFF47    // BG palette data
    let OBP0: UInt16 = 0xFF48   // OBJ palette data 0
    let OBP1: UInt16 = 0xFF49   // OBJ palette data 1
    let WY: UInt16 = 0xFF4A     // Window Y-coordinate
    let WX: UInt16 = 0xFF4B     // Window X-coordinate
    
    // DMA transfer details
    let DMA_SIZE: UInt16 = 0x00A0
    let DMA_START: UInt16 = 0xFE00
    let DMA_END: UInt16 = 0xFE9F

    let biosSize = 0x100
    
    var memory: [UInt8]
    var romHeader: [UInt8]
    
    init(bios: [UInt8], rom: [UInt8]) {
        self.memory = [UInt8](count: 65536, repeatedValue: UInt8(0))
        memory[0..<biosSize] = bios[0..<biosSize] //load bios into memory
        memory[biosSize..<rom.count] = rom[biosSize..<rom.count]  //load cartridge
        
        romHeader = [UInt8](count: biosSize, repeatedValue: UInt8(0))
        romHeader[0..<biosSize] = rom[0..<biosSize] // save cartridge header for later
    }
    
    func loadRom(rom: [UInt8]) {
        clear()
        memory[biosSize..<rom.count] = rom[biosSize..<rom.count]  //load cartridge
    }
    
    func clear() {
        for var i = biosSize; i<memory.count; ++i {
            memory[i] = UInt8(0)
        }
    }
    
    func DMATransfer(dma: UInt8) {
        let addr = UInt16(dma) << 8
        memory[Int(DMA_START)...Int(DMA_END)] = memory[Int(addr)..<Int(addr+DMA_SIZE)]
    }
    
    func UnmapBios() { memory[0..<biosSize] = romHeader[0..<biosSize] }
    
    func write(address address: UInt16, value: UInt8) {
        switch Int(address) {
        case biosSize...0xDFFF:
            memory[Int(address)] = value;
        case 0xE000...0xFDFF: //ram shadow
            memory[Int(address) - 0x2000] = value;
        case Int(DMA):
            memory[Int(address)] = value;
            DMATransfer(value)
        case 0xFF50 where value == 0x01:
            memory[Int(address)] = value;
            UnmapBios()
        case 0xFE00...0xFFFF:
            memory[Int(address)] = value;
        default:
            print("Write error to address: " + String(address) + ".")
        }
    }
    
    func read(address address: UInt16) -> UInt8 {
        switch Int(address) {
        case 0x0000...0xDFFF:
                return memory[Int(address)];
        case 0xE000...0xFDFF: //ram shadow
                return memory[Int(address) - 0x2000];
        case 0xFE00...0xFFFF:
                return memory[Int(address)];
        default:
            print("Read error of address: " + String(address) + ".")
            return UInt8(0);
        }
    }
    
    func write16(address address: UInt16, value: UInt16) {
        //little endian
        write(address: address, value: UInt8(value & 0xFF)) // write lower byte
        write(address: address+1, value: UInt8(value >> 8)) // write higher byte
    }
    
    func read16(address address: UInt16) -> UInt16 {
        //little endian
        var ret: UInt16;
        ret = UInt16(read(address: address));   // write lower byte
        ret += UInt16(read(address: address+1)) << 8; // write higher byte
        return ret;
    }
}
