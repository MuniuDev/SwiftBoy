//
//  GameBoyPPU.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyPPU {
    
    let CHR_0: UInt16 = 0x8000  //start addr of CHR data for bank 0
    let CHR_1: UInt16 = 0x8800  //start addr of CHR data for bank 1
    let CHR_SIZE: UInt16 = 0x0010   //size of single CHR
    let CHR_OFFSET: UInt16 = 0x0080
    
    let BG_1: UInt16 = 0x9800   //start addr of bg data for bg display data 1
    let BG_2: UInt16 = 0x9C00   //start addr of bg data for bg display data 2
    let BG_SIZE: UInt16 = 0x0400
    
    let MODE_OAM_SCANLINE: UInt8 = 0x02
    let MODE_VRAM_SCANLINE: UInt8 = 0x03
    let MODE_HBLANK: UInt8 = 0x00
    let MODE_VBLANK: UInt8 = 0x01
    
    
    var memory: GameBoyRAM
    var clock: UInt
    var frameBuffer: [UInt8]
    var palette: [UInt8] = [0,96,192,255]
    
    init(memory mem: GameBoyRAM) {
        memory = mem
        frameBuffer = [UInt8](count: 160*144, repeatedValue: UInt8(0))
        clock = 0
        setMode(MODE_HBLANK)
        setLine(0)
    }
    
    func renderLine() {
        let lcdc = memory.read(address: memory.LCDC)
        // is LCD controller operational?
        if lcdc & 0x80 != 0 {
            //let stat = memory.read(address: memory.STAT)
            let ly = memory.read(address: memory.LY)
            //let lyc = memory.read(address: memory.LYC)
            let scx = memory.read(address: memory.SCX)
            let scy = memory.read(address: memory.SCY)
            
            let start_y = (UInt16(ly) &+ UInt16(scy))/8
            let start_x = UInt16(scx)/8
            let frame_offset = Int(ly) * 160
            
            // is BG display on?
            if lcdc & 0x01 != 0 {   // draw BG
                let bg_data = (lcdc & 0x08 == 0) ? BG_1 : BG_2  //select bg display addr
                let bg_chr = (lcdc & 0x10 == 0) ? CHR_1 : CHR_0 //select char bank addr
                let tile_id_offset = (lcdc & 0x10 == 0) ? CHR_OFFSET : UInt16(0x00)   // offset when using CHR bank 1
                
                var tile_addr = bg_data + start_y*32 + start_x
                var tile_id = UInt16(memory.read(address: tile_addr)) &+ tile_id_offset
                var x = UInt16(scx) & 0x07
                let y_off = (UInt16(ly) &+ UInt16(scy))%8 * 2
                
                for var i = 0; i<160; ++i {
                    let colorH = memory.read(address: bg_chr + UInt16(tile_id)*CHR_SIZE + y_off)
                    let colorL = memory.read(address: bg_chr + UInt16(tile_id)*CHR_SIZE + y_off + 1)
                    let mask = UInt8(0x80 >> x)
                    let color_id = ((colorH & mask) >> UInt8(7-x)) << 1 + ((colorL & mask) >> UInt8(7-x))
                    frameBuffer[frame_offset + i] = palette[Int(color_id)]
                    ++x
                    if x == 8 {
                        x = 0
                        ++tile_addr
                        tile_id = UInt16(memory.read(address: tile_addr)) &+ tile_id_offset
                    }
                }
            }
            
            // is OBJ display on?
            if lcdc & 0x02 != 0 {   // draw BG
                
            }
        }
    }
    
    func getBuffer() -> [UInt8] {
        return frameBuffer
    }
    
    func tic(deltaClock: UInt) {
        clock = clock &+ deltaClock
        
        switch getMode() {
        case MODE_OAM_SCANLINE where clock >= 20:
                clock %= 20
                setMode(MODE_VRAM_SCANLINE)
        case MODE_VRAM_SCANLINE where clock >= 43:
                clock %= 43
                renderLine()
                setMode(MODE_HBLANK)
        case MODE_HBLANK where clock >= 51:
                clock %= 51
                setLine(getLine()+1)
                if getLine() == 143 {
                    setMode(MODE_VBLANK)
                    //copyBuffer()
                } else {
                    setMode(MODE_OAM_SCANLINE)
                }
        case MODE_VBLANK where clock >= 114:
                clock %= 114
                setLine(getLine()+1)
                if getLine() > 153 {
                    setMode(MODE_OAM_SCANLINE)
                    setLine(0)
                }
        default:
            return
        }
    }
    
    func reset() {
        clock = 0
        frameBuffer = [UInt8](count: 160*144, repeatedValue: UInt8(0))
        setMode(MODE_HBLANK)
        setLine(0)
    }
    
    
    func getLine() -> UInt8 { return memory.read(address: memory.LY) }
    func setLine(line: UInt8) { memory.write(address: memory.LY, value: line) }
    func getMode() -> UInt8 { return memory.read(address: memory.STAT) & 0x03 }
    func setMode(mode: UInt8) {
        var reg = memory.read(address: memory.STAT)
        reg = reg & 0xFC + mode & 0x03
        memory.write(address: memory.STAT, value: reg)
    }
}