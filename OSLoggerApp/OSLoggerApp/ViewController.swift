//
//  ViewController.swift
//  OSLoggerApp
//
//  Created by Rodrigo Aparecido Morbach on 13/02/19.
//  Copyright © 2019 Rodrigo Aparecido Morbach. All rights reserved.
//

import UIKit
import OSLogger

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        OSLogger.debug("123", "123")
        OSLogger.error("Message %@", "12")
    }


}

