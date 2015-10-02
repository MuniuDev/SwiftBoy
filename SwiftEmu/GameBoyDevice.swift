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
    
    //TODO: Allow to load bios and roms with proper functions
    var bios: [UInt8]
    var rom: [UInt8]
    var running: Bool
    
    var queue: dispatch_queue_t
    
    var bp: UInt16
    
    
    init(screen emuScreen: EmulatorScreen) {
        let biosPath = NSBundle.mainBundle().pathForResource("bios", ofType: ".gb", inDirectory: "roms")!
        let biosData = NSData(contentsOfFile: biosPath)!
        bios = [UInt8](count: biosData.length, repeatedValue: 0)
        biosData.getBytes(&bios, length: biosData.length)
        
        let romPath = NSBundle.mainBundle().pathForResource("tetris", ofType: ".gb", inDirectory: "roms")!
        let romData = NSData(contentsOfFile: romPath)!
        rom = [UInt8](count: romData.length, repeatedValue: 0)
        romData.getBytes(&rom, length: romData.length)
        
        self.screen = emuScreen
        self.joypad = GameBoyJoypad()
        self.memory = GameBoyRAM(joypad: joypad, bios: bios,rom: rom)
        self.joypad.registerRAM(memory)
        self.cpu = GameBoyCPU(memory: memory)
        self.ppu = GameBoyPPU(memory: memory)
        
        self.running = false
        
        self.queue = dispatch_queue_create("GameBoyLoop", DISPATCH_QUEUE_SERIAL)
        //start()
        bp = 0xFFFF
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
    
    func loadBios() {
        
    }
    
    func loadRom() {
        
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
    
    
    //TODO: write below functions
    func keyDown(){
        
    }
    
    func keyUp(){
        
    }
}
