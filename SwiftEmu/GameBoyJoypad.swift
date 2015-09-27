//
//  GameBoyJoypad.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 27.09.2015.
//  Copyright © 2015 Michal Majczak. All rights reserved.
//

import Foundation

class GameBoyJoypad {
    
    //TODO implement joypad
    func getKeyValue(mask: UInt8) -> UInt8 {
        return mask == 0x10 ? 0xDF : 0xEF
    }
    
}