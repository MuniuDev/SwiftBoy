//
//  GameBoyPPU.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyPPU {
    
    var memory: GameBoyRAM
    
    init(memory mem: GameBoyRAM) {
        memory = mem;
    }
    
    func reset() {
        
    }
}