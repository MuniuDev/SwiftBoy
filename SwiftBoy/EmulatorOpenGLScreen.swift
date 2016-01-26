//
//  EmulatorOpenGLScreen.swift
//  SwiftBoy
//
//  Created by Michal Majczak on 19.01.2016.
//  Copyright © 2016 Michal Majczak. All rights reserved.
//

import Cocoa
import GLUT

class EmulatorOpenGLScreen: NSOpenGLView, ProtoEmulatorScreen {

  let screenWidth = 160
  let screenHeight = 144
  let texSize: Int32 = 256
  
  var textureName = GLuint()
  var textureData: [GLubyte]
  
  required init?(coder aDecoder: NSCoder) {
    textureData = [GLubyte](count: Int(texSize*texSize)*4, repeatedValue: GLubyte(0))
    super.init(coder: aDecoder)
  }
  
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
  
  override func prepareOpenGL() {
    super.prepareOpenGL()
    // some init gl code here
    
    glGenTextures(1, &textureName);
    glBindTexture(UInt32(GL_TEXTURE_2D), textureName);
    glTexParameteri(UInt32(GL_TEXTURE_2D),UInt32(GL_TEXTURE_MIN_FILTER),GL_NEAREST);
    glTexParameteri(UInt32(GL_TEXTURE_2D),UInt32(GL_TEXTURE_MAG_FILTER),GL_NEAREST);
    glTexImage2D(UInt32(GL_TEXTURE_2D), 0, Int32(GL_RGBA), texSize, texSize, 0, UInt32(GL_RGBA), UInt32(GL_UNSIGNED_INT), textureData);
  }
  
  override func reshape() {
    //TODO viewport reshaping
  }
  
  override func drawRect(dirtyRect: NSRect) {
    glClearColor(0, 0, 0, 0);
    glClear(UInt32(GL_COLOR_BUFFER_BIT))
    
    glEnable(UInt32(GL_TEXTURE_2D));
    glActiveTexture(UInt32(GL_TEXTURE0))
    glBindTexture(UInt32(GL_TEXTURE_2D), textureName);
    glTexImage2D(UInt32(GL_TEXTURE_2D), 0, Int32(GL_RGBA), texSize, texSize, 0, UInt32(GL_RGBA), UInt32(GL_UNSIGNED_BYTE), textureData);
    
    let cord_right = Float(screenWidth)/Float(texSize)
    let cord_down = Float(screenHeight)/Float(texSize)
    
    glBegin(UInt32(GL_TRIANGLE_STRIP));
    glTexCoord2f(0.0, cord_down); glVertex2f(-1.0, -1.0);
    glTexCoord2f(cord_right, cord_down); glVertex2f(1.0, -1.0);
    glTexCoord2f(0.0, 0.0); glVertex2f(-1.0, 1.0);
    glTexCoord2f(cord_right, 0.0); glVertex2f(1.0, 1.0);
    glEnd();
    
    glDisable(UInt32(GL_TEXTURE_2D))
    glFlush();
  }
  
  func copyBuffer(screenBuffer: [UInt8]) {
    for var j = 0; j < screenHeight; ++j {
      for var i = 0; i < screenWidth; ++i {
        let hue = 255 - screenBuffer[j*screenWidth+i]
        textureData[(j*Int(texSize)+i)*4] = GLubyte(hue)
        textureData[(j*Int(texSize)+i)*4+1] = GLubyte(hue)
        textureData[(j*Int(texSize)+i)*4+2] = GLubyte(hue)
        textureData[(j*Int(texSize)+i)*4+3] = 255;
      }
    }
    needsDisplay = true
  }
}
