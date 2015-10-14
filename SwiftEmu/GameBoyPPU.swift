//
//  GameBoyPPU.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

// http://gameboy.mongenel.com/dmg/istat98.txt

import Foundation

class GameBoyPPU {
    
    let CHR_0: UInt16 = 0x8000  //start addr of CHR data for bank 0
    let CHR_1: UInt16 = 0x8800  //start addr of CHR data for bank 1
    let CHR_SIZE: UInt16 = 0x0010   //size of single CHR
    let CHR_OFFSET: UInt16 = 0x0080
    
    let BG_1: UInt16 = 0x9800   //start addr of bg data for bg display data 1
    let BG_2: UInt16 = 0x9C00   //start addr of bg data for bg display data 2
    let BG_SIZE: UInt16 = 0x0400
    
    let OAM: UInt16 = 0xFE00
    
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
    
    func getPixelColor(fromLine line: UInt16, andColumn column: UInt8, withPalette palette: UInt8) -> UInt8 {
        let mask = UInt8(0x80 >> column)
        let color_id = ((UInt8(line & 0xFF) & mask) >> (7-column)) + ((UInt8(line >> 8) & mask) >> (7-column)) << 1  // find color id
        return (palette >> (color_id*2)) & 0x03
    }
    
    func renderLine() {
        let lcdc = memory.read(address: GameBoyRAM.LCDC)
        // is LCD controller operational?
        if lcdc & 0x80 != 0 {
            //let stat = memory.read(address: memory.STAT)
            let ly = memory.read(address: GameBoyRAM.LY)
            let scx = memory.read(address: GameBoyRAM.SCX)
            let scy = memory.read(address: GameBoyRAM.SCY)
            let bgp = memory.read(address: GameBoyRAM.BGP)
            
            let frame_offset = Int(ly) * 160
            
            // is BG display on?
            if lcdc & 0x01 != 0 {   // draw BG
                let start_y = (UInt16(UInt8(ly) &+ UInt8(scy)))/8
                let start_x = UInt16(scx)/8
                let line_y_off = (UInt16(UInt8(ly) &+ UInt8(scy)))%8 * 2
                
                let bg_data = (lcdc & 0x08 == 0) ? BG_1 : BG_2  //select bg display addr
                let bg_chr = (lcdc & 0x10 == 0) ? CHR_1 : CHR_0 //select char bank addr
                let tile_id_offset = (lcdc & 0x10 == 0) ? CHR_OFFSET : UInt16(0x00)   // offset when using CHR bank 1
                
                var tile_addr = bg_data + start_y*32 + start_x
                var tile_id = UInt8(memory.read(address: tile_addr)) &+ UInt8(tile_id_offset)
                var x = UInt8(scx) & 0x07
                var colorLine = memory.read16(address: bg_chr + UInt16(tile_id)*CHR_SIZE + line_y_off)
                for i in 0..<160 {
                    frameBuffer[frame_offset + i] = palette[Int(getPixelColor(fromLine: colorLine, andColumn: x, withPalette: bgp))]     // get RGB value from palette
                    ++x
                    if x == 8 {
                        x = 0
                        ++tile_addr
                        tile_id = UInt8(memory.read(address: tile_addr)) &+ UInt8(tile_id_offset)
                        colorLine = memory.read16(address: bg_chr + UInt16(tile_id)*CHR_SIZE + line_y_off)
                    }
                }
            }
            
            let wy = memory.read(address: GameBoyRAM.WY)
            // is Window display on?
            if lcdc & 0x01 != 0 && lcdc & 0x20 != 0 && ly >= wy {   // draw Window
                
                let wx = memory.read(address: GameBoyRAM.WX)
                let start_y = UInt16(ly &- wy)/8
                let line_y_off = (UInt16(ly &- wy))%8 * 2
            
                // Which bank of CHR is used by window?
                let bg_data = (lcdc & 0x80 == 0) ? BG_1 : BG_2  //select bg display addr
                let bg_chr = (lcdc & 0x10 == 0) ? CHR_1 : CHR_0 //select char bank addr
                let tile_id_offset = (lcdc & 0x10 == 0) ? CHR_OFFSET : UInt16(0x00)   // offset when using CHR bank 1
                
                var tile_addr = bg_data + start_y*32
                var tile_id = UInt8(memory.read(address: tile_addr)) &+ UInt8(tile_id_offset)
                var x = wx % 8  //UInt8(0)
                var colorLine = memory.read16(address: bg_chr + UInt16(tile_id)*CHR_SIZE + line_y_off)
                for i in Int(wx)..<167 {
                    if i >= 7  {
                    frameBuffer[frame_offset + i - 7] = palette[Int(getPixelColor(fromLine: colorLine, andColumn: x, withPalette: bgp))]     // get RGB value from palette
                    }
                    ++x
                    if x == 8 {
                        x = 0
                        ++tile_addr
                        tile_id = UInt8(memory.read(address: tile_addr)) &+ UInt8(tile_id_offset)
                        colorLine = memory.read16(address: bg_chr + UInt16(tile_id)*CHR_SIZE + line_y_off)
                    }
                }
            }
            
            // is OBJ display on?
            if lcdc & 0x02 != 0 {   // draw OBJ
                let spriteHeight = lcdc & 0x08 != 0 ? 16 : 8
                let line_y_off = UInt16(ly)%8 * 2
                
                var startAddr = OAM
                var spriteCount = 0
                for _ in 0..<40 {
                    // extract sprite data
                    let spr_y = memory.read(address: startAddr) &- 16
                    let spr_x = memory.read(address: startAddr+1) &- 8
                    let spr_num = memory.read(address: startAddr+2)
                    let spr_attrib = memory.read(address: startAddr+3)
                    startAddr += 4
                    
                    if spriteHeight == 16 {
                        LogW("Double OBJ sprites enabled but not implemented!")
                    }
                    
                    if spr_y <= ly && spr_y + 8 > ly { //do sprite intersect with line?
                        ++spriteCount
                        let spr_palette = memory.read(address: spr_attrib & 0x10 != 0 ? GameBoyRAM.OBP1 : GameBoyRAM.OBP0)
                        var colorLine = UInt16(0)
                        if spr_attrib & 0x40 != 0 { //check y flip
                            colorLine = memory.read16(address: CHR_0 + UInt16(spr_num)*CHR_SIZE + 14 - line_y_off)
                        } else {
                            colorLine = memory.read16(address: CHR_0 + UInt16(spr_num)*CHR_SIZE + line_y_off)
                        }
                        
                        for x : UInt8 in 0..<8 {
                            let pixel_x = spr_attrib & 0x20 != 0 ? 7-x : x
                            let color = getPixelColor(fromLine: colorLine, andColumn: pixel_x, withPalette: spr_palette)
                            if spr_x &+ x >= 0  && spr_x &+ x < 160 && color != 0 &&
                                (spr_attrib & 0x80 == 0 || frameBuffer[frame_offset + Int(spr_x) + Int(x)] == palette[0]) {
                                frameBuffer[frame_offset + Int(spr_x &+ x)] = palette[Int(color)]
                            }
                        }
                    }
                }
                if spriteCount >= 10 { return }
            }
        }
    }
    
