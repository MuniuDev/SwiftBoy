//
//  ViewController.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 08.09.2015.
//  Copyright (c) 2015 Michal Majczak. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    // device IO
    @IBOutlet weak var emuScreen: EmulatorScreen!
    
    var device: GameBoyDevice?

    // debug IO
    @IBOutlet weak var logField: NSTextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        device = GameBoyDevice(screen: emuScreen)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func press(sender: AnyObject) {
        emuScreen.paintBG();
    }
    
    @IBAction func step(sender: AnyObject) {
        device?.tic()
    }

    @IBAction func run(sender: AnyObject) {
        if device?.running == false {
            device?.start()
        } else {
            device?.running = false
        }
    }
}

