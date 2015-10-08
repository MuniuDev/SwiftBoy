//
//  GameBoyDevice.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation
import Dispatch

class GameBoyDevice {
    
    let screen: EmulatorScreen
    let joypad: GameBoyJoypad
    let memory: GameBoyRAM
    let cpu: GameBoyCPU
    let ppu: GameBoyPPU
    
    var running: Bool
    var queue: dispatch_queue_t
    var bp: UInt16
    
    init(screen emuScreen: EmulatorScreen) {
        self.screen = emuScreen
        self.joypad = GameBoyJoypad()
        self.memory = GameBoyRAM(joypad: joypad)
        self.joypad.registerRAM(memory)
        self.cpu = GameBoyCPU(memory: memory)
        self.ppu = GameBoyPPU(memory: memory)
        self.queue = dispatch_queue_create("GameBoyLoop", DISPATCH_QUEUE_SERIAL)
        self.running = false
        self.bp = 0xFFFF
        
        loadBios()
        loadRom("tetris") //FIXME temporary rom loading
    }
    
    func loadRom(name: String) {
        let mbc = loadRomMBC(name)
        memory.loadRom(mbc)
    }
    
    func loadBios() {
        guard
            let biosPath = NSBundle.mainBundle().pathForResource("bios", ofType: ".gb", inDirectory: "roms"),
            let biosData = NSData(contentsOfFile: biosPath)
            else {
                LogW("WARNING! No bios file found! Running fast bios...")
                fastBootStrap() // if failed to load bootstrap file, simulate it
                return
        }
        var bios = [UInt8](count: biosData.length, repeatedValue: 0)
        biosData.getBytes(&bios, length: biosData.length)
        memory.loadBios(bios)
        LogI("Bios load success.")
    }
    
    func setBP(point: UInt16) {
       bp = point
    }
    
    func tic() {
        var delta = cpu.timer.getMTimer()
        cpu.tic()
        delta = cpu.timer.getMTimer() - delta
        ppu.tic(delta)
        if cpu.registers.PC == bp { running = false }
    }
    
    func fastBootStrap() {
        //cpu.memory.unmapBios()
        // registers state after bootstrap
        cpu.registers.A = 0x01
        cpu.registers.F = 0xB0
        //cpu.registers.B = 0x00
        cpu.registers.C = 0x13
        //cpu.registers.D = 0x00
        cpu.registers.E = 0xD8
        cpu.registers.SP = 0xFFFE
        cpu.registers.PC = 0x100
        // memory state after bootstrap
        cpu.memory.write(address: 0xFF10, value: 0x80)
        cpu.memory.write(address: 0xFF11, value: 0xBF)
        cpu.memory.write(address: 0xFF12, value: 0xF3)
        cpu.memory.write(address: 0xFF14, value: 0xBF)
        cpu.memory.write(address: 0xFF16, value: 0x3F)
        cpu.memory.write(address: 0xFF19, value: 0xBF)
        cpu.memory.write(address: 0xFF1A, value: 0x7F)
        cpu.memory.write(address: 0xFF1B, value: 0xFF)
        cpu.memory.write(address: 0xFF1C, value: 0x9F)
        cpu.memory.write(address: 0xFF1E, value: 0xBF)
        cpu.memory.write(address: 0xFF20, value: 0xFF)
        cpu.memory.write(address: 0xFF23, value: 0xBF)
        cpu.memory.write(address: 0xFF24, value: 0x77)
        cpu.memory.write(address: 0xFF25, value: 0xF3)
        cpu.memory.write(address: 0xFF26, value: 0xF1)
        cpu.memory.write(address: 0xFF40, value: 0x91)
        cpu.memory.write(address: 0xFF47, value: 0xFC)
        cpu.memory.write(address: 0xFF48, value: 0xFF)
        cpu.memory.write(address: 0xFF49, value: 0xFF)
    }
    
    func start() {
        running = true
        dispatch_async(queue) {
            while self.running {
                self.tic()
            }
        }
    }
    
    func reset() {
        running = false
        memory.clear()
        cpu.reset()
        ppu.reset()
    }
}
