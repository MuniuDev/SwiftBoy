//
//  EmulatorScreen.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 08.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Cocoa

class EmulatorScreen: NSImageView {
    
    let imageRep : NSBitmapImageRep
    let scale : Int
    let scaledWidth : Int
    let scaledHeight : Int
    
    required init?(coder aDecoder: NSCoder) {
        scale = Int(NSScreen.mainScreen()!.backingScaleFactor)
        scaledWidth = 160 * scale
        scaledHeight = 144 * scale
        imageRep = NSBitmapImageRep(bitmapDataPlanes: nil,
            pixelsWide: scaledWidth,
            pixelsHigh: scaledHeight,
            bitsPerSample: 8,
            samplesPerPixel: 3,
            hasAlpha: false,
            isPlanar: false,
            colorSpaceName: NSCalibratedRGBColorSpace,
            bytesPerRow: 0, bitsPerPixel: 0)!
        
        //super
        super.init(coder: aDecoder)
        image = NSImage(size: NSSize(width: scaledWidth, height: scaledHeight))
        image!.addRepresentation(imageRep)
        paintBG();
    }
    
    func drawScreen(screenBuffer : [UInt8]) {
        
    }
    
    func paintBG(color : NSColor = NSColor(calibratedRed: CGFloat(1), green: CGFloat(1), blue: CGFloat(1), alpha: CGFloat(1))) {
        for var i = 0; i < scaledWidth; ++i {
            for var j = 0; j < scaledHeight; ++j {
                imageRep.setColor(color, atX: i, y: j)
            }
        }
        setNeedsDisplay()
    }
}