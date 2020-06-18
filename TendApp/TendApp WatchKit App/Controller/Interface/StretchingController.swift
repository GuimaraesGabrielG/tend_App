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

    @IBOutlet weak var timerBeforeStartStretching: WKInterfaceLabel!
    public var myTimer: Timer!
    public var count = 5
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        WKInterfaceDevice.current().play(.start)
        timerBeforeStartStretching.setText("\(count)")
        myTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: teste(myTimer:))

        
        
        
    }
    
    override func willActivate() {
        
    }
    
    func teste(myTimer: Timer) {
        if count > 0 {
            count-=1
            timerBeforeStartStretching.setText("\(count)")
        }
        print(count)
        
        
    }
    
    
}
