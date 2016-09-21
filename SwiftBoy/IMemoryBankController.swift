//
//  IMemoryBankController.swift
//  SwiftBoy
//
//  Created by Michal Majczak on 08.10.2015.
//  Copyright © 2015 Michal Majczak. All rights reserved.
//

import Foundation

// This protocol defines API for any MBC that is used in SwiftBoy
protocol IMemoryBankController {
    func write(address: UInt16, value: UInt8)
    func read(address: UInt16) -> UInt8
    func getDMAData(address: UInt16, size: UInt16) -> [UInt8]
    func reset()
    func saveRAM()
    func loadRAM()
}

extension IMemoryBankController {
    func reset() {}
    func saveRAM() {}
    func loadRAM() {}
}

// Cartridge types:
// 0x00 - Raw ROM cartridge
// 0x01 - MBC1
// 0x02 - MBC1 + RAM
// 0x03 - MBC1 + RAM + Battery
// 0x05 - MBC2
// 0x06 - MBC2 + RAM + Battery
// 0x08 - ROM + RAM
// 0x09 - ROM + RAM + Battery
// 0x0B - MMM01
// 0x0C - MMM01 + RAM
// 0x0D - MMM01 + RAM + Battery
// 0x0F - MBC3 + RTC + Battery
// 0x10 - MBC3 + RAM + RTC + Battery
// 0x11 - MBC3
// 0x12 - MBC3 + RAM
// 0x13 - MBC3 + RAM + Battery
// 0x19 - MBC5
// 0x1A - MBC5 + RAM
// 0x1B - MBC5 + RAM + Battery
// 0x1C - MBC5 + Rumble
// 0x1D - MBC5 + RAM + Rumble
// 0x1E - MBC5 + RAM + Battery + Rumble
// 0x20 - MBC6 + RAM + Battery
// 0x22 - MBC7 + RAM + Battery + Accelerometer
// 0xFC - Pocket Camera
// 0xFD - BANDAI TAMA5
// 0xFE - HuC3
// 0xFF - HuC1 + RAM + Battery

// Function for loading rom images. It returns propper MBC controller populated with rom data
func loadRomMBC(_ name: URL) -> IMemoryBankController? {
  let romPath = name;
    guard
        let romData = try? Data(contentsOf: romPath)
        else {
            LogE("Failed to load " + name.absoluteString + ".gb rom!")
            exit(-1)
    }
    var rom = [UInt8](repeating: 0, count: romData.count)
    (romData as NSData).getBytes(&rom, length: romData.count)
    LogI("Rom " + name.absoluteString + ".gb load success.")
    LogD("Rom type: 0x" + String(format:"%02X", rom[0x0147]))
    switch rom[0x0147] {
    case 0:
        return RawRom(rom: rom)
    case 0x01...0x03:
        return MBC1(rom: rom)
    case 0x0F...0x13:
        return MBC3(rom: rom)
    case 0x19...0x1E:
        return MBC5(rom: rom)
    default:
        LogE("Failed to load proper MBC!")
        return nil
    }
}

// Function for calculating rom bank count based on rom header data
func getROMBankCount(_ romSizeRegiserVal: UInt8 ) -> Int {
    if romSizeRegiserVal > 0x08 {
        LogE("Too big rom size, possibly broken rom image.")
        return -1
    }
    return Int(2 << romSizeRegiserVal)
}

// Function for calculating ram bank count based on rom header data
func getRAMBankCount(_ ramSizeRegiserVal: UInt8 ) -> Int {
    var count = -1
    switch ramSizeRegiserVal {
    case 0x00: count = 0
    case 0x01: count = 1
    case 0x02: count = 1
    case 0x03: count = 4
    case 0x04: count = 16
    case 0x05: count = 8
    default:
        LogE("Too big ram size, possibly broken rom image.")
    }
    return count
}

// Function for calculating rom total size based on rom header data
func getROMTotalSize(_ romSizeRegiserVal: UInt8 ) -> Int {
    if romSizeRegiserVal > 0x08 {
        LogE("Too big rom size, possibly broken rom image.")
        return -1
    }
    return getROMBankCount(romSizeRegiserVal) * 16 * 1024
}

// Function for calculating brom total size based on rom header data
func getRAMTotalSize(_ ramSizeRegiserVal: UInt8 ) -> Int {
    var count = Int(0)
    switch ramSizeRegiserVal {
    case 0x00: count = 0
    case 0x01: count = 2
    case 0x02: count = 8
    case 0x03: count = 32
    case 0x04: count = 128
    case 0x05: count = 64
    default:
        LogE("Too big ram size, possibly broken rom image.")
        return -1
    }
    return count*1024
}

// Function for extracting cartridge name based on rom header data
func getCartridgeName(_ nameData: [UInt8]) -> String {
    var name = String()
    for byte in nameData {
        if byte == 0 { break; }
        name.append(Character(UnicodeScalar(byte)))
    }
    return name
}
