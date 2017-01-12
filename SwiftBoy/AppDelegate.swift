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
  
  @IBAction func openRom(_ sender: NSMenuItem) {
    print("open rom action")
    let dialog = NSOpenPanel()
    dialog.worksWhenModal = true
    dialog.allowsMultipleSelection = false
    dialog.canChooseDirectories = false
    dialog.resolvesAliases = true
    dialog.title = "Open ROM..."

    } else {
      print("Unsupported ROM format!")
    }
  }
  
  override init() {
    device = GameBoyDevice()
    super.init()
  }
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }
  
  // terminate when the window closes
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true;
  }

}

