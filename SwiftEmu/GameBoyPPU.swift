//
//  GameBoyPPU.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyPPU {
    
    enum PPUMode {
        case OAM_SCANLINE
        case VRAM_SCANLINE
        case HBLANK
        case VBLANK
    }
    
    var memory: GameBoyRAM
    var clock: UInt
    var mode: PPUMode
    var line: UInt8
    
    init(memory mem: GameBoyRAM) {
        memory = mem
        clock = 0
        mode = PPUMode.HBLANK
        line = UInt8(0)
    }
    
    func renderScanLine(){
        
    }
    
    func tic(deltaClock: UInt) {
        clock = clock &+ deltaClock
        
        switch mode {
        case PPUMode.OAM_SCANLINE where clock >= 20:
                clock %= 20
                mode = PPUMode.VRAM_SCANLINE
        case PPUMode.VRAM_SCANLINE where clock >= 43:
                clock %= 43
                mode = PPUMode.HBLANK
                renderScanLine()
        case PPUMode.HBLANK where clock >= 51:
                clock %= 51
                ++line
                if line == 143 {
                    mode = PPUMode.VBLANK
                    //TODO: here copy image buffer to the UI
                } else {
                    mode = PPUMode.OAM_SCANLINE
                }
        case PPUMode.VBLANK where clock >= 114:
                clock %= 114
                ++line
                if line > 153 {
                    mode = PPUMode.OAM_SCANLINE
                    line = 0
                }
        default:
            return
        }
    }
    
    func reset() {
        clock = 0
        mode = PPUMode.HBLANK
        line = UInt8(0)
    }
}