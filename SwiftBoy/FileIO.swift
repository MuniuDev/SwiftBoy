//
//  FileIO.swift
//  SwiftBoy
//
//  Created by Michal Majczak on 02.03.2016.
//  Copyright © 2016 Michal Majczak. All rights reserved.
//

import Foundation

func createFolderAt(folder: String, location: NSSearchPathDirectory ) -> Bool {
    guard let locationUrl = NSFileManager().URLsForDirectory(location, inDomains: .UserDomainMask).first else { return false }
    do {
        try NSFileManager().createDirectoryAtURL(locationUrl.URLByAppendingPathComponent(folder), withIntermediateDirectories: false, attributes: nil)
        return true
    } catch let error as NSError {
        // folder already exists return true
        if error.code == 17 || error.code == 516 {
            //LogD(folder + " already exists at " + locationUrl.absoluteString + " , ignoring")
            return true
        }
        LogE(folder + " couldn't be created at " + locationUrl.absoluteString)
        LogE(error.description)
        return false
    }
}

func saveBinaryFile(name: String, location: NSSearchPathDirectory, buffer: [UInt8]) -> Bool {
    guard
        let locationURL = NSFileManager().URLsForDirectory(location, inDomains: .UserDomainMask).first
        else {
            LogE("Failed to resolve path while saving file.")
            return false
    }
    let fileURL = locationURL.URLByAppendingPathComponent(name)
    let data = NSData(bytes: buffer, length: buffer.count)
    return data.writeToURL(fileURL, atomically: true)
}

func loadBinaryFile(name: String, location: NSSearchPathDirectory, inout buffer: [UInt8]) -> Bool {
    guard
        let locationURL = NSFileManager().URLsForDirectory(location, inDomains: .UserDomainMask).first
        else {
            LogE("Failed to find " + name + " file!")
            return false
    }
    
    let fileURL = locationURL.URLByAppendingPathComponent(name)
    
    guard
        let ramData = NSData(contentsOfURL: fileURL)
        else {
            LogD("Failed to load " + name + " file!")
            return false
    }
    ramData.getBytes(&buffer, length: ramData.length)
    return true
}