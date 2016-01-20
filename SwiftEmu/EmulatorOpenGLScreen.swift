//
//  EmulatorOpenGLScreen.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 19.01.2016.
//  Copyright © 2016 Michal Majczak. All rights reserved.
//

import Cocoa
import GLUT

protocol ProtoEmulatorScreen {
  func copyBuffer(screenBuffer: [UInt8])
}

class EmulatorOpenGLScreen: NSOpenGLView, ProtoEmulatorScreen {
  
  override var needsPanelToBecomeKey: Bool{
    get {
      return true
    }
  }
  override var acceptsFirstResponder: Bool {
    get {
      return true
    }
  }
  
  override func drawRect(dirtyRect: NSRect) {
    glClearColor(0, 0, 0, 0);
    glClear(UInt32(GL_COLOR_BUFFER_BIT))
    glColor3f(1.0, 0.85, 0.35)
    glBegin(UInt32(GL_TRIANGLES))
    glVertex3f(  0.0,  1, 0.0)
    glVertex3f( -1, 0, 0.0)
    glVertex3f(  1, 0 ,0.0)
    glEnd()
    glFlush();
  }
  
  func copyBuffer(screenBuffer: [UInt8]) {
    // TODO implement
  }
}
