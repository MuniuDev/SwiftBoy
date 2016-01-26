//
//  AppDelegate.swift
//  SwiftBoy
//
//  Created by Michal Majczak on 08.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  

  let device: GameBoyDevice
  
  @IBAction func openRom(sender: NSMenuItem) {
    print("open rom action")
    let dialog = NSOpenPanel()
    dialog.worksWhenModal = true
    dialog.allowsMultipleSelection = false
    dialog.canChooseDirectories = false
    dialog.resolvesAliases = true
    dialog.title = "Open ROM..."
    dialog.message = "Open the rom file you want to play."
    dialog.runModal()
    guard
      let url = dialog.URL?.absoluteURL
      else {
        print("Loading canceled")
        return;
    }
    
    device.reset()
    if device.loadRom(url) {
      device.start()
    } else {
      print("Unsupported ROM format!")
    }
  }
  
  override init() {
    device = GameBoyDevice()
    super.init()
  }
  
  func applicationDidFinishLaunching(aNotification: NSNotification) {
    // Insert code here to initialize your application
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }
  
  // terminate when the window closes
  func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
    return true;
  }

}

