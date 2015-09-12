//
//  GameBoyDevice.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyDevice {
    
    let screen : EmulatorScreen
    let memory : GameBoyRAM
    
    init(screen emuScreen: EmulatorScreen) {
        screen = emuScreen
        memory = GameBoyRAM()
    }
}
