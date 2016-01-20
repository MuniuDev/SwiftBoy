//
//  IMemoryBankController.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 08.10.2015.
//  Copyright © 2015 Michal Majczak. All rights reserved.
//

import Foundation

protocol IMemoryBankController {
    func write(address address: UInt16, value: UInt8)
    func read(address address: UInt16) -> UInt8
    func getDMAData(address address: UInt16, size: UInt16) -> [UInt8]
    func reset()
}

extension IMemoryBankController {
    func write(address address: UInt16, value: UInt8) {}
    func reset() {}
    //func getDMAData(address address: UInt16, size: UInt16) -> [UInt8] {return [UInt8]()}
}

class RawRom : IMemoryBankController {
    var rom: [UInt8]
    
    init(rom: [UInt8]) {
        self.rom = [UInt8](count: 0xC000, repeatedValue: UInt8(0))
        self.rom[0...0x7FFF] = rom[0...0x7FFF]
    }
    
    func write(address address: UInt16, value: UInt8) {
        if address < 0x8000 { return }
        rom[Int(address)] = value
    }
    
    func read(address address: UInt16) -> UInt8 {
        return rom[Int(address)]
    }
    
    func getDMAData(address address: UInt16, size: UInt16) -> [UInt8] {
        var ret = [UInt8](count: Int(size), repeatedValue: UInt8(0))
        ret[0..<Int(size)] = rom[ Int(address)..<Int(address + size)]
        return ret
    }
}

class MBC1 : IMemoryBankController {
    var rom: [UInt8]
    var ram: [UInt8]
    let type: UInt8
    let romSize: UInt8
    let ramSize: UInt8
    let romByteCount: Int
    let ramByteCount: Int
    
    var currentRomBank: UInt8
    var currentRamBank: UInt8
    
    var ramEnabled: Bool
    var ramBankingEnabled: Bool
    
    init(rom: [UInt8]) {
        type = rom[0x0147]
        romSize = rom[0x0148]
        ramSize = rom[0x0149]
        romByteCount = Int(0x8000) << Int(romSize)
        ramByteCount = ramSize == 0 ? 0 : Int(0x2000) << Int(ramSize-1)
        self.rom = [UInt8](count: romByteCount, repeatedValue: UInt8(0))
        self.rom[0..<rom.count] = rom[0..<rom.count]
        self.ram = [UInt8](count: ramByteCount, repeatedValue: UInt8(0))
        
        currentRomBank = 1
        currentRamBank = 0
        ramEnabled = false
        ramBankingEnabled = false
    }
    
    func read(address address: UInt16) -> UInt8 {
        switch Int(address) {
        case 0x0000...0x3FFF:
            return rom[Int(address)]
        case 0x4000...0x7FFF: // access rom bank
            return rom[Int(address) + 0x4000*(Int(currentRomBank) - 1)]
        case 0xA000...0xBFFF: // access ram bank
            if ramSize != 0 {
                return ram[Int(address - 0xA000 + 0x2000*UInt16(currentRamBank))]
            }
        default:
            LogE("Invalid read in MBC1!")
            exit(-1)
        }
        return 0
    }
    
    func write(address address: UInt16, value: UInt8) {
        switch Int(address) {
        case 0x0000...0x1FFF: // if value = 0x0A enable RAM else disable RAM
            ramEnabled = (value == 0x0A)
        case 0x2000...0x3FFF: // value in range 0x01...0x1F selects lower 5-bits of ROM bank, 0x00 is translated to 0x01
            if value == 0x00 {
                currentRomBank |= (value+1) & 0x1F
            } else {
                currentRomBank = (currentRomBank & 0x60) | value & 0x0F
            }
        case 0x4000...0x5FFF: // value in range 0x00...0x03 selects higher 2 bits of ROM bank or specify RAM bank if RAM banking is enabled
            if ramEnabled && ramBankingEnabled {
                currentRamBank = value & 0x03
            } else {
                currentRomBank = (currentRomBank & 0x1F) | (value & 0x03) << 4
            }
        case 0x6000...0x7FFF: // if value is 0x01 RAM banking is enabled, else it's disabled
            ramBankingEnabled = (value == 0x01)
        case 0xA000...0xBFFF:
            if ramSize != 0 {
            ram[Int(address - 0xA000 + 0x2000*UInt16(currentRamBank))] = value
            }
        default:
            LogE("Invalid write in MBC1!")
            exit(-1)
        }
    }
    
    func getDMAData(address address: UInt16, size: UInt16) -> [UInt8] {
        var ret = [UInt8](count: Int(size), repeatedValue: UInt8(0))
        ret[0..<Int(size)] = ram[ Int(address - 0xA000)..<Int(address - 0xA000 + size)]
        return ret
    }
    
    func reset() {
        self.ram = [UInt8](count: ramByteCount, repeatedValue: UInt8(0))
        currentRomBank = 0
        currentRamBank = 0
        ramEnabled = false
        ramBankingEnabled = false
    }
}

func loadRomMBC(name: NSURL) -> IMemoryBankController {
  let romPath = name;
    guard
        //let romPath = NSBundle.mainBundle().pathForResource(name, ofType: ".gb", inDirectory: "roms"),
        let romData = NSData(contentsOfURL: romPath)
        else {
            LogE("Failed to load " + name.absoluteString + ".gb rom!")
            exit(-1)
    }
    var rom = [UInt8](count: romData.length, repeatedValue: 0)
    romData.getBytes(&rom, length: romData.length)
    LogI("Rom " + name.absoluteString + ".gb load success.")
    
    switch rom[0x0147] {
    case 0:
        return RawRom(rom: rom)
    case 0x01...0x03:
        return MBC1(rom: rom)
    default:
        LogE("Failed to load proper MBC!")
        exit(-1)
    }
}