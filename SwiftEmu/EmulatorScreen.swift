//
//  EmulatorScreen.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 08.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Cocoa

extension EmulatorViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return 0xFFFF
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 16
    }
    
    func tableView(tableView: NSTableView, shouldTypeSelectForEvent event: NSEvent, withCurrentSearchString searchString: String?) -> Bool {
        return false
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {

        switch tableColumn!.identifier {
        case "pc":
            let cell = tableView.makeViewWithIdentifier("pc", owner: self) as! NSTableCellView
            cell.textField!.stringValue = "0x" + String(format:"%04X",row)
            return cell
        case "opcode":
            let cell = tableView.makeViewWithIdentifier("opcode", owner: self) as! NSTableCellView
            cell.textField!.stringValue = "0x" + String(format:"%04X",(device!.memory.memory)[row])
            return cell
        case "instruction":
            let cell = tableView.makeViewWithIdentifier("instruction", owner: self) as! NSTableCellView
            cell.textField!.stringValue = device!.cpu.opcodes[Int((device!.memory.memory)[row])].name
            return cell
        default:
            return nil
        }
    }
}

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
    }
    
    func drawScreen(screenBuffer : [UInt8]) {
        for var j = 0; j < scaledHeight; ++j {
            for var i = 0; i < scaledWidth; ++i {
                let hue = CGFloat(255 - screenBuffer[(j/scale)*160+(i/scale)])/CGFloat(255)
                let color = NSColor(calibratedRed: hue, green: hue, blue: hue, alpha: hue ) //CGFloat(1))
                imageRep.setColor(color, atX: i, y: j)
            }
        }
        setNeedsDisplay()
    }

}