//
//  GameBoyDevice.swift
//  SwiftBoy
//
//  Created by Michal Majczak on 12.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Foundation
import Dispatch

protocol ProtoEmulatorScreen {
  func copyBuffer(screenBuffer: [UInt8])
}

class GameBoyDevice {

    let joypad: GameBoyJoypad
    let memory: GameBoyRAM
    let cpu: GameBoyCPU
    let ppu: GameBoyPPU
    
    var running: Bool
    var queue: dispatch_queue_t
    var bp: UInt16
    
    // CPU base clock in Hz
    let clock: Int = 4194304
    // CPU instr clock
    lazy var iClock: Int = self.clock/4
    lazy var ticTime: Double = 1.0/Double(self.iClock)
    // aprox. tics in a half of a frame
    lazy var ticLoopCount: Int = self.iClock/120
    
    init() {
        self.joypad = GameBoyJoypad()
        self.memory = GameBoyRAM(joypad: joypad)
        self.joypad.registerRAM(memory)
        self.cpu = GameBoyCPU(memory: memory)
        self.ppu = GameBoyPPU(memory: memory)
        self.queue = dispatch_queue_create("GameBoyLoop", DISPATCH_QUEUE_SERIAL)
        self.running = false
        self.bp = 0xFFFF
      
        fastBootStrap()
    }
  
    func setScreen(screen: ProtoEmulatorScreen) {
        self.ppu.setScreen(screen)
    }
  
    func loadRom(name: NSURL) -> Bool {
        guard
            let mbc = loadRomMBC(name)
        else {
            return false;
        }
        memory.loadRom(mbc)
        fastBootStrap()
        return true;
    }
    
    func loadBios() {
        fastBootStrap()
    }
    
    func setBP(point: UInt16) {
        bp = point
    }
  
    func stepTic() {
        var delta = cpu.timer.getMTimer()
        cpu.tic()
        delta = cpu.timer.getMTimer() - delta
        ppu.tic(delta)
    }
  
    func tic() {
        
        let start = NSDate().timeIntervalSince1970
      
        var count: Int = 0
        while count < ticLoopCount {
            var delta = cpu.timer.getMTimer()
            cpu.tic()
            delta = cpu.timer.getMTimer() - delta
            ppu.tic(delta)
            count += Int(delta)
            if cpu.registers.PC == bp { running = false }
        }
        
        let elapsed = NSDate().timeIntervalSince1970 - start
        
        if running {
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * (ticTime * Double(count) - elapsed)))
            dispatch_after(time, queue, tic)
        }
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
            self.tic()
        }
    }
    
    func reset() {
        running = false
        dispatch_barrier_sync(queue, {});
        memory.clear()
        cpu.reset()
        ppu.reset()
        loadBios()
    }
}
