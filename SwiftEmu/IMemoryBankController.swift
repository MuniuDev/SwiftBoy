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
    func reset()
}

extension IMemoryBankController {
    func write(address address: UInt16, value: UInt8) {}
    func reset() {}
}

class RawRom : IMemoryBankController {
    var rom: [UInt8]
    
    init(rom: [UInt8]) {
        self.rom = [UInt8](count: 0x8000, repeatedValue: UInt8(0))
        self.rom[0...0x7FFF] = rom[0...0x7FFF]
    }
    
    func read(address address: UInt16) -> UInt8 {
        return rom[Int(address)]
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
    
    init(rom: [UInt8]) {
        type = rom[0x0147]
        romSize = rom[0x0148]
        ramSize = rom[0x0149]
        romByteCount = Int(0x8000) << Int(romSize)
        ramByteCount = Int(0x8000) << Int(ramSize)
        self.rom = [UInt8](count: romByteCount, repeatedValue: UInt8(0))
        self.rom[0..<romByteCount] = rom[0..<romByteCount]
        self.ram = [UInt8](count: ramByteCount, repeatedValue: UInt8(0))
        
        currentRomBank = 0
        currentRamBank = 0
    }
    
    func read(address address: UInt16) -> UInt8 {
        //TODO implement
        return 0
    }
    
    func write(address address: UInt16, value: UInt8) {
        //TODO implement
    }
    
    func reset() {
        //TODO implement
    }
}

func loadRomMBC(name: String) -> IMemoryBankController {
    guard
        let romPath = NSBundle.mainBundle().pathForResource(name, ofType: ".gb", inDirectory: "roms"),
        let romData = NSData(contentsOfFile: romPath)
        else {
            LogE("Failed to load " + name + ".gb rom!")
            exit(-1)
    }
    var rom = [UInt8](count: romData.length, repeatedValue: 0)
    romData.getBytes(&rom, length: romData.length)
    LogI("Rom " + name + ".gb load success.")
    
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