    func getBuffer() -> [UInt8] {
        return frameBuffer
    }
    
    func tic(deltaClock: UInt) {
        clock = clock &+ deltaClock
        
        let ly = memory.read(address: GameBoyRAM.LY)
        let lyc = memory.read(address: GameBoyRAM.LYC)
        var stat = memory.read(address: GameBoyRAM.STAT)
        if ly == lyc { stat |= 0x04; memory.write(address: GameBoyRAM.STAT, value: stat) }
        let lcdc_int = stat & 0x78
        
        switch getMode() {
        case MODE_OAM_SCANLINE where clock >= 20:
                clock %= 20
                setMode(MODE_VRAM_SCANLINE)
        case MODE_VRAM_SCANLINE where clock >= 43:
                clock %= 43
                renderLine()
                setMode(MODE_HBLANK)
                if lcdc_int & 0x10 != 0 { memory.requestInterrupt(GameBoyRAM.I_LCDC)}
        case MODE_HBLANK where clock >= 51:
                clock %= 51
                setLine(getLine()+1)
                if getLine() == 144 {
                    setMode(MODE_VBLANK)
                    memory.requestInterrupt(GameBoyRAM.I_VBLANK)
                    if lcdc_int & 0x20 != 0 { memory.requestInterrupt(GameBoyRAM.I_LCDC)}
                    //copyBuffer()
                } else {
                    setMode(MODE_OAM_SCANLINE)
                    if lcdc_int & 0x30 != 0 { memory.requestInterrupt(GameBoyRAM.I_LCDC)}
                    if lcdc_int & 0x40 != 0 && ly == lyc { memory.requestInterrupt(GameBoyRAM.I_LCDC) }
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
    
    
    func getLine() -> UInt8 { return memory.read(address: GameBoyRAM.LY) }
    func setLine(line: UInt8) { memory.write(address: GameBoyRAM.LY, value: line) }
    func getMode() -> UInt8 { return memory.read(address: GameBoyRAM.STAT) & 0x03 }
    func setMode(mode: UInt8) {
        var reg = memory.read(address: GameBoyRAM.STAT)
        reg = reg & 0xFC + mode & 0x03
        memory.write(address: GameBoyRAM.STAT, value: reg)
    }
}