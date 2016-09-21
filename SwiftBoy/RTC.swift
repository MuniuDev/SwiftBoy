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
    
    var baseTimePoint: Int = 0
    
    func restoreRTC(_ cartridgeName: String) {
        // load saved rtc file, if not present create new one
        if createFolderAt("SwiftBoySaves", location: .documentDirectory) {
            var buffer = [UInt8](repeating: 0, count: 4)
            if loadBinaryFile("SwiftBoySaves/" + cartridgeName + ".rtc", location: .documentDirectory, buffer: &buffer) {
                LogD("Succeded to load " + cartridgeName + ".rtc file!")
                baseTimePoint = Int(buffer[0]) << 24 | Int(buffer[1]) << 16 | Int(buffer[2]) << 8 | Int(buffer[3])
                LogD("BTC = " + String(baseTimePoint))
            } else {
                baseTimePoint = Int(Date().timeIntervalSince1970)
                LogD("BTC = " + String(baseTimePoint))
                buffer[0] = UInt8((baseTimePoint & 0xFF000000) >> 24)
                buffer[1] = UInt8((baseTimePoint & 0x00FF0000) >> 16)
                buffer[2] = UInt8((baseTimePoint & 0x0000FF00) >> 8)
                buffer[3] = UInt8(baseTimePoint & 0x000000FF)
                if saveBinaryFile("SwiftBoySaves/" + cartridgeName + ".rtc", location: .documentDirectory, buffer: buffer)
                { LogD("Succeded to save " + cartridgeName + ".rtc file!") }
            }
        }
    }
    
    func latch() {
        let date = Int(Date().timeIntervalSince1970) - baseTimePoint
        LogD(String(date))
        sec = UInt8(date % 60)
        min = UInt8((date/60) % 60)
        hour = UInt8((date/3600) % 24)
        let days = date/86400
        dayLow = UInt8(date & 0xFF)
        dayHigh = dayHigh & 0xFE | UInt8((days >> 8) & 0x01)
        if days >= 512 { dayHigh |= 0x80 }
    }
    
    func read(_ bank: UInt8) -> UInt8 {
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
    
    func write(_ bank: UInt8, value: UInt8) {
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
