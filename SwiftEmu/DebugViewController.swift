//
//  DebugViewController.swift
//  SwiftEmu
//
//  Created by Michal Majczak on 26.09.2015.
//  Copyright © 2015 Michal Majczak. All rights reserved.
//

import Cocoa

class DebugViewController: NSViewController {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func updateInfo() {
        // update program info
    }
}

