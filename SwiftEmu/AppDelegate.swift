//
//  AppDelegate.swift
//  SwiftEmu
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
    var dialog = NSOpenPanel()
    dialog.worksWhenModal = true
    dialog.allowsMultipleSelection = false
    dialog.canChooseDirectories = false
    dialog.resolvesAliases = true
    dialog.title = "Open ROM..."
    dialog.message = "Open the rom file you want to play."
    dialog.runModal()
    let url = dialog.URL?.absoluteURL
    device.reset()
    device.loadRom(url!)
    device.start()
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

