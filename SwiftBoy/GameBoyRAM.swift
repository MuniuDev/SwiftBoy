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
    static let P1: UInt16 = 0xFF00     // Ports P15-P10 (keypad)
    static let SB: UInt16 = 0xFF01     // Serial transfer data
    static let SC: UInt16 = 0xFF02     // Serial control
    static let DIV: UInt16 = 0xFF04    // Divider
    static let TIMA: UInt16 = 0xFF05   // Timer
    static let TMA: UInt16 = 0xFF06    // Modulo timer
    static let TAC: UInt16 = 0xFF07    // Timer control
    static let IF: UInt16 = 0xFF0F     // Interrupt request flag
    static let IE: UInt16 = 0xFFFF     // Interrupt enable flag
    
    // video registers
    static let LCDC: UInt16 = 0xFF40   // LCDC control
    static let STAT: UInt16 = 0xFF41   // LCDC status
    static let SCY: UInt16 = 0xFF42    // Scroll Y
    static let SCX: UInt16 = 0xFF43    // Scroll X
    static let LY: UInt16 = 0xFF44     // LCDC y coordinate
    static let LYC: UInt16 = 0xFF45    // LCDC y coordinate compare LYC==LY
    static let DMA: UInt16 = 0xFF46    // DMA transfer register
    static let BGP: UInt16 = 0xFF47    // BG pastatic lette data
    static let OBP0: UInt16 = 0xFF48   // OBJ pastatic lette data 0
    static let OBP1: UInt16 = 0xFF49   // OBJ pastatic lette data 1
    static let WY: UInt16 = 0xFF4A     // Window Y-coordinate
    static let WX: UInt16 = 0xFF4B     // Window X-coordinate
    
    // DMA transfer details
    static let DMA_SIZE: UInt16 = 0x00A0
    static let DMA_START: UInt16 = 0xFE00
    static let DMA_END: UInt16 = 0xFE9F
    
    // Interrupts flags
    static let I_VBLANK: UInt8 = 0x01
    static let I_LCDC: UInt8 = 0x02
    static let I_TIMER: UInt8 = 0x04
    static let I_SERIAL: UInt8 = 0x08
    static let I_P10P13: UInt8 = 0x10
    
    // Interrupts jumps
    static let JMP_I_VBLANK: UInt16 = 0x0040
    static let JMP_I_LCDC: UInt16 = 0x0048
    static let JMP_I_TIMER: UInt16 = 0x0050
    static let JMP_I_SERIAL: UInt16 = 0x0058
    static let JMP_I_P10P13: UInt16 = 0x0060

    let biosSize = 0x100
    
    var memory: [UInt8]
    var bios: [UInt8]
    var fastBiosMode: Bool
    var inBios: Bool
    var mbc: IMemoryBankController?
    let joypad: GameBoyJoypad
    
    init(joypad: GameBoyJoypad) {
        self.memory = [UInt8](count: 65536, repeatedValue: UInt8(0))
        self.bios = [UInt8](count: biosSize, repeatedValue: UInt8(0))
        self.joypad = joypad
        fastBiosMode = true;
        inBios = false
    }
    
    func loadBios(bios: [UInt8]) {
        self.bios[0..<biosSize] = bios[0..<biosSize]
        fastBiosMode = false;
        inBios = true
    }
    
    func loadRom(mbc: IMemoryBankController) {
        self.mbc = mbc
    }
    
    func clear() {
        mbc?.reset()
        for var i = biosSize; i<memory.count; ++i {
            memory[i] = UInt8(0)
        }
    }
    
    func DMATransfer(dma: UInt8) {
        let addr = UInt16(dma) << 8
        
        // TODO implement DMA transfer from the MBC
        switch Int(addr) {
        case 0x8000...Int(0x9FFF-GameBoyRAM.DMA_SIZE):
            memory[Int(GameBoyRAM.DMA_START)...Int(GameBoyRAM.DMA_END)] = memory[Int(addr)..<Int(addr+GameBoyRAM.DMA_SIZE)]
        case 0xA000...Int(0xBFFF-GameBoyRAM.DMA_SIZE):
            memory[Int(GameBoyRAM.DMA_START)...Int(GameBoyRAM.DMA_END)] = mbc!.getDMAData(address: addr, size: GameBoyRAM.DMA_SIZE)[0..<Int(GameBoyRAM.DMA_SIZE)]
        case 0xC000...Int(0xDFFF-GameBoyRAM.DMA_SIZE):
            memory[Int(GameBoyRAM.DMA_START)...Int(GameBoyRAM.DMA_END)] = memory[Int(addr)..<Int(addr+GameBoyRAM.DMA_SIZE)]
        default:
            LogE("DMA address out of bounds!")
            exit(-1)
        }
        
    }
    
    func requestInterrupt(interrupt: UInt8) { memory[Int(GameBoyRAM.IF)] |= interrupt }
    
    func write(address address: UInt16, value: UInt8) {
        switch Int(address) {
        case 0...0x00FF where inBios:
            bios[Int(address)] = value;
        case 0x8000...0x9FFF:
            memory[Int(address)] = value;
        case 0...0xBFFF:
            // here write to MBC
            mbc!.write(address: address, value: value)
        case 0xC000...0xDFFF:
            memory[Int(address)] = value;
        case 0xE000...0xFDFF: //ram shadow
            memory[Int(address) - 0x2000] = value;
        case Int(GameBoyRAM.DMA):
            memory[Int(address)] = value;
            DMATransfer(value)
        case 0xFF50 where value == 0x01 && !fastBiosMode:
            memory[Int(address)] = value;
            inBios = false
        case Int(GameBoyRAM.P1):    //write to joypad
            memory[Int(address)] = joypad.getKeyValue(value)
        case 0xFE00...0xFFFF:
            memory[Int(address)] = value;
        default:
            LogE("Write error to address: 0x" + String(format:"%04X", address) + ".")
        }
    }
    
    func read(address address: UInt16) -> UInt8 {
        switch Int(address) {
        case 0...0x00FF where inBios:
            return bios[Int(address)];
        case 0x8000...0x9FFF:
            return memory[Int(address)];
        case 0...0xBFFF:
            // here write to MBC
            return mbc!.read(address: address)
        case 0xC000...0xDFFF:
            return memory[Int(address)];
        case 0xE000...0xFDFF: //ram shadow
            return memory[Int(address) - 0x2000];
        case 0xFE00...0xFFFF:
            return memory[Int(address)];
        default:
            LogE("Read error of address: 0x" + String(format:"%04X", address) + ".")
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
