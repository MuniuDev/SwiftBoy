//
//  MBC1.swift
//  SwiftBoy
//
//  Created by Michal Majczak on 24.02.2016.
//  Copyright © 2016 Michal Majczak. All rights reserved.
//

import Foundation

class MBC1 : IMemoryBankController {
    var rom: [UInt8]
    var ram: [UInt8]
    let type: UInt8
    let romSize: UInt8
    let ramSize: UInt8
    let romByteCount: Int
    let ramByteCount: Int
    let romBankCount: Int
    
    var currentRomBank: UInt8
    var currentRamBank: UInt8
    
    var ramEnabled: Bool
    var ramBankingEnabled: Bool
    
    let cartridgeName: String
    
    init(rom: [UInt8]) {
        type = rom[0x0147]
        romSize = rom[0x0148]
        ramSize = rom[0x0149]
        romBankCount = getROMBankCount(romSize)
        romByteCount = getROMTotalSize(romSize) //Int(0x8000) << Int(romSize)
        ramByteCount = getRAMTotalSize(ramSize) //ramSize == 0 ? 0 : Int(0x2000) << Int(ramSize-1)
        cartridgeName = getCartridgeName(Array<UInt8>(rom[0x0134...0x0143]))
        LogD(cartridgeName)
        self.rom = [UInt8](count: romByteCount, repeatedValue: UInt8(0))
        self.rom[0..<rom.count] = rom[0..<rom.count]
        self.ram = [UInt8](count: ramByteCount, repeatedValue: UInt8(0))
        
        currentRomBank = 1
        currentRamBank = 0
        ramEnabled = false
        ramBankingEnabled = false
        
        loadRAM()
    }
    
    func read(address address: UInt16) -> UInt8 {
        switch Int(address) {
        case 0x0000...0x3FFF:
            return rom[Int(address)]
        case 0x4000...0x7FFF: // access rom bank
            return rom[Int(address) + 0x4000*(Int(currentRomBank) - 1)]
        case 0xA000...0xBFFF: // access ram bank
            if ramSize != 0 && ramEnabled {
                return ram[Int(address - 0xA000 + 0x2000*UInt16(currentRamBank))]
            }
        default:
            LogE("Invalid read in MBC1!")
            exit(-1)
        }
        return 0xFF
    }
    
    func write(address address: UInt16, value: UInt8) {
        switch Int(address) {
        case 0x0000...0x1FFF: // if value = 0x0A enable RAM else disable RAM
            // save ram when ram gets disabled
            if ramEnabled && value & 0x0F != 0x0A { saveRAM() }
            ramEnabled = (value & 0x0F == 0x0A)
        case 0x2000...0x3FFF: // value in range 0x01...0x1F selects lower 5-bits of ROM bank, 0x00 is translated to 0x01
            currentRomBank = (currentRomBank & 0x60) | (value & 0x1F)
            if value & 0x1F == 0x00 { currentRomBank += 1 }
        case 0x4000...0x5FFF: // value in range 0x00...0x03 selects higher 2 bits of ROM bank or specify RAM bank if RAM banking is enabled
            if ramBankingEnabled {
                currentRamBank = value & 0x03
            } else {
                currentRomBank = (currentRomBank & 0x1F) | ((value & 0x03) << 5)
            }
        case 0x6000...0x7FFF: // if value is 0x01 RAM banking is enabled, else it's disabled
            ramBankingEnabled = (value & 0x01 == 0x01)
            if !ramBankingEnabled { currentRamBank = 0 }
        case 0xA000...0xBFFF:
            if ramSize != 0 && ramEnabled {
                ram[Int(address - 0xA000 + 0x2000*UInt16(currentRamBank))] = value
            }
        default:
            LogE("Invalid write in MBC1!")
            exit(-1)
        }
    }
    
    func saveRAM() {
        // make sure it's battery backed up
        if ramSize != 0 && type == 0x03
            && createFolderAt("SwiftBoySaves", location: .DocumentDirectory) {
            if saveBinaryFile("SwiftBoySaves/" + cartridgeName + ".sav", location: .DocumentDirectory, buffer: ram)
            { LogD("Succeded to save " + cartridgeName + ".sav save file!") }
        }
    }
    
    func loadRAM() {
        // make sure it's battery backed up
        if ramSize != 0 && type == 0x03 {
            if loadBinaryFile("SwiftBoySaves/" + cartridgeName + ".sav", location: .DocumentDirectory, buffer: &ram)
            { LogD("Succeded to load " + cartridgeName + ".sav save file!") }
        }
    }
    
    func getDMAData(address address: UInt16, size: UInt16) -> [UInt8] {
        var ret = [UInt8](count: Int(size), repeatedValue: UInt8(0))
        ret[0..<Int(size)] = ram[ Int(address - 0xA000)..<Int(address - 0xA000 + size)]
        return ret
    }
    
    func reset() {
        self.ram = [UInt8](count: ramByteCount, repeatedValue: UInt8(0))
        currentRomBank = 1
        currentRamBank = 0
        ramEnabled = false
        ramBankingEnabled = false
    }
}