//
//  ViewController.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 08.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Cocoa

class EmulatorViewController: NSViewController {

    // device IO
    @IBOutlet weak var emuScreen: EmulatorScreen!
    
    var device: GameBoyDevice?

    // debug IO
    @IBOutlet weak var memoryView: NSTableView!
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
    
    @IBAction func step(sender: AnyObject) {
        device?.tic()
        
    }
    
    override func keyDown(theEvent: NSEvent) {
        switch theEvent.keyCode {
        case 126:
            device?.joypad.pressButton(GameBoyJoypad.BTN_UP)
        case 125:
            device?.joypad.pressButton(GameBoyJoypad.BTN_DOWN)
        case 124:
            device?.joypad.pressButton(GameBoyJoypad.BTN_RIGHT)
        case 123:
            device?.joypad.pressButton(GameBoyJoypad.BTN_LEFT)
        case 6:
            device?.joypad.pressButton(GameBoyJoypad.BTN_A)
        case 7:
            device?.joypad.pressButton(GameBoyJoypad.BTN_B)
        case 36:
            device?.joypad.pressButton(GameBoyJoypad.BTN_START)
        case 49:
            device?.joypad.pressButton(GameBoyJoypad.BTN_SELECT)
        default:
           super.keyDown(theEvent)
        }
    }
    
    override func keyUp(theEvent: NSEvent) {
        switch theEvent.keyCode {
        case 126:
            device?.joypad.releaseButton(GameBoyJoypad.BTN_UP)
        case 125:
            device?.joypad.releaseButton(GameBoyJoypad.BTN_DOWN)
        case 124:
            device?.joypad.releaseButton(GameBoyJoypad.BTN_RIGHT)
        case 123:
            device?.joypad.releaseButton(GameBoyJoypad.BTN_LEFT)
        case 6:
            device?.joypad.releaseButton(GameBoyJoypad.BTN_A)
        case 7:
            device?.joypad.releaseButton(GameBoyJoypad.BTN_B)
        case 36:
            device?.joypad.releaseButton(GameBoyJoypad.BTN_START)
        case 49:
            device?.joypad.releaseButton(GameBoyJoypad.BTN_SELECT)
        default:
            super.keyUp(theEvent)
        }
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

        emuScreen.drawScreen(device!.ppu.getBuffer())
        memoryView.reloadData()
        
        dispatch_async(dispatch_get_main_queue(), updateInfo)
    }
}

