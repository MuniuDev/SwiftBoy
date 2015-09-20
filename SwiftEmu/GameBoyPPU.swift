//
//  GameBoyPPU.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyPPU {
    
    let MODE_OAM_SCANLINE: UInt8 = 0x02
    let MODE_VRAM_SCANLINE: UInt8 = 0x03
    let MODE_HBLANK: UInt8 = 0x00
    let MODE_VBLANK: UInt8 = 0x01
    
    
    var memory: GameBoyRAM
    var clock: UInt
    
    init(memory mem: GameBoyRAM) {
        memory = mem
        clock = 0
        setMode(MODE_HBLANK)
        setLine(0)
    }
    
    func renderLine() {
        
    }
    
    func copyBuffer() {
        
    }
    
    func tic(deltaClock: UInt) {
        clock = clock &+ deltaClock
        
        switch getMode() {
        case MODE_OAM_SCANLINE where clock >= 20:
                clock %= 20
                setMode(MODE_VRAM_SCANLINE)
        case MODE_VRAM_SCANLINE where clock >= 43:
                clock %= 43
                setMode(MODE_HBLANK)
                renderLine()
        case MODE_HBLANK where clock >= 51:
                clock %= 51
                setLine(getLine()+1)
                if getLine() == 143 {
                    setMode(MODE_VBLANK)
                    copyBuffer()
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