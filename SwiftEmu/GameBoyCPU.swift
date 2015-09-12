//
//  GameBoyCPU.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyCPU {
    struct GameBoyRegistes {
        //pair AF
        var A : UInt8 = 0
        var F : UInt8 = 0
        //pair BC
        var B : UInt8 = 0
        var C : UInt8 = 0
        //pair DE
        var D : UInt8 = 0
        var E : UInt8 = 0
        //pair HL
        var H : UInt8 = 0
        var L : UInt8 = 0
        
        var PC : UInt16 = 0
        var SP : UInt16 = 0
    }
    
    let registers : GameBoyRegistes
    
    init() {
        registers = GameBoyRegistes()
    }
}