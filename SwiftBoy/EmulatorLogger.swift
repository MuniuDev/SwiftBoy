//
//  EmulatorLogger.swift
//  SwiftBoy
//
//  Created by Michal Majczak on 06.10.2015.
//  Copyright © 2015 Michal Majczak. All rights reserved.
//

import Foundation

enum LogLevel: Int {
    case DEBUG = 1
    case INFO
    case WARNING
    case ERROR
}

let currentLogLevel = LogLevel.DEBUG

func LogD(_ msg: String) { Log(LogLevel.DEBUG, msg: msg) }
func LogI(_ msg: String) { Log(LogLevel.INFO, msg: msg) }
func LogW(_ msg: String) { Log(LogLevel.WARNING, msg: msg) }
func LogE(_ msg: String) { Log(LogLevel.ERROR, msg: msg) }

func Log(_ level: LogLevel, msg: String) {
    if currentLogLevel.rawValue <= level.rawValue {
        print("[" + String(describing: level) + "] " + msg)
    }
}
