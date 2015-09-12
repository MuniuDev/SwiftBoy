//
//  GameBoyDevice.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyDevice {
    
    let screen: EmulatorScreen
    let memory: GameBoyRAM
    
    // temporary buffers for bios and rom
    var bios: [UInt8]
    var rom: [UInt8]
    
    init(screen emuScreen: EmulatorScreen) {
        screen = emuScreen
        memory = GameBoyRAM()
        let biosPath = NSBundle.mainBundle().pathForResource("bios", ofType: ".gb", inDirectory: "roms")!
        let romPath = NSBundle.mainBundle().pathForResource("tetris", ofType: ".gb", inDirectory: "roms")!
        
        let biosData = NSData(contentsOfFile: biosPath)!
        bios = [UInt8](count: 256, repeatedValue: 0)
        biosData.getBytes(&bios, length: 256)
        
        let romData = NSData(contentsOfFile: romPath)!
        rom = [UInt8](count: 32768, repeatedValue: 0)
        romData.getBytes(&rom, length: 32768)
    }
}
