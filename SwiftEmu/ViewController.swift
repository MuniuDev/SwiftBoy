//
//  ViewController.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 08.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // device IO
    @IBOutlet weak var emuScreen: EmulatorScreen!
    
    var device: GameBoyDevice?

    // debug IO
    @IBOutlet weak var logField: NSTextField!
    @IBOutlet weak var valueAF: NSTextField!
    @IBOutlet weak var valueBC: NSTextField!
    @IBOutlet weak var valueDE: NSTextField!
    @IBOutlet weak var valueHL: NSTextField!
    @IBOutlet weak var valueSP: NSTextField!
    @IBOutlet weak var valuePC: NSTextField!
    @IBOutlet weak var breakpointValue: NSTextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        device = GameBoyDevice(screen: emuScreen)
        updateInfo()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func press(sender: AnyObject) {
        //emuScreen.paintBG();
    }
    
    @IBAction func step(sender: AnyObject) {
        device?.tic()
        
    }

    @IBAction func run(sender: AnyObject) {
        if device?.running == false {
            device?.start()
        } else {
            device?.running = false
        }
    }
    @IBAction func updateBP(sender: AnyObject) {
        let bp = UInt16(strtoul(breakpointValue.stringValue,nil,16))
        //if bp != nil {
            device?.setBP(bp)
            print("Updated BreakPoint with val = " + String(format:"%04X",bp))
        /*} else {
            print("Failed to parse breakpoint!")
            breakpointValue.stringValue = String(format:"%04X",0)
        }*/
    }
    
    func updateInfo() {
        let AF = device!.cpu.registers.getAF()
        valueAF.stringValue = "0x" + String(format:"%04X",AF)
        let BC = device!.cpu.registers.getBC()
        valueBC.stringValue = "0x" + String(format:"%04X",BC)
        let DE = device!.cpu.registers.getDE()
        valueDE.stringValue = "0x" + String(format:"%04X",DE)
        let HL = device!.cpu.registers.getHL()
        valueHL.stringValue = "0x" + String(format:"%04X",HL)
        let SP = device!.cpu.registers.SP
        valueSP.stringValue = "0x" + String(format:"%04X",SP)
        let PC = device!.cpu.registers.PC
        valuePC.stringValue = "0x" + String(format:"%04X",PC)
        var buff = device!.ppu.getBuffer()
        buff[1000] = 255
        emuScreen.drawScreen(buff)
        
        let q = dispatch_get_main_queue()
        dispatch_async(q, updateInfo)
    }
}

