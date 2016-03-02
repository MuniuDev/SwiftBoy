//
//  RTC.swift
//  SwiftBoy
//
//  Created by Michal Majczak on 02.03.2016.
//  Copyright © 2016 Michal Majczak. All rights reserved.
//

import Foundation

class RTC {
    
    var sec: UInt8 = 0
    var min: UInt8 = 0
    var hour: UInt8 = 0
    var dayLow: UInt8 = 0
    var dayHigh: UInt8 = 0
    
    var baseTimePoint: Double = 0.0
    
    func latch() {
        let date = Int(NSDate().timeIntervalSince1970 - baseTimePoint)
        LogD(String(date))
        sec = UInt8(date % 60)
        min = UInt8((date/60) % 60)
        hour = UInt8((date/3600) % 24)
        let days = date/86400
        dayLow = UInt8(date & 0xFF)
        dayHigh = dayHigh & 0xFE | UInt8((days >> 8) & 0x01)
        if days >= 512 { dayHigh |= 0x80 }
    }
    
    func read(bank: UInt8) -> UInt8 {
        switch bank {
        case 0x08: return sec
        case 0x09: return min
        case 0x0A: return hour
        case 0x0B: return dayLow
        case 0x0C: return dayHigh
        default:
            LogE("Invalid RTC access!")
            exit(-1)
        }
    }
    
    func write(bank: UInt8, value: UInt8) {
        switch bank {
        case 0x08: sec = value
        case 0x09: min = value
        case 0x0A: hour = value
        case 0x0B: dayLow = value
        case 0x0C: dayHigh = value
        default:
            LogE("Invalid RTC access!")
            exit(-1)
        }
    }
}
