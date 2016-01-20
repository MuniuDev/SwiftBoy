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

