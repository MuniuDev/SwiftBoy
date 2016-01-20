//
//  EmulatorViewController.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 19.01.2016.
//  Copyright © 2016 Michal Majczak. All rights reserved.
//

import Cocoa

class EmulatorViewController: NSViewController {

  @IBOutlet var emuScreen: EmulatorOpenGLScreen!
  
  var device: GameBoyDevice?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    device = (NSApplication.sharedApplication().delegate as! AppDelegate).device
    updateInfo()
  }
  
  override var representedObject: AnyObject? {
    didSet {
      // Update the view, if already loaded.
    }
  }
  
  func updateInfo() {
    emuScreen.copyBuffer(device!.ppu.getBuffer())
    
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * 0.016))
    dispatch_after(time, dispatch_get_main_queue(), updateInfo)
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
  
}