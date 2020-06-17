//
//  StretchingController.swift
//  TendApp WatchKit Extension
//
//  Created by Jose Deyvid on 17/06/20.
//  Copyright © 2020 Mateus Augusto M Ferreira. All rights reserved.
//

import UIKit
import WatchKit

class StretchingController: WKInterfaceController {

    @IBOutlet weak var timerBeforeStartStretching: WKInterfaceTimer!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        timerBeforeStartStretching.setDate(Date(timeIntervalSinceNow: 4))
        timerBeforeStartStretching.start()
        
    }
    
    override func willActivate() {
        
    }
}
